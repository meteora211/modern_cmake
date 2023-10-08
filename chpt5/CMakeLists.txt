cmake_minimum_required(VERSION 3.20)
project(Hello LANGUAGES CXX)

add_executable(main main.cpp)

# set target sources
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  target_sources(main PRIVATE gui_linux.cpp)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
  target_sources(main PRIVATE gui_windows.cpp)
endif()

set(VAR 8)

# PREPROCESS:
# 1 set target include directory
target_include_directories(main PRIVATE
  ${CMAKE_SOURCE_DIR}
  ${CMAKE_BINARY_DIR})

# 2 set target compile definition
target_compile_definitions(main PRIVATE ABC "DEF=${VAR}")

# git commit sha as definition
execute_process(COMMAND git log -1 --pretty=format:%h
                OUTPUT_VARIABLE SHA)
if (SHA STREQUAL "")
  set(SHA ----------------------------------------)
endif()
target_compile_definitions(main PRIVATE "SHA=${SHA}")

# 3 configure file
set(FOO_ENABLE ON)
set(FOO_ENABLE1 "enable1_abc")
set(FOO_ENABLE2 "enable2_def")
configure_file(configure.h.in configured/configure.h)

# Configure optimizer
target_compile_options(main PRIVATE -O3 -Wall -Werror)

# Manage compilation
# 1 reduce compile time
target_precompile_headers(main PRIVATE <iostream>)

# 2 debugging
# add compile options via set_target_properties
get_target_property(PROP main COMPILE_OPTIONS)
# -H and -save-temps
set_target_properties(main PROPERTIES
  COMPILE_OPTIONS "${PROP};-H;-save-temps=obj")
