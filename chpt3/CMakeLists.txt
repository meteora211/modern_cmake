cmake_minimum_required(VERSION 3.20)
project(Hello
        VERSION 0.1.2.3
        DESCRIPTION "hello project"
        LANGUAGES CXX)

message("Project related variables:")
message(STATUS "PROJECT_NAME: ${PROJECT_NAME}")
message(STATUS "CMAKE_PROJECT_NAME: ${CMAKE_PROJECT_NAME}")
message(STATUS "PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
message(STATUS "PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")
message(STATUS "Hello_SOURCE_DIR: ${Hello_SOURCE_DIR}")
message(STATUS "Hello_BINARY_DIR: ${Hello_BINARY_DIR}")

message(STATUS "PROJECT_VERSION: ${PROJECT_VERSION}")
message(STATUS "CMAKE_PROJECT_VERSION: ${CMAKE_PROJECT_VERSION}")
message(STATUS "PROJECT_VERSION_MAJOR: ${PROJECT_VERSION_MAJOR}")
message(STATUS "PROJECT_VERSION_MINOR: ${PROJECT_VERSION_MINOR}")
message(STATUS "PROJECT_VERSION_PATCH: ${PROJECT_VERSION_PATCH}")
message(STATUS "PROJECT_VERSION_TWEAK: ${PROJECT_VERSION_TWEAK}")

# use include to build but not recommend
# include(cars/cars.cmake)
# add_executable(car
#                main.cpp
#                ${CAR_SOURCES})

add_subdirectory(src)
