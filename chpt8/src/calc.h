#pragma once
#include "rng.h"

class Calc {
public:
  Calc() : rng_(nullptr) {}
  Calc(RandomNumberGenerator *rng) : rng_(rng) {}
  int Sum(int a, int b);
  int Multiply(int a, int b);
  int AddRandomNumber(int a);

private:
  RandomNumberGenerator *rng_;
};
