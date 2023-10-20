#include <iostream>
#include "calc.h"
using namespace std;

void run() {
  auto* rng = new RandomNumberGeneratorMt19937();
  Calc c(rng);
  cout << "2 + 2 = " << c.Sum(2, 2) << endl;
  cout << "3 * 3 = " << c.Multiply(3, 3) << endl;
  cout << "add random number: " << c.AddRandomNumber(1) << endl;
  delete rng;
}
