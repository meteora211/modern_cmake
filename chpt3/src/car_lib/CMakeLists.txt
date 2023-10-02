set(CAR_SOURCES
    car.cpp)
add_library(carlib 
            ${CAR_SOURCES})
target_include_directories(carlib PUBLIC .)
