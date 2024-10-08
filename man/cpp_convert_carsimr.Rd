% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{cpp_convert_carsimr}
\alias{cpp_convert_carsimr}
\title{Convert a Numeric Matrix to a CarSimr List}
\usage{
cpp_convert_carsimr(grid)
}
\arguments{
\item{grid}{Numeric matrix representing a grid of cars.}
}
\value{
A list representing the car simulation, with S3 class attributes.
}
\description{
This function takes a numeric matrix intended to represent a grid of cars
and converts it using the CarSimr class into a list format with S3 class attributes.
}
