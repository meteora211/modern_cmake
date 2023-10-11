cmake_minimum_required(VERSION 3.20)
project(Hello LANGUAGES CXX)

# find_package(<Name> [version] [EXACT] [QUIET] [REQUIRED])
find_package(Protobuf REQUIRED)

protobuf_generate_cpp(GENERATED_SRC GENERATED_HEADER message.proto)

add_executable(message message.cpp ${GENERATED_SRC} ${GENERATED_HEADER})
# target_link_libraries(message PRIVATE ${Protobuf_LIBRARIES})
target_link_libraries(message PRIVATE protobuf::libprotobuf)
target_include_directories(message PRIVATE ${CMAKE_BINARY_DIR} ${Protobuf_INCLUDE_DIRS})

message(STATUS "Protobuf_FOUND: ${Protobuf_FOUND}")
message(STATUS "Protobuf_INCLUDE_DIRS: ${Protobuf_INCLUDE_DIRS}")
message(STATUS "Protobuf_LIBRARIES: ${Protobuf_LIBRARIES}")
message(STATUS "Protobuf_DEFINITIONS: ${Protobuf_DEFINITIONS}")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/module")

find_package(PQXX REQUIRED)
message(STATUS "PQXX_FOUND: ${PQXX_FOUND}")
add_executable(pqxx pqxx.cpp)
target_link_libraries(pqxx PRIVATE PQXX::PQXX)

configure_file(config.yaml config.yaml COPYONLY)
# add_subdirectory(extern/yaml-cpp)
# target_link_libraries(yaml_submodule PRIVATE yaml-cpp)

set(COMPILE_YAML "fetch")

if (COMPILE_YAML STREQUAL "submodule")
  add_executable(yaml_submodule yaml_config.cpp)
  find_package(yaml-cpp QUIET)
  if (NOT yaml-cpp_FOUND)
    message("yaml-cpp not found, initializing git submodule")
    # execute_process(
    #   COMMAND git submodule update --init -- extern/yaml-cpp
    #   WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    #   )
    # add_subdirectory(extern/yaml-cpp)
    find_package(Git)
    if (NOT Git_FOUND)
      message(FATAL_ERROR "Git not found")
    endif()
    execute_process(
      COMMAND ${GIT_EXECUTABLE} clone https://github.com/jbeder/yaml-cpp.git yaml-cpp-clone
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/extern
      )
    add_subdirectory(extern/yaml-cpp-clone)
  endif()
  target_link_libraries(yaml_submodule PRIVATE yaml-cpp)
elseif (COMPILE_YAML STREQUAL "external")
  # ExternalProject
  # FIXME: not work as expected
  include(ExternalProject)
  add_executable(yaml_external yaml_config.cpp)
  ExternalProject_Add(external-yaml-cpp
  GIT_REPOSITORY    https://github.com/jbeder/yaml-cpp.git
  GIT_TAG           yaml-cpp-0.6.3
  )
  target_link_libraries(yaml_external PRIVATE yaml-cpp)
  # include(CMakePrintHelpers)
  # cmake_print_properties(TARGETS external-yaml-cpp
  #                      PROPERTIES TYPE SOURCE_DIR)

elseif (COMPILE_YAML STREQUAL "fetch")
  include(FetchContent)
  add_executable(yaml_fetch yaml_config.cpp)
  FetchContent_Declare(external-yaml-cpp
    GIT_REPOSITORY    https://github.com/jbeder/yaml-cpp.git
    GIT_TAG           yaml-cpp-0.6.3
  )
  FetchContent_MakeAvailable(external-yaml-cpp)
  target_link_libraries(yaml_fetch PRIVATE yaml-cpp)
endif()
