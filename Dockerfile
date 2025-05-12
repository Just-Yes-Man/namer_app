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

# Descargar Flutter estable
RUN curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.6-stable.tar.xz && \
    tar xf flutter_linux_3.13.6-stable.tar.xz

ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Verifica la instalación
RUN flutter doctor

WORKDIR /app
COPY . .

# Instalar dependencias
RUN flutter pub get
RUN flutter build web

# Serve stage
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
