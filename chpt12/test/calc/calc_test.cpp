#include "calc/calc.h"

#include <gtest/gtest.h>

TEST(CalcTest, SumTwo) {
  EXPECT_EQ(4, calc::Sum(2, 2));
}

TEST(CalcTest, MulTwo) {
  EXPECT_EQ(4, calc::Multiply(2, 2));
}
