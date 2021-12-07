FROM alpine:edge
MAINTAINER baeldung.com
RUN apk add --no-cache openjdk8

WORKDIR /app

ARG JAR_FILE
ADD /target/spring-boot-eureka-1.0.0.jar /app/spring-boot-eureka-1.0.0.jar
ADD /src/main/resources/application.properties /app/application.properties

EXPOSE 8761

ENTRYPOINT ["java","-jar","spring-boot-eureka-1.0.0.jar","--spring.config.location=application.properties"]