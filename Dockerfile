FROM maven:3.9.0-eclipse-temurin-17 as build
WORKDIR /app
COPY pom.xml /app/
COPY src/ /app/
RUN mvn clean package

FROM eclipse-tumurin:17.0.6_10-jdk
WORKDIR /app
COPY --from=build /app/target/demoapp.jar /app/
VOLUME [ "/app" ]
EXPOSE 8080
CMD [ "java", "-jar", "demoapp.jar" ]