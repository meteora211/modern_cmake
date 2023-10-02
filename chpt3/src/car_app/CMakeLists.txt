add_executable(car main.cpp)
target_link_libraries(car PRIVATE carlib race_carlib)
set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-fno-exceptions")
