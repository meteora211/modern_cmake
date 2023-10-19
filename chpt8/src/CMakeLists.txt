add_library(sut STATIC calc.cpp run.cpp rng.cpp)
target_include_directories(sut PUBLIC .)

add_executable(main bootstrap.cpp)
target_link_libraries(main PRIVATE sut)

if (CMAKE_BUILD_TYPE STREQUAL Debug)
  target_compile_options(sut PRIVATE --coverage)
  target_link_libraries(sut PUBLIC --coverage)
  add_custom_target(TARGET sut PRE_BUILD COMMAND
    find ${CMAKE_BINARY_DIR} -type f -name '*.gcda' -exec rm {} +)
endif()
