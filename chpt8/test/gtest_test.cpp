#include <gtest/gtest.h>
#include "calc.h"
#include "mocks/rng_mock.h"

class CalcTestSuite : public ::testing::Test {
protected:
  RandomNumberGeneratorMock rng_;
  // XXX: compile error on Calc sut_(&rng_);
  Calc sut_{&rng_};
};

TEST_F(CalcTestSuite, SumAddsTwoInts) {
  EXPECT_EQ(4, sut_.Sum(2,2));
}

TEST_F(CalcTestSuite, MultiplyMultipliesTwoIntegers) {
  EXPECT_EQ(12, sut_.Multiply(3,4));
}

TEST_F(CalcTestSuite, AddRandomNumberAddsThree) {
  EXPECT_CALL(rng_, Get()).Times(1).WillOnce(::testing::Return(3));
  EXPECT_EQ(4, sut_.AddRandomNumber(1));
}
