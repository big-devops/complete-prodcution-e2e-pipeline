FROM maven:3.8.4-openjdk-11-slim as build
WORKDIR /app
COPY pom.xml /app/
COPY src/ /app/
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/demoapp.jar /app/
VOLUME [ "/app" ]
EXPOSE 8080
CMD [ "java", "-jar", "demoapp.jar" ]