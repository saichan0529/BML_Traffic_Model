test_that("Other features tests", {
  # Moving cars on an empty grid returns an empty grid
  empty_grid <- initialize_grid(0, c(10, 10), 0.5)
  empty_grid_after_move <- move_cars(empty_grid, 10)
  expect_true(all(empty_grid_after_move$grids[[1]]$grid == 0),
    info = "Moving cars on an empty grid should return an empty grid"
  )

  # Initializing a grid with a very low probability of cars
  low_probability_grid <- initialize_grid(0.001, c(10, 10), 0.5)
  expect_true(sum(low_probability_grid$grid != 0) == 0,
    info = "grid with a very low probability shouldn't result any cars"
  )

  # Test for correct grid dimensions
  grid_i <- initialize_grid(10, c(5, 5), 0.5)
  expect_equal(dim(grid_i$grid), c(5, 5),
    info = "Grid dimensions should match the specified dimensions."
  )
})
