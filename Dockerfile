# Use a base image with Java and Maven installed
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory
WORKDIR /app

# Copy the project's pom.xml and src folder
COPY pom.xml .
COPY src/ ./src/

# Build the application
RUN mvn clean package -DskipTests

# Use a lightweight Java runtime image
FROM openjdk:17-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/hapi-fhir-jpa-starter-*.jar app.jar

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]
