# Set default CRAN mirror to UofT
local({
    r <- getOption('repos')
    r['CRAN'] <- 'https://utstat.toronto.edu/cran/'
    options(repos=r)
})

# Get object size in memory nicely
obj_size <- function(x, unit='MiB') format(object.size(x), unit)

# Short-cut to remove all objects from environment
rm_all <- function(all=TRUE) {
    rm(list=ls(all=all))
    source('~/.Rprofile')
}

# Short-cut to roxygenise and build and R package
#' @md
#' @param quit `logical(1)` Call `quit()` after installing? Default is FALSE.
#' @param ... Fall through arguments to [`devtools::install`]
qinstall <- function(quit=FALSE, ...) {
    roxygen2::roxygenise(clean=TRUE)
    devtools::install(...)
    if (isTRUE(quit)) {
        quit(save='no')
    }
}