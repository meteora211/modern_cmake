include(GetFTXUI)
add_library(calc_console_static STATIC tui.cpp)
target_include_directories(calc_console_static PUBLIC include)
target_precompile_headers(calc_console_static PUBLIC <string>)
target_link_libraries(calc_console_static PUBLIC calc_shared
  ftxui::screen ftxui::dom ftxui::component)
include(BuildInfo)
BuildInfo(calc_console_static)
include(Coverage)
CleanCoverage(calc_console_static)
include(Format)
Format(calc_console_static .)
# include(CppCheck)
# AddCppCheck(calc_console_static)

add_executable(calc_console bootstrap.cpp)
target_link_libraries(calc_console calc_console_static)
