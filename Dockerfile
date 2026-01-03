# 1단계: 빌드
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app
COPY gradlew .
COPY gradle gradle
COPY build.gradle* settings.gradle* ./
RUN ./gradlew dependencies --no-daemon
COPY src src
RUN ./gradlew build -x test --no-daemon

# 2단계: 런타임
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /app/build/libs/backend-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]