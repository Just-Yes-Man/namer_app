
FROM cirrusci/flutter:stable


WORKDIR /app


COPY . .

RUN flutter pub get


RUN flutter build web

EXPOSE 5000


CMD ["flutter", "run", "-d", "web-server", "--web-port=5000"]