# Etapa 1: Compilar Flutter Web
FROM cirrusci/flutter:stable AS build

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build web
RUN ls -l build/web  # Comprobación

# Etapa 2: Nginx para servir archivos estáticos
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
