cmake_minimum_required(VERSION 3.20)
project(Tests VERSION 1.2.3 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)

find_package(Git)
execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --show-toplevel
  OUTPUT_VARIABLE GIT_ROOT
  OUTPUT_STRIP_TRAILING_WHITESPACE
  )
set(INSTALL_DIR "${GIT_ROOT}/install")
message(STATUS "Set install_dir git root: ${INSTALL_DIR}")
set(CMAKE_INSTALL_PREFIX ${INSTALL_DIR})

enable_testing()
add_subdirectory(src bin)
add_subdirectory(test)
# enable CMAKE_INSTALL_LIBDIR, etc.
# include(GNUInstallDirs)

# Generate cmake file under build
# use cat ./build/cmake/CalcTargets.cmake to show the content
# set(EXPORT_DIR "${CMAKE_CURRENT_BINARY_DIR}/cmake")
# export(TARGETS calc
#   FILE "${EXPORT_DIR}/CalcTargets.cmake"
#   NAMESPACE Calc::
#   )

set(USE_INCLUDE_DIR 0)
if(NOT ${USE_INCLUDE_DIR})
  #install lib. Note that PUBLIC_HEADER is defined as target_property before
  install(TARGETS calc EXPORT CalcTargets
    ARCHIVE DESTINATION "calc/lib"
    PUBLIC_HEADER DESTINATION "calc/include")

  #install files
  install(FILES
    src/rng.h
    DESTINATION "calc/include"
    )
else()
  install(TARGETS calc EXPORT CalcTargets
    ARCHIVE DESTINATION "calc/lib")
  # install dir
  # set(CMAKE_INSTALL_INCLUDEDIR "${INSTALL_DIR}/calc/include")
  install(DIRECTORY src/ # TYPE INCLUDE
    DESTINATION "include"
    FILES_MATCHING PATTERN "*.h"
    PATTERN "ignored" EXCLUDE
    )
endif()

#install export
install(EXPORT CalcTargets
  DESTINATION "calc/cmake"
  NAMESPACE Calc::)

# data/ -> ./install/data.csv
# data -> ./install/data/data.csv
install(DIRECTORY data/ DESTINATION "calc")

# set(CMAKE_INSTALL_SYSCONFDIR "${INSTALL_DIR}/calc/conf")
install(DIRECTORY config/ # TYPE SYSCONF
  DESTINATION "conf"
  DIRECTORY_PERMISSIONS
  OWNER_READ OWNER_WRITE OWNER_EXECUTE
  PATTERN "no_exe_permission.conf" PERMISSIONS 
  OWNER_READ OWNER_WRITE 
  )


include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/CalcConfigVersion.cmake"
  COMPATIBILITY AnyNewerVersion
  )
set(USE_BASIC_CONFIG 0)
if(${USE_BASIC_CONFIG})
  install(FILES CalcConfig.cmake
    "${CMAKE_CURRENT_BINARY_DIR}/CalcConfigVersion.cmake"
    DESTINATION "calc/cmake")
else()
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
endif()

set(CPACK_PACKAGE_VENDOR "Rafal Swidzinski")
set(CPACK_PACKAGE_CONTACT "email@example.com")
set(CPACK_PACKAGE_DESCRIPTION "Simple Calculator")
include(CPack)
