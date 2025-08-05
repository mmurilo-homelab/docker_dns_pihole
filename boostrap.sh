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
echo "##################   prepare path #####################################"
mkdir -p $stacks_path
cd $stacks_path

echo "#######################################################################"
echo "##################   clone repo   #####################################"
#git clone 

