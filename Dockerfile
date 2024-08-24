# FROM gradle:6.7-jdk14-openj9 AS build
# WORKDIR /usr/app/
# COPY build.gradle settings.gradle system.properties pre-commit.gradle liquibase.gradle gradlew /usr/app/
# COPY config ./config
# COPY src ./src

# RUN gradle war --stacktrace

# WORKDIR /usr/local/tomcat/webapps/

# FROM tomcat:9.0.50-jdk11
# COPY --from=build /usr/app/build/libs/class_schedule.war .

# EXPOSE 8080

# CMD ["catalina.sh", "run"]

# Use a minimal base image
FROM ubuntu:20.04

# Set the Tomcat version
ENV TOMCAT_VERSION 9.0.50

# Install dependencies
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and extract Tomcat
RUN wget -O /tmp/tomcat.tar.gz https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar xf /tmp/tomcat.tar.gz -C /opt && \
    rm /tmp/tomcat.tar.gz && \
    mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat

# Set environment variables
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Expose Tomcat port
EXPOSE 8080

# Clean up unnecessary files
RUN apt-get purge -y openjdk-11-jdk wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /opt/tomcat/webapps/*

# Start Tomcat
CMD ["catalina.sh", "run"]