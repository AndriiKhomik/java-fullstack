FROM tomcat:9.0.50-jdk11-openjdk AS base

ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB

# Install dependencies
RUN apt-get update && apt-get install -y curl unzip zip postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .
COPY config ./config
COPY src ./src
COPY data.dump /data/data.dump

# Set environment variables for the application
RUN echo "export POSTGRES_USER=${POSTGRES_USER}" >> variables.sh \
    && echo "export POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" >> variables.sh \
    && echo "export POSTGRES_DB=${POSTGRES_DB}" >> variables.sh 

# Make the scripts executable
RUN chmod +x entry_point.sh
RUN chmod +x scripts/pgsql_restore.sh

RUN gradle build -x test
# RUN gradle build -x test --no-daemon

# Restore the PostgreSQL database
RUN pgsql_restore.sh 2024-08-19.dump $POSTGRES_USER $POSTGRES_PASSWORD

# Set the working directory
WORKDIR /usr/local/tomcat/webapps

# Copy the built WAR file from the build stage
RUN cp /app/build/libs/*.war ./ROOT.war

# Set the working directory
WORKDIR /app

EXPOSE 8080

CMD ["catalina.sh", "run"]