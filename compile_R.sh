#!/bin/bash
echo "Installing required dependencies"
sudo apt -y install \
    build-essential\
    libcurl4-gnutls-dev\
    default-jdk\
    libxml2-dev\
    libbz2-dev\
    libssl-dev\
    texlive-full\
    gfortran \
    g++ \
    libreadline-dev \
    xorg-dev \
    liblzma-dev \
    libpcre++-dev \
    libpango1.0-dev \
    libpango1.0-dev \
    libpcre2-dev
    tk-dev
    tk-table
    tcl-dev
echo "Dependencies installed!"
echo "Downloading R-devel source code..."
wget https://stat.ethz.ch/R/daily/R-devel.tar.gz
tar -xvf R*tar.gz
echo "Done"
echo "Switching into R-devel directory..."
cd R-devel
echo "In `pwd`!"
R_VERSION=devel
echo "Configuring installation..."
./configure \
    --prefix=/opt/R/$R_VERSION \
    --enable-memory-profiling \
    --enable-R-shlib \
    --with-tcltk \
    --with-blas \
    --with-lapack
echo "Making R-devel..."
make
echo "Installing from source..."
sudo make install
echo "Done"
echo "Creating symlinks"
sudo ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R
sudo ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript
echo "Done!"
echo "Testing installation was succesful:"
/opt/R/${R_VERSION}/bin/R --version
echo "Successful is above returned a version number!"
