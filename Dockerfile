#Stage 1 build
FROM maven:3.8.7-eclipse-temurin-17 as builder

WORKDIR /app

COPY pom.xml /app
COPY src /app/src

RUN mvn clean package -DskipTests

#Stage 2 runtime
FROM amazoncorretto:17-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar application.jar

ENTRYPOINT ["java","-Xmx2048M", "-jar", "/application.jar"]