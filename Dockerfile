FROM gradle:6.7-jdk14-openj9 AS build
WORKDIR /usr/app/
COPY . .

RUN gradle war --stacktrace

WORKDIR /usr/local/tomcat/webapps/

FROM tomcat:9.0.50-jdk11
COPY --from=build /usr/app/build/libs/class_schedule.war .

EXPOSE 8080

CMD ["catalina.sh", "run"]