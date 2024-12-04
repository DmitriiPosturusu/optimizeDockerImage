#Stage 1 build
FROM maven:3.8.5-openjdk-17 as builder

WORKDIR /app

COPY pom.xml /app
RUN mvn dependency:go-offline -B


COPY src /app/src
RUN mvn clean install

#Stage 2 runtime
FROM amazoncorretto:17-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar api.jar

ENTRYPOINT ["java","-Xmx2048M", "-jar", "/app/api.jar"]
