#!/usr/bin/env bash

set -eu

stacks_path=/opt/stacks


echo "Update System"
apt update
apt full-upgrade -y

echo "##########   install extra packages ###########"
apt install -y curl git neovim unattended-upgrades

echo "##########   install docker 🐳 #################"
if [ -f /proc/cpuinfo ]; then
    # Search for "Raspberry Pi" in the Hardware line
    if grep -q "Model.*Raspberry Pi" /proc/cpuinfo; then
        echo "This script is running on a Raspberry Pi. Docker should be installed mannulay. Skipping..."
        # https://docs.docker.com/engine/install/raspberry-pi-os/
        sleep 10
    else
        echo "This script is NOT running on a Raspberry Pi. Installing Docker"
        curl -fsSL https://get.docker.com | sh
    fi
else
    echo "/proc/cpuinfo not found. Cannot determine if running on Raspberry Pi."
fi


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
