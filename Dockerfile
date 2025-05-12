
FROM cirrusci/flutter:stable AS build


WORKDIR /app


COPY pubspec.yaml .


RUN flutter pub get


COPY . .


RUN flutter build apk --release


FROM openjdk:11-jre-slim


WORKDIR /app


COPY --from=build /app/build/app/outputs/flutter-apk/app-release.apk /app/


EXPOSE 8080

CMD ["java", "-jar", "app-release.apk"]
