#' Move Red Cars
#'
#' This function moves red cars to the right by one grid cell if the cell to the
#'  right is empty.
#'
#' @param t_grid Grid from the previous step.
#'
#' @return Updated grid with moved red cars as a carsimr class object.
#' @export
move_red <- function(t_grid) {
  # Check if input is of class carsimr
  if (!inherits(t_grid, "carsimr")) {
    stop("Input grid must be of class 'carsimr'")
  }

  mat <- t_grid$grid
  dummy <- mat

  cols <- ncol(mat)

  # Check if input grid contains values other than 0, 1, or 2
  if (any(!mat %in% c(0, 1, 2))) {
    stop("Input grid should contain only 0s, 1s, or 2s")
  }

  # Find indices of red(2)
  indices <- which(mat == 2, arr.ind = TRUE)

  # Calculate new column indices (move right)
  new_col <- ifelse(indices[, 2] == cols, 1, indices[, 2] + 1)

  # Check if the next cell is occupied by another car
  empty_cells <- mat[cbind(indices[, 1], new_col)] == 0
  empty_indices <- which(empty_cells)

  # Update the grid with the moved red cars
  dummy[cbind(indices[empty_cells, 1], indices[empty_cells, 2])] <- 0
  dummy[cbind(indices[empty_indices, 1], new_col[empty_indices])] <- 2

  carsimr(dummy)
}

#' Move Blue Cars
#'
#' This function moves blue cars upwards by one grid cell if the cell above is
#'  empty.
#'
#' @param t_grid Grid from the previous step.
#'
#' @return Updated grid with moved blue cars as a carsimr class object.
#' @export
move_blue <- function(t_grid) {
  # Check if input is of class carsimr
  if (!inherits(t_grid, "carsimr")) {
    stop("Input grid must be of class 'carsimr'")
  }

  mat <- t_grid$grid
  dummy <- mat

  rows <- nrow(mat)

  # Check if input grid contains values other than 0, 1, or 2
  if (any(!mat %in% c(0, 1, 2))) {
    stop("Input grid should contain only 0s, 1s, or 2s")
  }

  # Find indices of blue
  indices <- which(mat == 1, arr.ind = TRUE)

  # Calculate new row indices (move up)
  new_row <- ifelse(indices[, 1] == 1, rows, indices[, 1] - 1)

  # Check if the next cell is occupied by another car
  empty_cells <- mat[cbind(new_row, indices[, 2])] == 0
  empty_indices <- which(empty_cells)

  # Update the grid with the moved blue cars
  dummy[cbind(indices[empty_cells, 1], indices[empty_cells, 2])] <- 0
  dummy[cbind(new_row[empty_indices], indices[empty_indices, 2])] <- 1

  carsimr(dummy)
}

#' Move Cars
#'
#' This function simulates the movement of cars on the grid for a specified
#'  number of trials.
#' The red and blue cars take turns moving.
#'
#' @param t_grid A grid of cars of class carsimr.
#' @param trials Number of car movements to simulate.
#'
#' @return An object of class carsimr_list containing the initial grid and each
#'  intermediate grid after each trial.
#' @export
#' @examples
#' # Move cars for 10 trials
#' move_cars(initialize_grid(0.3, c(10, 10), 0.5), 10)
move_cars <- function(t_grid, trials) {
  if (!inherits(t_grid, "carsimr")) {
    stop("First argument must be a carsimr class object.")
  }

  if (!is.numeric(trials) || length(trials) != 1 || trials <= 0) {
    stop("Second argument 'trials' must be a positive integer.")
  }

  grid_list <- vector("list", trials + 1)
  grid_list[[1]] <- t_grid

  for (i in seq_len(trials)) {
    t_grid <- if (i %% 2 == 0) move_red(t_grid) else move_blue(t_grid)
    grid_list[[i + 1]] <- t_grid
  }

  return(carsimr_list(grid_list))
}
