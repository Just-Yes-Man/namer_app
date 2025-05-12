# Usa la imagen oficial de Flutter
FROM cirrusci/flutter:latest

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de tu proyecto Flutter
COPY . .

# Instala las dependencias
RUN flutter pub get

# Compila la app Flutter
RUN flutter build apk --release


# Define el comando por defecto (si aplica)
CMD ["flutter", "run"]
