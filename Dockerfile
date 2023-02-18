
# Utilise une image de base Java 19
# FROM openjdk:19


# WORKDIR /app

# COPY target/back_conges.jar /app
# COPY mysql.properties /app

# EXPOSE 8080

# CMD ["java", "-jar", "back_conges.jar"]
FROM eclipse-temurin:11-jdk-alpine as build
WORKDIR /workspace/app


COPY .mvn .mvn
COPY pom.xml .
COPY src src


RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

FROM eclipse-temurin:11-jdk-alpine
VOLUME /tmp
ARG DEPENDENCY=/workspace/app/target/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","com.gestion_conge_backend.GestionCongeBackEndApplication"]