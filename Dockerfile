FROM eclipse-temurin:17
WORKDIR /usr/src/myapp
COPY target/*.jar ./configserver.jar
ENTRYPOINT ["java", "-jar", "configserver.jar"]