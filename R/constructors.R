#' Create a new carsimr objects
#'
#' This function creates a new carsimr object with the specified grid.
#'
#' @param grid A matrix representing the grid or an existing carsimr object.
#'
#' @return A carsimr object.
#' @export
new_carsimr <- function(grid = matrix(0, nrow = 1, ncol = 1)) {
  stopifnot(is.matrix(grid) || class(grid) == "carsimr")
  structure(list(grid = grid), class = "carsimr")
}

#' Validate carsimr object
#'
#' This function validates whether the input object is a valid carsimr object.
#'
#' @param x An object to be validated.
#'
#' @return The input object if it is valid.
#' @export
validate_carsimr <- function(x) {
  stopifnot(is.matrix(x$grid) || class(x$grid) == "carsimr")
  x
}

#' Create a carsimr object
#'
#' This function creates a new carsimr object with the specified grid and
#'  validates it.
#'
#' @param grid A matrix representing the grid or an existing carsimr object.
#'
#' @return A validated carsimr object.
#' @export
carsimr <- function(grid) {
  validate_carsimr(new_carsimr(grid))
}

#' Create a new carsimr_list object
#'
#' This function creates a new carsimr_list object with the specified list of
#'  grids.
#'
#' @param grid_list A list of grid matrices.
#'
#' @return A carsimr_list object.
#' @export
new_carsimr_list <- function(grid_list) {
  stopifnot(is.list(grid_list))
  structure(list(grids = grid_list), class = "carsimr_list")
}

#' Validate carsimr_list object
#'
#' This function validates whether the input object is a valid carsimr_list
#'  object.
#'
#' @param x An object to be validated.
#'
#' @return The input object if it is valid.
#' @export
validate_carsimr_list <- function(x) {
  stopifnot(is.list(x$grids))
  x
}

#' Create a carsimr_list object
#'
#' This function creates a new carsimr_list object with the specified list of
#'  grids and validates it.
#'
#' @param grid_list A list of grid matrices.
#'
#' @return A validated carsimr_list object.
#' @export
carsimr_list <- function(grid_list) {
  validate_carsimr_list(new_carsimr_list(grid_list))
}

#' Validate and adjust rho parameter
#'
#' Ensures that rho is a numeric value. If rho is greater than 1, it rounds rho
#' to the nearest integer, assuming it represents an absolute number of cars
#' rather than a proportion.
#'
#' @param rho Numeric value showing the proportion or absolute number of cars.
#' @return The validated and possibly adjusted rho value.
#' @export
validate_rho <- function(rho) {
  if (rho > 1) {
    rho <- round(rho)
  } else if (rho < 0 || rho > 1) {
    stop("For proportions, rho must be between 0 and 1.")
  }

  rho
}

#' Validate probability of selecting a blue car
#'
#' Checks that prob_blue is a numeric value between 0 and 1.
#'
#' @param prob_blue Numeric value showing the probability of picking a blue car.
#' @return The validated prob_blue value.
#' @export
validate_prob_blue <- function(prob_blue) {
  if (!is.numeric(prob_blue) || prob_blue < 0 || prob_blue > 1) {
    stop("prob_blue must be a numeric value between 0 and 1.")
  }
  prob_blue
}

#' Validate dimensions of the grid
#'
#' Checks that dimensions provided are a numeric vector of length 2 and each
#' element is a positive integer.
#'
#' @param dims Numeric vector specifying the dimensions of the grid.
#' @return The validated dimensions vector.
#' @export
validate_dims <- function(dims) {
  if (!is.numeric(dims) || length(dims) != 2) {
    stop("dims must be a numeric vector of length 2.")
  }
  if (any(dims <= 0)) {
    stop("Dimensions must be positive numbers.")
  }
  dims
}

#' Validate Inputs for Moving Cars Rcpp
#'
#' This function checks the validity of the inputs for the move_cars_cpp
#' function.
#'
#' @param grid A matrix representing the grid of cars, where elements should be
#'   either 0, 1, or 2.
#' @param trials An integer for the number of trials or movements to simulate.
#'
#' @return Invisible NULL, this function is used purely for validation and will
#' @export
validate_move_cars_inputs <- function(grid, trials) {
  if (!is.matrix(grid) || !all(grid %in% c(0, 1, 2))) {
    stop("grid must be a matrix containing only 0, 1, or 2.")
  }
  if (!is.numeric(trials) || trials <= 0 || !is.integer(trials)) {
    stop("trials must be a positive integer.")
  }
  invisible(NULL)
}
