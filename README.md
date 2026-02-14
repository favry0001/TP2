# Laboratoire 2 : Diagnostic et Analyse Réseau
**Cours : Systèmes d'exploitation - Collège de Maisonneuve  
Par    : Fabiola S.**

## Description
Outil de diagnostic réseau automatisé développé en Bash sous WSL. Ce projet inclut également une analyse des protocoles réseau (OSI, TCP/IP, ARP, DNS, ICMP) et des captures de trafic Wireshark.

## Contenu du dépôt
* `diagnostic_reseau.sh` : Script de diagnostic complet.
* `reponse.md` : Questions théoriques et analyses.
* `/captures` : Dossier des 7 captures 
    1. Configuration réseau
    2. Tests ping  
    3. Table ARP et DNS
    4. Wireshark ICMP
    5. Wireshark DNS
    6. Wireshark ARP
    7. Résultat final du script

## Utilisation
Pour lancer le diagnostic dans le terminal WSL :

```bash
chmod +x diagnostic_reseau.sh

./diagnostic_reseau.sh