#include "calc.h"

int Calc::Sum(int a, int b) {
  return a + b;
}

int Calc::Multiply(int a, int b) {
  // return a * a; // a mistake!
  return a * b;
}

int Calc::AddRandomNumber(int a) {
  return a + rng_->Get();
}
