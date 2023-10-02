set(RACECAR_SOURCES
    race_car.cpp)
add_library(race_carlib 
            ${RACECAR_SOURCES})
target_include_directories(race_carlib PUBLIC .)
target_link_libraries(race_carlib PUBLIC carlib)
