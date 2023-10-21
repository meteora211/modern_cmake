add_library(calc STATIC calc.cpp run.cpp rng.cpp)
# target_include_directories(calc PUBLIC .)
target_include_directories(calc INTERFACE
  "$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/src>"
  "$<INSTALL_INTERFACE:${INSTALL_DIR}>"
  )
set_target_properties(calc PROPERTIES PUBLIC_HEADER
  src/calc.h)

add_executable(main bootstrap.cpp)
target_link_libraries(main PRIVATE calc)

