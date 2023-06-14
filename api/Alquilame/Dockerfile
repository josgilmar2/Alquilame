#FROM eclipse-temurin:17-jre-jammy
#ARG JAR_FILE=target/*.jar
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java", "-jar", "/app.jar"]

FROM maven:3.8.5-openjdk-17
WORKDIR /Alquilame
COPY . .
RUN mvn clean install
RUN mvn dependency:resolve
CMD mvn spring-boot:run