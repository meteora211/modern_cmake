#include "car.h"
#include "race_car.h"

int main() {
  Car volvo;
  std::cout << volvo.honk() << std::endl;
  RaceCar polestar;
  std::cout << polestar.honk() << std::endl;
}
