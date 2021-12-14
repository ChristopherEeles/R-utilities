docker run \
    -v ~/development:/home/rstudio \
    -e PASSWORD=bioc \
    -p 8787:8787 \
    bioconductor/bioconductor_docker:devel

#-v ~/R/x86_64-pc-linux-gnu-library/4.2:/usr/local/lib/R/host-site-library \
