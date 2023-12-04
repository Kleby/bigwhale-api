# Estágio de construção
FROM ubuntu:latest AS build

RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven

COPY . /app
WORKDIR /app

RUN mvn clean install

# Estágio de produção
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/target/whale-api.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
