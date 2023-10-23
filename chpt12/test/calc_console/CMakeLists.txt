add_executable(tui_test tui_test.cpp)
target_link_libraries(tui_test PRIVATE calc_console_static)
AddTests(tui_test)
EnableCoverage(calc_console_static)

