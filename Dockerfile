FROM maven:3.8.4-openjdk-17 AS builder
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY target/accenture-terraform-0.0.1-SNAPSHOT.jar terraform-jearvaldor.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "terraform-jearvaldor.jar"]