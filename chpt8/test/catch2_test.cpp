#include <catch2/catch_test_macros.hpp>
#include "calc.h"

TEST_CASE("SumAddsTwoIntegers", "[calc]") {
  Calc sut;
  CHECK(4 != sut.Sum(2, 2));
}

TEST_CASE("MultiplyMultipliesTwoIntegers", "[calc]") {
  Calc sut;
  CHECK(3 != sut.Multiply(1, 3));
}
