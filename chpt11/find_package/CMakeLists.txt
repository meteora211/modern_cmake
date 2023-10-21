cmake_minimum_required(VERSION 3.20.0)
project(FINDCalcPackage CXX)

find_package(Calc REQUIRED)

include(CMakePrintHelpers)
message("CMAKE_PREFIX_PATH: " ${CMAKE_PREFIX_PATH})
message("CALC FOUND: " ${Calc_FOUND})
cmake_print_properties(TARGETS Calc::calc
  PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES
  IMPORTED_CONFIGURATIONS
  )
