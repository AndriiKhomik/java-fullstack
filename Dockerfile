FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /usr/app/
COPY . .

RUN mvn clean package

FROM tomcat:9.0.50-jdk11
COPY --from=build /usr/app/target/class_schedule.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["/app/entry_point.sh"]