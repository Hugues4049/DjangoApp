# Utiliser une image de base légère avec Python
FROM python:3.10-slim

# Définir le répertoire de travail
WORKDIR /app

# Installer les dépendances système si nécessaire
RUN apt-get update && apt-get install -y build-essential libpq-dev && rm -rf /var/lib/apt/lists/*

# Copier les fichiers de votre projet dans le conteneur
COPY . .

# Installer les dépendances Python à partir du fichier requirements.txt
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Collecter les fichiers statiques de Django
RUN python manage.py collectstatic --noinput

# Exposer le port sur lequel l'application sera accessible
EXPOSE 8000

# Commande pour démarrer le serveur Django avec Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "my_django_app.wsgi:application"]
