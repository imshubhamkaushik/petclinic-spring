# Use Maven to build the project
FROM maven:3.9.5 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and download dependencies (this helps cache dependencies)
COPY pom.xml .

RUN mvn dependency:go-offline

# Copy the entire project into the container
COPY . .

# Build the Spring Boot Application
RUN mvn clean package -DskipTests

# Use an optimmized runtime image for the final container
FROM openjdk:17-jdk-slim

# Set the working directory 
WORKDIR /app

# Copy te built JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8888 used by Spring Boot
EXPOSE 8888

# Define the entry point for the container
ENTRYPOINT ["java", "-jar", "app.jar"]