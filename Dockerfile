
FROM ghcr.io/cirruslabs/flutter:latest

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build web
RUN ls -l build/web  # Comprobación


FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
