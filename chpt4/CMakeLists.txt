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
