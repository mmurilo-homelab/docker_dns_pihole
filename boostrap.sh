#!/usr/bin/env bash

set -eu

stacks_path=/opt/stacks


echo "Update System"
apt update
apt full-upgrade -y

echo "##########   install extra packages ###########"
apt install -y curl git neovim unattended-upgrades

echo "##########   install docker   #################"
curl -fsSL https://get.docker.com | sh

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
