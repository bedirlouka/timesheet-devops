FROM openjdk:11.0.22
EXPOSE 8085
WORKDIR /app
RUN apt-get update && apt-get install -y curl
RUN curl -o timesheet-devops-1.0.jar -L "http://192.168.56.2:8081/repository/maven-releases/tn/esprit/spring/services/timesheet-devops-1.0.jar"
ENTRYPOINT ["java", "-jar", "timesheet-devops.jar"]
