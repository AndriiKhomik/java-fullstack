FROM tomcat:9.0.50-jdk11

WORKDIR /app

EXPOSE 8080

CMD ["/app/entry_point.sh"]