#include <Rcpp.h>
using namespace Rcpp;

//' Initialize a Grid with Cars
//'
//' This function creates a grid of the specified dimensions where each cell
//' may randomly contain a car based on the specified probability. The type
//' of car (blue or red) is also determined based on a probability.
//'
//' @param rho A numeric value that can either be a proportion of cells to fill
//' (between 0 and 1) or a total number of cars if greater than 1.
//' @param dims An integer vector specifying the dimensions of the grid (rows,
//' columns).
//' @param prob_blue A numeric probability (between 0 and 1) that a car will be
//' blue;
//' the probability of a car being red is 1 - prob_blue.
//'
//' @return A numeric matrix representing the grid, where 0 indicates an empty
//' cell, 1 indicates a blue car, and 2 indicates a red car.
//' @export
// [[Rcpp::export]]
NumericMatrix initialize_grid_cpp(double rho, IntegerVector dims,
                                  double prob_blue) {
  int nrows = dims[0];
  int ncols = dims[1];
  int size = nrows * ncols;
  int cars = (rho > 1) ? round(rho) : round(size * rho);

  NumericMatrix grid(nrows, ncols);

  int count = 0;
  while (count < cars) {
    double car = R::runif(0, 1);
    int row = R::runif(0, nrows);
    int col = R::runif(0, ncols);
    // Only place a car if the spot is currently empty
    if (grid(row, col) == 0) {
      if (car < prob_blue) {
        grid(row, col) = 1; // Place blue car
      } else {
        grid(row, col) = 2; // Place red car
      }
      count++;
    }
  }

  return grid;
}

//' Move Cars on a Grid
//'
//' This function simulates moving cars in a grid for a specified number of trials.
//' Cars move according to specific rules: red cars move right on even-numbered trials
//' and blue cars move up on odd-numbered trials.
//'
//' @param grid A numeric matrix representing the initial state of the grid,
//' where 0 indicates an empty cell, 1 indicates a blue car, and 2 indicates a red car.
//' @param trials An integer representing the number of movements to simulate.
//'
//' @return A numeric matrix representing the grid after all movements have been simulated.
//' @export
// [[Rcpp::export]]
NumericMatrix move_cars_cpp(NumericMatrix grid, int trials) {
  int nrows = grid.nrow();
  int ncols = grid.ncol();

  for (int t = 0; t < trials; t++) {
    NumericMatrix current_grid(clone(grid));
    if (t % 2 == 0) { // Move red cars on even trials
      for (int i = 0; i < nrows; i++) {
        for (int j = 0; j < ncols; j++) {
          int next_col = (j + 1) % ncols;
          if (current_grid(i, j) == 2 && current_grid(i, next_col) == 0) {
            grid(i, j) = 0;
            grid(i, next_col) = 2;
          }
        }
      }
    } else { // Move blue cars on odd trials
      for (int j = 0; j < ncols; j++) {
        for (int i = 0; i < nrows; i++) {
          int prev_row = (i - 1 + nrows) % nrows;
          if (current_grid(i, j) == 1 && current_grid(prev_row, j) == 0) {
            grid(i, j) = 0;
            grid(prev_row, j) = 1;
          }
        }
      }
    }
  }
  return grid;
}
