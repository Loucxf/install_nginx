#!/bin/bash

# Vérification des privilèges d'administration (root)
if [ "$EUID" -ne 0 ]; then
    echo "Ce script doit être exécuté en tant qu'administrateur (root)."
    exit 1
fi

# Mise à jour des paquets
apt update

# Installation d'Apache
apt install -y nginx

# Démarrage du service Apache
systemctl start nginx

# Vérification de l'état d'Apache
if systemctl is-active --quiet nginx; then
    echo "Nginx a été installé avec succès et est en cours d'exécution."
else
    echo "Une erreur s'est produite lors de l'installation d'Nginx."
fi

# Obtenir l'adresse IP du serveur Apache
server_ip=$(hostname -I | awk '{print $1}')

echo "Adresse IP du serveur Nginx : $server_ip"
