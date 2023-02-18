
# Utilise une image de base Java 19
FROM openjdk:19

# Définit un répertoire de travail pour l'application
WORKDIR /app

# Copie les fichiers de l'application dans le répertoire de travail
COPY target/gestion_conge_back-end.jar .

# Copie le fichier de configuration MySQL dans le répertoire de travail
COPY mysql.properties .

# Met à jour le système et installe le client MySQL
RUN apt-get update && apt-get install -y mysql-client

# Expose le port 8080 pour l'application
EXPOSE 8080

# Démarre l'application lorsque le conteneur Docker est lancé
CMD ["java", "-jar", "gestion_conge_back-end.jar"]