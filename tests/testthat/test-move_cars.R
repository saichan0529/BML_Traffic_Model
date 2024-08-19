test_data <- readRDS(testthat::test_path("test_carsimr_data.RDS"))

test_that("Testing move_cars function", {
  for (i in seq_along(test_data)) {
    initial_grid <- test_data[[i]][[1]]
    expected_first_move <- test_data[[i]][[2]]
    expected_second_move <- test_data[[i]][[3]]

    result_first_move <- move_cars(carsimr(initial_grid), 1)
    result_second_move <- move_cars(carsimr(initial_grid), 2)

    expect_equal(result_first_move$grids[[2]], carsimr(expected_first_move),
      info = "1st move result should match the expected 1st matrix."
    )
    expect_equal(result_second_move$grids[[3]], carsimr(expected_second_move),
      info = "2nd move result should match the expected 2nd matrix."
    )
  }

  # Additional 10 tests for non square matrix for counting of cars before and
  # after the 10 movements
  for (i in seq_len(10)) {
    sz <- sample(6, 2, replace = FALSE)

    before <- initialize_grid(0.5, sz, 0.5)
    after <- move_cars(before, 12)

    expect_equal(table(before$grid), table(after$grids[[13]][1]$grid),
      info = "Count of cars match before and after the movements"
    )
  }
})
