test_that("initialize_grid tests", {
  for (i in seq_len(10)) {
    sz <- sample(6, 2, replace = TRUE)

    # No red cars returned when prob_blue = 1
    no_red_cars <- initialize_grid(0.7, sz, 1)
    expect_equal(sum(no_red_cars$grid == 2), 0,
      info = "No red cars should be returned"
    )

    # No blue cars when prob_blue = 0
    no_blue_cars <- initialize_grid(0.7, sz, 0)
    expect_equal(sum(no_blue_cars$grid == 1), 0,
      info = "No blue cars should be returned"
    )

    # No cars (red or blue) when rho = 0
    no_cars <- initialize_grid(0, sz, 0.5)
    expect_equal(sum(no_cars$grid != 0), 0,
      info = "No cars should be returned"
    )

    # No blank spaces when rho = 0.999 on a grid with 100 spaces less
    no_blank_spaces <- initialize_grid(0.999, sz, 0.5)
    expect_equal(sum(no_blank_spaces$grid == 0), 0,
      info = "No blank spaces should be returned"
    )
  }

  # No blank spaces when rho = 0.999 on a grid with 100 spaces
  no_blank_spaces <- initialize_grid(0.999, c(10, 10), 0.5)
  expect_equal(sum(no_blank_spaces$grid == 0), 0,
    info = "No blank spaces should be returned"
  )

  # Randomly selected numeric (not integer) returns the proper number of cars by
  # either rounding to the nearest integer or truncating the decimal places
  numeric_cars <- initialize_grid(50.6, c(10, 10), 0.5)
  expect_true(sum(numeric_cars$grid == 1) + sum(numeric_cars$grid == 2) == 51,
    info = "Number of cars should be approx 51 when rho = 50.5"
  )
})
