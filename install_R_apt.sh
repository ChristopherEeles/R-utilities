#!/bin/bash

# -- Update and upgrade
sudo apt-get update -y && sudo apt-get upgrade -y

# -- Add R repo to apt, then use it to install R
sudo apt install dirmngr gnupg apt-transport-https ca-certificates \
    software-properties-common
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
    E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository \
    'deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/'

# -- This has most R system dependencies
apt_pkgs=(
    # system deps
    'libcurl4-openssl-dev' 'libssl-dev' 'libxml2-dev' 'build-essentials'
    'libsodium-dev' 'libopenblas-dev'
    # databases
    'sqlite' 'mariabd-server-10.3' 'mariadb-server' 
    'libmariadbclient-dev' 'mysql-server'
    # CLI tools
    'git'  'pigz'  'htop'
    # Rmarkdown
    'pandoc'
    # programming languages
    'r-base'
)

echo "export LD_LIBRARY_PATH=/usr/lib/openblas-base/" >> ~/.bashrc

# -- Run the installation commands
for pkg in "${apt_pkgs[@]}"
do
    sudo apt-get install -y "$pkg"
done
