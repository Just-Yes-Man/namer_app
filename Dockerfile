# Build stage
FROM ubuntu:20.04 as build

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa

# Descargar e instalar Flutter SDK
RUN curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.6-stable.tar.xz \
    && tar xf flutter.tar.xz \
    && rm flutter.tar.xz \
    && mv flutter /usr/local/flutter

# Configurar el PATH
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Verificar instalación
RUN flutter doctor

WORKDIR /app
COPY . .

# Ejecutar flutter pub get y construir la aplicación
RUN flutter pub get
RUN flutter build web

# Serve stage
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
