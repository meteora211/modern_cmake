add_executable(unit_test
  unit_test.cpp
  calc_test.cpp
  run_test.cpp
  )

target_include_directories(unit_test PRIVATE ${CMAKE_SOURCE_DIR}/src)
target_link_libraries(unit_test PRIVATE calc)

add_test(NAME SumAddTwoInts COMMAND unit_test 1)
add_test(NAME MultiplyMultipliesTwoInts COMMAND unit_test 2)
add_test(NAME RunOutputsCorrectEquations COMMAND unit_test 3)
