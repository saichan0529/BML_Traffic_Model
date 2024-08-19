#' Initialize Grid with Moving Cars
#'
#' This function creates a grid with moving cars based on specified parameters.
#'
#' @param rho The number of grid cells that should be filled with cars. It can
#'  be either a proportion or an integer.
#' @param dims Size of the grid or dimensions of the matrix as a numeric vector
#'  (e.g., c(rows, cols)).
#' @param prob_blue Probability of selecting a blue car. Should be between 0 and
#'  1.
#'
#' @return Initialized grid as a carsimr class object.
#' @export
#' @examples
#' # Initialize grid with proportion of cars
#' initialize_grid(0.3, c(10, 10), 0.5)
#' # Initialize grid with specific number of cars
#' initialize_grid(20, c(15, 15), 0.6)
initialize_grid <- function(rho, dims, prob_blue) {
  rho <- validate_rho(rho)
  dims <- validate_dims(dims)
  prob_blue <- validate_prob_blue(prob_blue)

  size <- prod(dims)
  if (rho >= 1) cars <- round(rho)
  if (rho < 1) cars <- round(size * rho)

  grid <- matrix(0, nrow = dims[1], ncol = dims[2])
  i <- 1
  while (i <= cars) {
    car <- stats::runif(1)
    row <- sample(1:dims[1], 1)
    col <- sample(1:dims[2], 1)
    if (car < prob_blue && grid[row, col] == 0) {
      grid[row, col] <- 1
      i <- i + 1
    } else if (car >= prob_blue && grid[row, col] == 0) {
      grid[row, col] <- 2
      i <- i + 1
    }
  }
  carsimr(grid)
}
