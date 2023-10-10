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
