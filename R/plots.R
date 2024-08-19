#' Plot functions
#'
#' These functions provide plotting capabilities for objects of class 'carsimr'
#'  and 'carsimr_list'.
#'
#' @export
#' @method plot carsimr
plot.carsimr <- function(x, ...) {
  UseMethod("plot.carsimr")
}

#' Plot Functions for carsimr_list Objects
#'
#' @export
#' @method plot carsimr_list
plot.carsimr_list <- function(x, pause, ...) {
  UseMethod("plot.carsimr_list")
}

#' Plot method for carsimr objects
#'
#' @param x An object of class 'carsimr'
#' @param ... Additional arguments
#'
#' @return A plot of the 'carsimr' grid
#' @export
plot.carsimr <- function(x, ...) {
  if (!inherits(x, "carsimr")) {
    stop("The object is not of class 'carsimr'.")
  }

  grid <- x$grid
  nrow <- nrow(grid)
  ncol <- ncol(grid)

  graphics::image(seq_len(ncol(grid)), seq_len(nrow(grid)),
    t(apply(grid, 2, rev)),
    breaks = (0:3) - (0.5),
    col = c("white", "blue", "red"),
    axes = FALSE,
    asp = 1
  )
}

#' Plot method for carsimr_list objects
#'
#' @param x An object of class 'carsimr_list'
#' @param pause Value to pause the plots
#' @param ... Additional arguments
#'
#' @return Plotting of carsimr_list object with a specified pause.
#' @export
plot.carsimr_list <- function(x, pause = .9, ...) {
  if (!inherits(x, "carsimr_list")) {
    stop("The object is not of class 'carsimr_list'.")
  }

  for (grid in x$grids) {
    plot.carsimr(grid)
    Sys.sleep(pause)
  }
}
