#!/bin/sh

# Répertoire SSH par défaut sur OpenBSD
ssh_key_path="$HOME/.ssh/id_rsa"
ansible_inventory="/root/automate-DHCP/ansible/inventory.ini"
ansible_playbook="/root/automate-DHCP/ansible/deploy.yml"

# Vérifie si la clé SSH existe déjà
if [ ! -f "$ssh_key_path" ]; then
    echo "Génération de la paire de clés SSH..."
    if ssh-keygen -t rsa -b 4096 -f "$ssh_key_path" -N ""; then
        echo "La paire de clés SSH a été générée avec succès."
    else
        echo "Erreur lors de la génération de la paire de clés SSH."
        exit 1
    fi
else
    echo "La clé SSH existe déjà."
fi

# Vérifie si Ansible est installé
if ! command -v ansible-playbook >/dev/null 2>&1; then
    echo "Installation d'Ansible..."
    if pkg_add ansible; then
        echo "Ansible a été installé avec succès."
    else
        echo "Erreur lors de l'installation d'Ansible."
        exit 1
    fi
fi

# Rend le script de déploiement Ansible exécutable
chmod +x "$ansible_playbook"

# Exécute le playbook Ansible
ansible-playbook -i "$ansible_inventory" "$ansible_playbook"