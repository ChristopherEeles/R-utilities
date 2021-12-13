#!/bin/bash

# -- make sure we are on an OS with apt
if [[ ! "$OSTYPE" =~ linux.* ]]
then
    echo "This script requires the apt utility to work correctly!"
    exit 1
fi

# -- parse command line args
SOURCE='https://cran.r-project.org/src/base/R-latest.tar.gz'
VERSION='latest'
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -v|--version)
            VERSION="$2"
            case $VERSION in
                devel)
                    SOURCE='https://stat.ethz.ch/R/daily/R-devel.tar.gz'
                    ;;
                patched)
                    SOURCE='https://stat.ethz.ch/R/daily/R-patched.tar.gz'
                    ;;
                *)
                    echo 'Valid options for the -v/--version parameter are ' \
                        '\n"devel" for the development version or "patched" ' \
                        '\nfor the previous release. If you want R "release",' \
                        '\n exclude the -v/--version parameter since that is' \
                        'the default for this script.'
                    ;;
            esac
            shift # past argument
            shift # past value
            ;;
        *)
            echo "The only valid option is for this script is -v/--version."
            exit 1
            ;;
    esac
done

# -- install R compilation dependencies
## TODO: Generalize this to work with other installation utilties (brew, yum)
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
    libpcre2-dev \
    tk-dev \
    tk-table \
    tcl-dev
echo "Dependencies installed!"

# -- download the correct R version
echo "Downloading R-$VERSION source code..."
wget $SOURCE
tar -xvf R-"$VERSION"*tar.gz --one-top-level=R-"$VERSION" --strip-components=1
echo "Done"

# -- configure and make the R source files
echo "Switching into R-$VERSION directory..."
cd "R-$VERSION" || exit 1
echo "In $(pwd)!"
echo "Configuring installation..."
./configure \
    --prefix=/opt/R/R-"$VERSION" \
    --enable-memory-profiling \
    --enable-R-shlib \
    --with-tcltk \
    --with-blas \
    --with-lapack
echo "Making R-$VERSION..."
make

# -- install the R source files
echo "Installing from source..."
sudo make install
echo "Done"

# -- update the system symlinks to the version just installed
echo "Creating symlinks"
sudo rm /usr/bin/R /usr/bin/Rscript
sudo ln -s /opt/R/R-"$VERSION"/bin/R /usr/bin/R
sudo ln -s /opt/R/R-"$VERSION"/bin/Rscript /usr/bin/Rscript
echo "Done!"

# -- check if the installation succeeded
echo "Testing installation was succesful:"
/opt/R/R-"$VERSION"/bin/R --version || exit 1
echo "Successful is above returned a version number!"

echo "Cleaning up..."
rm -r R-*
echo "Finished cleaning up!"

exit 0