
# Utilise une image de base Java 19
FROM openjdk:19


WORKDIR /app

COPY target/back_conges.jar /app
COPY mysql.properties /app

EXPOSE 8080

CMD ["java", "-jar", "back_conges.jar"]