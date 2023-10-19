cmake_minimum_required(VERSION 3.20)
project(Tests LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)

enable_testing()
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
add_subdirectory(src bin)
add_subdirectory(test)
