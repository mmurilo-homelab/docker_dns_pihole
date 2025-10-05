#!/usr/bin/env bash

set -eu

stacks_path=/opt/stacks


echo "Update System"
apt update
apt full-upgrade -y

echo "##########   install extra packages ###########"
apt install -y curl git neovim

echo "##########   install docker   #################"
curl -fsSL https://get.docker.com | sh

echo "#######################################################################"
echo "##################   clone repo   #####################################"
mkdir -p $stacks_path
chgrp -R docker $stacks_path
git clone https://github.com/mmurilo-homelab/docker_dns_pihole.git $stacks_path

docker compose --project-directory $stacks_path/dockge/ up -d
