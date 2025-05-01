from django.shortcuts import render

def index(request):
    return render(request, 'index.html')

def profil(request):
    return render(request, 'profil.html')

def parcours_academique(request):
    return render(request, 'parcours-academique.html')

def experiences(request):
    return render(request, 'experiences.html')

def certifications(request):
    return render(request, 'certifications.html')

def projets(request):
    return render(request, 'projets.html')

def competences(request):
    return render(request, 'competences.html')

def contact(request):
    return render(request, 'contact.html')
