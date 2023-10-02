#pragma once
#include <iostream>
#include <string>
#include "car.h"

class RaceCar : public Car {
public:
  std::string honk() const override;
};
