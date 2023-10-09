cmake_minimum_required(VERSION 3.20)
project(Hello LANGUAGES CXX)

add_library(static_lib STATIC func_lib.cpp)
add_library(dynamic_lib SHARED func_lib.cpp)
add_library(module_lib MODULE func_lib.cpp)

add_library(a SHARED linka.cpp)
add_library(b SHARED linkb.cpp)

add_executable(main_1 main.cpp)
add_executable(main_2 main.cpp)

target_link_libraries(main_1 a b)
target_link_libraries(main_2 b a)

add_library(outer outer.cpp)
add_library(nested nested.cpp)
add_executable(order order.cpp)
# Error with wrong order
# target_link_libraries(order nested outer)
target_link_libraries(order outer nested)
# or repeat the dependency:
# target_link_libraries(order nested outer nested)
