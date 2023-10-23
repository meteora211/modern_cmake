include(GNUInstallDirs)

find_package(Git)
execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --show-toplevel
  OUTPUT_VARIABLE GIT_ROOT
  OUTPUT_STRIP_TRAILING_WHITESPACE
  )
set(INSTALL_DIR "${GIT_ROOT}/install")
message(STATUS "Set install_dir git root: ${INSTALL_DIR}")
set(CMAKE_INSTALL_PREFIX ${INSTALL_DIR})

install(TARGETS calc_obj calc_shared calc_static
  EXPORT CalcLibrary
  ARCHIVE COMPONENT development
  LIBRARY COMPONENT runtime
  PUBLIC_HEADER
  DESTINATION calc
  COMPONENT runtime)

install(EXPORT CalcLibrary
  DESTINATION calc/cmake
  NAMESPACE Calc::
  COMPONENT runtime)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/CalcConfigVersion.cmake"
  COMPATIBILITY AnyNewerVersion
  )
set(CMAKE_INSTALL_DIR "calc/")
configure_package_config_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/CalcConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/CalcConfig.cmake
  INSTALL_DESTINATION "calc/cmake"
  PATH_VARS CMAKE_INSTALL_DIR
  )
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/CalcConfig.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/CalcConfigVersion.cmake"
  DESTINATION "calc/cmake"
  )
# CalcConsole runtime
install(TARGETS calc_console
  RUNTIME COMPONENT runtime
)

set(CPACK_PACKAGE_VENDOR "zhaorui")
set(CPACK_PACKAGE_CONTACT "email@example.com")
set(CPACK_PACKAGE_DESCRIPTION "Simple Calculator")
include(CPack)
