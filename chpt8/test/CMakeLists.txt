include(FetchContent)
FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG        devel #v3.0.0-preview3
)
FetchContent_MakeAvailable(Catch2)

FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG main
)
FetchContent_MakeAvailable(googletest)

add_executable(unit_test
  unit_test.cpp
  calc_test.cpp
  run_test.cpp
  )

target_include_directories(unit_test PRIVATE ${CMAKE_SOURCE_DIR}/src)
target_link_libraries(unit_test PRIVATE sut)

add_executable(catch2_test
  catch2_test.cpp)

target_include_directories(catch2_test PRIVATE ${CMAKE_SOURCE_DIR}/src)
target_link_libraries(catch2_test PRIVATE sut Catch2::Catch2WithMain)

add_executable(gtest_test
  gtest_test.cpp)

target_include_directories(gtest_test PRIVATE ${CMAKE_SOURCE_DIR}/src)
target_link_libraries(gtest_test PRIVATE sut gtest_main gmock)

add_test(NAME SumAddTwoInts COMMAND unit_test 1)
add_test(NAME MultiplyMultipliesTwoInts COMMAND unit_test 2)
add_test(NAME RunOutputsCorrectEquations COMMAND unit_test 3)

list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
include(Catch)
catch_discover_tests(catch2_test)

include(Coverage)
AddCoverage(gtest_test)

include(GoogleTest)
gtest_discover_tests(gtest_test)
