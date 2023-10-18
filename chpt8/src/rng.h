#pragma once

class RandomNumberGenerator {
public:
  virtual int Get() = 0;
  virtual ~RandomNumberGenerator() = default;
};

class RandomNumberGeneratorMt19937 : public RandomNumberGenerator {
public:
  int Get() override;
};
