# Stage 1: Build with Flutter
FROM ubuntu:20.04 as build

# Evitar interacciones con apt
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias
RUN apt-get update && apt-get install -y \
  curl \
  git \
  unzip \
  xz-utils \
  zip \
  libglu1-mesa \
  && apt-get clean

# Instalar Flutter
ENV FLUTTER_VERSION=3.29.3
RUN curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz && \
    tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz && \
    mv flutter /flutter

ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Correr flutter doctor para inicializar bien el entorno
RUN flutter doctor -v

# Crear directorio de trabajo
WORKDIR /app

# Copiar código fuente
COPY . .

# Obtener dependencias
RUN flutter pub get

# Build web
RUN flutter build web

# Stage 2: Servir con Nginx
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html
