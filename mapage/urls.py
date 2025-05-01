from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),  # <- ceci gère la racine "/"
    path('profil/', views.profil, name='profil'),
    path('parcours-academique/', views.parcours_academique, name='parcours_academique'),
    path('experiences/', views.experiences, name='experiences'),
    path('certifications/', views.certifications, name='certifications'),
    path('projets/', views.projets, name='projets'),
    path('competences/', views.competences, name='competences'),
    path('contact/', views.contact, name='contact'),
]
