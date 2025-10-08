#!/usr/bin/env bash

set -eu

stacks_path=/opt/stacks

# check if Debian system
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "debian" || "$ID_LIKE" == "debian" ]]; then
        echo "This system is Debian or Debian-based."
    else
        echo "This system is not Debian or Debian-based."
        exit 1 # Exit with a non-zero status to indicate an error/non-Debian system
    fi
else
    echo "Could not determine OS type (missing /etc/os-release)."
    exit 1 # Exit with a non-zero status to indicate an error/non-Debian system
fi

# check if root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with root privileges (e.g., using sudo)."
   exit 1
fi


echo "##########    updating system  ###########"
apt update
apt full-upgrade -y

echo "##########   install extra packages ###########"
apt install -y curl git neovim unattended-upgrades ca-certificates

echo "##########   install docker 🐳 #################"

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/raspbian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo "Types: deb
URIs: https://download.docker.com/linux/debian/
Architectures: $(dpkg --print-architecture)
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc" > | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


echo "🚀 Deploying"
echo "#######################################################################"
echo "##################   clone repo   #####################################"
mkdir -p $stacks_path
git clone https://github.com/mmurilo-homelab/docker_dns_pihole.git $stacks_path
chgrp -R docker $stacks_path
docker compose --project-directory $stacks_path/dockge/ up -d

echo "#######################################################################"
echo "🎉 Script finished successfully. Docker services should now be running."
echo "Access Dockage at http://<host_ip>:5001" 
