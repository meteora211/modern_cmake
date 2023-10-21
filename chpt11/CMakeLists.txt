cmake_minimum_required(VERSION 3.20)
project(Tests LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)

enable_testing()
add_subdirectory(src bin)
add_subdirectory(test)


# Generate cmake file under build
# use cat ./build/cmake/CalcTargets.cmake to show the content
# set(EXPORT_DIR "${CMAKE_CURRENT_BINARY_DIR}/cmake")
# export(TARGETS calc
#   FILE "${EXPORT_DIR}/CalcTargets.cmake"
#   NAMESPACE Calc::
#   )

set(USE_INCLUDE_DIR 1)
if(NOT ${USE_INCLUDE_DIR})
  #install lib. Note that PUBLIC_HEADER is defined as target_property before
  install(TARGETS calc EXPORT CalcTargets
    ARCHIVE DESTINATION "${CMAKE_SOURCE_DIR}/install/lib"
    PUBLIC_HEADER DESTINATION "${CMAKE_SOURCE_DIR}/install/include")

  #install files
  install(FILES
    src/rng.h
    DESTINATION "${CMAKE_SOURCE_DIR}/install/include"
    )


else()
  install(TARGETS calc EXPORT CalcTargets
    ARCHIVE DESTINATION "${CMAKE_SOURCE_DIR}/install/lib")
  # install dir
  set(CMAKE_INSTALL_INCLUDEDIR "${CMAKE_SOURCE_DIR}/install/include")
  install(DIRECTORY src/ TYPE INCLUDE
    # DESTINATION "${CMAKE_SOURCE_DIR}/install/include"
    FILES_MATCHING PATTERN "*.h"
    PATTERN "ignored" EXCLUDE
    )
endif()

#install export
install(EXPORT CalcTargets
  DESTINATION  "${CMAKE_SOURCE_DIR}/install/cmake"
  NAMESPACE Calc::)

# data/ -> ./install/data.csv
# data -> ./install/data/data.csv
install(DIRECTORY data/ DESTINATION  "${CMAKE_SOURCE_DIR}/install")

set(CMAKE_INSTALL_SYSCONFDIR "${CMAKE_SOURCE_DIR}/install/conf")
install(DIRECTORY config/ TYPE SYSCONF DIRECTORY_PERMISSIONS
  OWNER_READ OWNER_WRITE OWNER_EXECUTE
  PATTERN "no_exe_permission.conf" PERMISSIONS 
  OWNER_READ OWNER_WRITE 
  )

install(FILES CalcConfig.cmake DESTINATION
    "${CMAKE_SOURCE_DIR}/install/cmake")
