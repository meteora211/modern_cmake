cmake_minimum_required(VERSION 3.20.0)
project(BankApp CXX)

add_executable(terminal terminal_app.cpp)
add_executable(gui gui_app.cpp)

# set target properties
set_target_properties(gui PROPERTIES
                    CXX_STANDARD 20
                    COMPILE_FLAGS -Wno-unused)

target_link_libraries(terminal calculations)
target_link_libraries(gui calculations drawing)

add_library(calculations calculations.cpp)
add_library(drawing drawing.cpp)

# custom target
# XXX: custom target is EXCLUDE_FROM_ALL by default, and need
# manually specify created files via BYPRODUCTS for cmake clean
add_custom_target(checksum ALL
                  COMMAND sh -c "cksum terminal>terminal.ck"
                  COMMAND sh -c "cksum gui>gui.ck"
                  BYPRODUCTS terminal.ck gui.ck
                  COMMENT "Checking the sum"
                  )

add_dependencies(checksum terminal gui)

# get target properties
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
# XXX: use add_custom_target to print msg during generation stage
add_custom_target(destination_dbg ALL
  COMMAND ${CMAKE_COMMAND} -E echo \"COMPILE_DEFINITIONS: $<TARGET_PROPERTY:destination,COMPILE_DEFINITIONS>\"
  COMMAND ${CMAKE_COMMAND} -E echo \"COMPILE_OPTIONS: $<TARGET_PROPERTY:destination,COMPILE_OPTIONS>\"
  COMMAND ${CMAKE_COMMAND} -E echo \"LIB_VERSION: $<TARGET_PROPERTY:destination,LIB_VERSION>\"
)

# EXCLUDE_FROM_ALL test
add_executable(efa EXCLUDE_FROM_ALL empty.cpp)

# custom command
add_executable(custom_command custom_command.cpp constant.h)
target_include_directories(custom_command PRIVATE ${CMAKE_BINARY_DIR})
add_custom_command(OUTPUT constant.h
  COMMAND cp ARGS "${CMAKE_SOURCE_DIR}/template.inc" constant.h)
add_custom_command(TARGET custom_command POST_BUILD
                   COMMAND cksum
                   ARGS "$<TARGET_FILE:custom_command>" > "custom_command.ck")

# genexes
# 1. use add_custom_target to print
add_custom_target(gendbg ALL
  COMMAND ${CMAKE_COMMAND} -E echo \"nested genexes: $<UPPER_CASE:$<PLATFORM_ID>>\"
)
set(myvar1 "small text")
set(myvar2 "small > text")
# 2. use file command to output
file(GENERATE OUTPUT output_log CONTENT
"CONFIG: $<IF:$<CONFIG:Debug>,Debug,Release>\n\
PLATFORM: $<PLATFORM_ID>\n\
TARGET_NAME_IF_EXISTS: $<TARGET_NAME_IF_EXISTS:efa>\n\
TARGET_FILE: $<TARGET_FILE:efa>\n\
TARGET_FILE_DIR: $<TARGET_FILE_DIR:efa>\n\
$<UPPER_CASE:${myvar1}>\n\
$<UPPER_CASE:${myvar2}>\n\
-1 $<0:TRUE>\n\
-2 $<1:TRUE>\n\
-3 $<0:TRUE,FALSE>(won't work)\n\
-4 $<1:TRUE,FALSE>(won't work)\n\
-5 $<IF:0,TRUE,FALSE>\n\
-6 $<IF:0,TRUE,>\n\
"
)
