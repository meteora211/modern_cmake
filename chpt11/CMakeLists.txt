cmake_minimum_required(VERSION 3.20)
project(Tests LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)

enable_testing()
add_subdirectory(src bin)
add_subdirectory(test)

set(EXPORT_DIR "${CMAKE_CURRENT_BINARY_DIR}/cmake")

export(TARGETS calc
  FILE "${EXPORT_DIR}/CalcTargets.cmake"
  NAMESPACE Calc::
  )

#install lib. Note that PUBLIC_HEADER is defined as target_property before
install(TARGETS calc
  ARCHIVE DESTINATION "${CMAKE_SOURCE_DIR}/install/lib"
  PUBLIC_HEADER DESTINATION "${CMAKE_SOURCE_DIR}/install/include")

#install files
install(FILES
  src/rng.h
  DESTINATION "${CMAKE_SOURCE_DIR}/install/include"
  )
