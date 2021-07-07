#!/bin/R

if (!require('remotes')) install.packages('remotes')
if (!require('pak')) remotes::install_github('pak', dependencies=TRUE)

library(pak)

# Set the correct Bioc version
pkg_install("BiocManager")
BiocManager::install(version='devel')

# Install CRAN and GitHub packages with pak
CRAN <- c('data.table', 'jsonlite', 'httr', 'xml2', 'XML', 'ggplot2',
    'ggtext', 'crayon', 'glue', 'RMySQL', 'RMariaDB', 'RSQLite', 'rextendr',
    'renv', 'reticulate', 'caret', 'knitr', 'rmarkdown', 'tinytex',
    'shiny', 'ggvis', 'htmlwidgets', 'plotly', 'xtable', 'foreach', 'parallel',
    'future', 'devtools', 'roxygen2', 'testthat', 'drake', 'plumber',
    'checkmate', 'profvis', 'bench', 'survival', 'lattice',
    'RColorBrewer', 'ggplotify', 'gridExtra', 'qs', 'logger', 'memoise'
    )
GITHUB <- c()

pkg_install(c(CRAN, GITHUB))

# Install Bioconductor packages with BiocManager, no support for setting 
#>version of BioC to download (defaults to release)
BIOC <- c('BiocGenerics', 'MatrixGenerics', 'S4Vectors', 'Biobase', 
    'SummarizedExperiment', 'MultiAssayExperiment', 'GenomicRanges',
    'GenomicFeatures', 'biomaRt', 'limma', 'AnnotationDbi', 'annotate',
    'piano', 'lsa')

BiocManager::install(BIOC)