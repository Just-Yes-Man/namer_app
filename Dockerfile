# Usa una imagen de Flutter oficial
FROM cirrusci/flutter:stable AS build

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo pubspec.yaml
COPY pubspec.yaml .

# Instala las dependencias
RUN flutter pub get

# Copia todo el código del proyecto
COPY . .

# Genera el código de la app
RUN flutter build apk --release

# Usa una imagen ligera para producción
FROM openjdk:11-jre-slim

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo APK generado
COPY --from=build /app/build/app/outputs/flutter-apk/app-release.apk /app/

# Expone el puerto necesario (si tu aplicación es un servicio web)
EXPOSE 8080

CMD ["java", "-jar", "app-release.apk"]
