FROM fischerscode/flutter AS build


WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build web
RUN ls -l build/web  # Verificación

# Nginx para servir la app
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]