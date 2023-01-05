# Set default CRAN mirror to UofT
local({
    options(datatable.print.class=TRUE)
})

# quit immedialtely without saving
iq <- iquit <- function() q(save='no')

# Short-cut to roxygenise and build and R package
qinstall <- function(quit=FALSE, ...) {
    roxygen2::roxygenise(clean=TRUE)
    devtools::install(...)
    if (isTRUE(quit)) {
        quit(save='no')
    }
}

# Get object size in memory nicely
obj_size <- function(x, unit='MiB') format(object.size(x), unit)

# Short-cut to remove all objects from environment
rm_all <- function(all=TRUE) {
    rm(list=ls(all=all))
    source('~/.Rprofile')
}

# Set environemtal variables
Sys.setenv(R_BIOC_VERSION=3.16)
