# Utiliser une image de base avec Python
FROM python:3.10-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de votre projet dans le conteneur
COPY requirements.txt .
COPY . .

# Installer les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Exposer le port sur lequel l'application sera accessible
EXPOSE 8000

# Commande pour démarrer le serveur avec Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "my_django_app.wsgi:application"]
