# syntax=docker/dockerfile:1

FROM openjdk:16-alpine3.13 AS BUILD

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline

COPY src ./src

CMD ["./mvnw", "spring-boot:run"]

FROM openjdk:8-jre

WORKDIR /root

COPY --from=BUILD ./target .

EXPOSE 8080

CMD ["java","-jar","spring-petclinic.jar"]