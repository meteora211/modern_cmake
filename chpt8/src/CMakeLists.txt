add_library(sut STATIC calc.cpp run.cpp rng.cpp)
target_include_directories(sut PUBLIC .)

add_executable(main bootstrap.cpp)
target_link_libraries(main PRIVATE sut)
