#FROM alpine:edge
#MAINTAINER baeldung.com
#RUN apk add --no-cache openjdk8

#WORKDIR /app

#ARG JAR_FILE
#ADD /target/spring-boot-eureka-1.0.0.jar /app/spring-boot-eureka-1.0.0.jar
#ADD /src/main/resources/application.properties /app/application.properties

#EXPOSE 8761

#ENTRYPOINT ["java","-jar","spring-boot-eureka-1.0.0.jar","--spring.config.location=application.properties"]
#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package


#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/spring-boot-eureka-1.0.0.jar /usr/local/lib/spring-boot-eureka-1.0.0.jar
COPY --from=build /home/app/src/main/resources/application.properties /usr/local/lib/application.properties
EXPOSE 8761
ENTRYPOINT ["java","-jar","spring-boot-eureka-1.0.0.jar","--spring.config.location=application.properties"]

