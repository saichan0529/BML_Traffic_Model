#include <Rcpp.h>
using namespace Rcpp;


class CarSimr {
public:
  NumericMatrix grid;
  std::string type;

  // Constructor
  CarSimr(NumericMatrix g, std::string t = "Default") : grid(g), type(t) {}

  // Convert to an R list that mimics the original S3 class
  List toList() {
    List result = List::create(Named("grid") = grid, Named("type") = type);
    result.attr("class") = "carsimr";
    return result;
  }
};

//' Convert a Numeric Matrix to a CarSimr List
//'
//' This function takes a numeric matrix intended to represent a grid of cars
//' and converts it using the CarSimr class into a list format with S3 class attributes.
//'
//' @param grid Numeric matrix representing a grid of cars.
//' @return A list representing the car simulation, with S3 class attributes.
//' @export
// [[Rcpp::export]]
List cpp_convert_carsimr(NumericMatrix grid) {
  CarSimr simr(grid, "Processed");
  return simr.toList();
}
