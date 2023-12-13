# Verwenden Sie ein OpenJDK-Base-Image
FROM openjdk:11-jre-slim

# Erstellen Sie ein Arbeitsverzeichnis im Container
WORKDIR /app

# Kopieren Sie die kompilierte Spring Boot-Anwendung (JAR-Datei) in das Arbeitsverzeichnis
COPY target/spring-petclinic-3.1.0-SNAPSHOT.jar app/app.jar

# Oeffnen Sie den Port 8081
EXPOSE 8081

# Starten Sie die Anwendung beim Containerstart
CMD ["java", "-jar", "app.jar"]