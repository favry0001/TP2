#!/bin/bash
# Nom         : diagnostic_reseau.sh
# Auteur      : Fabiola 
# Date        : 2026 - 02 - 09
# Description : Script de diagnostic réseau complet pour vérifier la configuration système - le Labo 2

# --- COULEURS ---
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'
echo " "

# ---------------------------------- VARIABLES ---
# les données Windows et WSL
HOST=$(hostname)
DATE_H=$(date '+%Y-%m-%d %H:%M:%S')
OS_VER=$(uname -a)
PASSERELLE=$(ipconfig.exe 2>/dev/null | grep -Ea "Paserelle par defaut|Gateway" | head -1 | awk -F: '{print $2}' )

echo " "
# ------------------- 1. INFORMATIONS SYSTÈME ---
echo -e "${BLUE}================ INFORMATIONS SYSTÈME ================${NC}"
echo "Nom de l'hôte : $HOST"
echo "Date et heure : $DATE_H"
echo "Système       : $OS_VER"

echo " "
# --------------------- 2. CONFIGURATION RÉSEAU ---
echo -e "${BLUE}================ CONFIGURATION RÉSEAU ================${NC}"
echo "IP Locale  : $(hostname -I | awk '{print $1}')"
echo "Passerelle : $PASSERELLE"
echo "DNS        : $(cat /etc/resolv.conf |grep nameserver | awk '{print $2}')"

echo " "
# ----------------------- 3. TESTS DE CONNECTIVITÉ ---
echo -e "${BLUE}================ TESTS DE CONNECTIVITÉ ================${NC}"

# Test Localhost
if ping -c 1 127.0.0.1 > /dev/null 2>&1; then
    echo -e "Localhost (127.0.0.1) : ${GREEN}RÉUSSI${NC}"
else
    echo -e "Localhost (127.0.0.1) : ${RED}ÉCHEC${NC}"
fi

# Test Passerellle
if [[ -n "$PASSERELLE" ]] && ping -c 1 "$PASSERELLE" > /dev/null 2>&1; then
    echo -e "Passerelle ($PASSERELLE) : ${GREEN}RÉUSSI${NC}"
else
    echo -e "Passerelle : ${RED}ÉCHEC , désoler mauvaise passerelle ${NC}"
fi

# Test Internet 
if ping -c 1 8.8.8.8 > /dev/null 2>&1; then
    echo -e "Internet (8.8.8.8) : ${GREEN}RÉUSSI${NC}"
else
    echo -e "Internet (8.8.8.8) : ${RED}ÉCHEC${NC}"
fi

# Test Résolution DNS GG
if nslookup google.com > /dev/null 2>&1; then
    echo -e "Résolution google.com : ${GREEN}RÉUSSI${NC}"
else
    echo -e "Résolution google.com : ${RED}ÉCHEC${NC}"
fi

echo " "
# --------------=------------- 4. TABLE ARP ---
echo -e "${BLUE}===================== TABLE ARP =====================${NC}"
# Commande simple pour afficher les voisins réseau
arp.exe -a | head -n 10
echo " "

# -------------------------------- 5. RÉSOLUTIONS DNS ---
echo -e "${BLUE}================ RÉSOLUTIONS DNS =====================${NC}"
echo "Pour google.com :"
nslookup google.com | grep "Address" | tail -n 1

echo "Pour github.com :"
nslookup github.com | grep "Address" | tail -n 1
echo " "