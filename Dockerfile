FROM gradle:7.2-jdk11 AS build
WORKDIR /app

COPY . .
COPY config ./config
COPY src ./src
RUN gradle build -x test --no-daemon


FROM tomcat:9.0.50-jdk11-openjdk
RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/build/libs/class_schedule.war /usr/local/tomcat/webapps/ROOT.war
COPY data.dump /app/data.dump
COPY scripts/pgsql_restore.sh /app/pgsql_restore.sh

# Make the restore script executable
RUN chmod +x /app/pgsql_restore.sh

# Run the restore script before starting Tomcat
RUN /app/pgsql_restore.sh

EXPOSE 8080

CMD ["catalina.sh", "run"]