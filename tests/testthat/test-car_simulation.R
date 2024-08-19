test_that("initialize_grid_cpp creates a correct grid", {
  set.seed(123)
  grid <- initialize_grid_cpp(0.5, c(10, 10), 0.5)
  expect_equal(dim(grid), c(10, 10))
  expect_true(all(grid %in% c(0, 1, 2)))
})

test_that("move_cars_cpp correctly moves cars", {
  set.seed(123)
  grid <- initialize_grid_cpp(1, c(5, 5), 1) # All cells filled
  grid_after_move <- move_cars_cpp(grid, 1) # Perform one movement
  expect_equal(sum(grid_after_move == 1), sum(grid == 1))
  expect_equal(sum(grid_after_move == 2), sum(grid == 2))
})

test_that("move_cars_cpp maintains the number of cars", {
  set.seed(123)
  grid <- initialize_grid_cpp(0.5, c(10, 10), 0.5)
  original_count_red <- sum(grid == 2)
  original_count_blue <- sum(grid == 1)
  grid_after_moves <- move_cars_cpp(grid, 10)
  expect_equal(sum(grid_after_moves == 2), original_count_red)
  expect_equal(sum(grid_after_moves == 1), original_count_blue)
})

test_that("initialize_grid_cpp handles extreme probabilities", {
  grid_all_blue <- initialize_grid_cpp(1, c(10, 10), 1)
  grid_all_red <- initialize_grid_cpp(1, c(10, 10), 0)
  grid_empty <- initialize_grid_cpp(0, c(10, 10), 0)
  grid_full <- initialize_grid_cpp(0.999, c(10, 10), 0.5)

  expect_true(all(grid_all_blue == 1))
  expect_true(all(grid_all_red == 2))
  expect_true(all(grid_empty == 0))
  expect_true(all(grid_full %in% c(1, 2)))
})

test_that("Random numeric rho rounds correctly", {
  grid <- initialize_grid_cpp(44.7, c(10, 10), 0.5)
  expect_true(sum(grid != 0) > 0)
})
