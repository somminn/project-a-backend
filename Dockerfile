# 1단계: 빌드
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app
COPY . /app
RUN chmod +x gradlew && bash ./gradlew build -x test --no-daemon

# 2단계: 런타임
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]