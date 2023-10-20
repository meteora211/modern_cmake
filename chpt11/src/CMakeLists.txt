add_library(calc STATIC calc.cpp run.cpp rng.cpp)
target_include_directories(calc PUBLIC .)

add_executable(main bootstrap.cpp)
target_link_libraries(main PRIVATE calc)
