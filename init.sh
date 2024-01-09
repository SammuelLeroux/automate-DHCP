#!/bin/sh

# Répertoire sur OpenBSD
repo_dir="/root"

# Vérifie si le répertoire existe, sinon le crée
if [ ! -d "$repo_dir/automate-DHCP" ]; then
    echo "Création du répertoire $repo_dir/automate-DHCP"
    mkdir -p "$repo_dir/automate-DHCP"
fi

# Vérifie si unzip est installé, sinon le télécharge
if ! command -v unzip >/dev/null 2>&1; then
    echo "Installation de unzip..."
    pkg_add unzip
fi

# Télécharge le repo GitHub avec ftp
echo "Téléchargement du repo GitHub..."
ftp -o "$repo_dir/automate-DHCP.zip" https://github.com/SammuelLeroux/automate-DHCP/archive/main.zip
unzip "$repo_dir/automate-DHCP.zip" -d "$repo_dir"
mv "$repo_dir/automate-DHCP-main"/* "$repo_dir/automate-DHCP/"
rm -r "$repo_dir/automate-DHCP-main"
rm "$repo_dir/automate-DHCP.zip"

# Exécute le script deploy_all.sh
chmod +x "$repo_dir/automate-DHCP/deploy_all.sh"
"$repo_dir/automate-DHCP/deploy_all.sh"