cmake_minimum_required(VERSION 3.20.0)
project(BankApp CXX)

add_executable(terminal terminal_app.cpp)
add_executable(gui gui_app.cpp)

set_target_properties(gui PROPERTIES
                    CXX_STANDARD 20
                    COMPILE_FLAGS -Wno-unused)

target_link_libraries(terminal calculations)
target_link_libraries(gui calculations drawing)

add_library(calculations calculations.cpp)
add_library(drawing drawing.cpp)

add_custom_target(checksum ALL
                  COMMAND sh -c "cksum terminal>terminal.ck"
                  COMMAND sh -c "cksum gui>gui.ck"
                  BYPRODUCTS terminal.ck gui.ck
                  COMMENT "Checking the sum"
                  )

add_dependencies(checksum terminal gui)

get_target_property(GUI_CFLAGS gui COMPILE_FLAGS)
message(STATUS "GUI_CFLAGS: ${GUI_CFLAGS}")

# property propagate
add_library(source1 empty.cpp)
target_compile_definitions(source1 PUBLIC FOOPUBLIC)
target_compile_definitions(source1 INTERFACE FOOINTERFACE)
target_compile_definitions(source1 PRIVATE FOOPRIVATE)
set_property(TARGET source1 PROPERTY INTERFACE_LIB_VERSION 4)
set_property(TARGET source1 APPEND PROPERTY COMPATIBLE_INTERFACE_STRING LIB_VERSION)

get_target_property(source1_private_prop source1 COMPILE_DEFINITIONS)
get_target_property(source1_interface_prop source1 INTERFACE_COMPILE_DEFINITIONS)
get_target_property(source1_interface_lib_ver source1 INTERFACE_LIB_VERSION)
message(STATUS "source1_private_prop: ${source1_private_prop}")
message(STATUS "source1_interface_prop: ${source1_interface_prop}")
message(STATUS "source1_interface_lib_ver: ${source1_interface_lib_ver}")

add_library(source2 empty.cpp)
# XXX: CMake Error if INTERFACE_LIB_VERSION mismatch between source1 source2
# CMake Error: The INTERFACE_LIB_VERSION property of "source2" does
# not agree with the value of LIB_VERSION already determined
# for "destination".
set_property(TARGET source2 PROPERTY INTERFACE_LIB_VERSION 4)

# INTERFACE library
add_library(warning_props INTERFACE)
target_compile_options(warning_props INTERFACE -Wall -Wextra -Wpedantic)

add_library(destination empty.cpp)
target_link_libraries(destination PUBLIC source1 source2 warning_props)

get_target_property(destination_cdefs destination COMPILE_DEFINITIONS)
get_target_property(destination_copts destination COMPILE_OPTIONS)
get_target_property(destination_lib_ver destination LIB_VERSION)
# XXX: get_target_property during configuration returns NOTFOUND, see:
# https://stackoverflow.com/questions/43554085/target-link-libraries-and-include-directories-property
message(STATUS "destination_cdefs: ${destination_cdefs}")
message(STATUS "destination_copts: ${destination_copts}")
message(STATUS "destination_lib_ver: ${destination_lib_ver}")

add_executable(efa EXCLUDE_FROM_ALL empty.cpp)
