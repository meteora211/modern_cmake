cmake_minimum_required(VERSION 3.20.0)

# ${}: normal or cache variables
# $ENV{}: environment variables
# $CACHE{}: cache variables

# set variable
set(MyString1 "Text1")
set([[My String2]] "Text2")
set("My String 3" "Text3")

message(${MyString1})
message(${My\ String2})
message(${My\ String\ 3})

# variable reference
set(MyOuter "Outer")
set(MyInner "Inner")
set(MyOuterInner "Combined")
message("${MyOuter${MyInner}}")

set(${MyOuter} "Hello")
set(${MyInner} "World")
message("${Outer} ${Inner}")

# env variable
set(ENV{CXX} "clang++")
message($ENV{CXX})
unset(ENV{CXX})

# cache variable:
# set(<variable> <value> CACHE <type> <docstring> [FORCE])
set(FOO "BAR" CACHE STRING "interesting value")
