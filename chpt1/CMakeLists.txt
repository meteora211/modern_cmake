cmake_minimum_required(VERSION 3.20)
project(Hello)

include (TestBigEndian)
TEST_BIG_ENDIAN(IS_BIG_ENDIAN)
if(IS_BIG_ENDIAN)
message("BIG_ENDIAN")
else()
message("LITTLE_ENDIAN")
endif()

add_executable(hello hello.cc)

