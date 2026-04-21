#!/bin/bash

# Vérification des privilèges root
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être exécuté en tant que root" 1>&2
   exit 1
fi

# Variables d'entrée
DNS_LOCAL_IP="127.0.0.1"
DEFAULT_DNS1="8.8.8.8"  # Premier serveur DNS externe (Google)
DEFAULT_DNS2="8.8.4.4"  # Deuxième serveur DNS externe (Google)
DEFAULT_DNS3="1.1.1.1"  # Troisième serveur DNS externe (Cloudflare)
DOMAIN="server.net"  # Domaine à ajouter
LOCAL_IP="172.28.0.2"  # IP locale pour le domaine

# Installer dnsmasq si ce n'est pas déjà fait
echo "Installation de dnsmasq..."
pacman -S --noconfirm dnsmasq

# Configurer dnsmasq
echo "Configuration de dnsmasq..."

# Créer ou modifier le fichier de configuration principale de dnsmasq
cat <<EOL > /etc/dnsmasq.conf
conf-dir=/etc/dnsmasq.d
server=$DEFAULT_DNS1
server=$DEFAULT_DNS2
server=$DEFAULT_DNS3
EOL

# Créer le fichier de configuration pour les sous-domaines
cat <<EOL > /etc/dnsmasq.d/wildcard.conf
address=/$DOMAIN/$LOCAL_IP
EOL

# Configurer le système pour utiliser dnsmasq
echo "Configuration du système pour utiliser dnsmasq..."

# Mettre à jour /etc/resolv.conf pour utiliser dnsmasq en tant que DNS local
cat <<EOL > /etc/resolv.conf
nameserver $DNS_LOCAL_IP
EOL

# Configurer NetworkManager pour utiliser dnsmasq
echo "Configuration de NetworkManager..."
mkdir -p /etc/NetworkManager/conf.d
cat <<EOF > /etc/NetworkManager/conf.d/dns.conf
[main]
dns=dnsmasq
EOF

# Configurer des serveurs DNS globaux dans NetworkManager
cat <<EOF > /etc/NetworkManager/conf.d/dns-servers.conf
[global-dns-domain-*]
servers=$DEFAULT_DNS1,$DEFAULT_DNS2,$DEFAULT_DNS3
EOF

# Redémarrer NetworkManager et dnsmasq
systemctl restart NetworkManager
systemctl restart dnsmasq

# Tester la configuration
echo "Test de la résolution DNS..."
echo "Résolution des sous-domaines:"
dig @127.0.0.1 "subdomain1.$DOMAIN"
echo "Résolution DNS externe:"
dig @8.8.8.8 google.com
dig @1.1.1.1 cloudflare.com

echo "Configuration terminée avec succès."
