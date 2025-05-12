# Etapa 1: Construcción de la app Flutter Web
FROM cirrusci/flutter:stable AS build

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build web

# Etapa 2: Servidor web (nginx)
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

# Opcional: reemplazar el archivo default.conf si necesitas configuración especial
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
