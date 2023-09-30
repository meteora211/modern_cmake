cmake_minimum_required(VERSION 3.20.0)

set(VAR1 FALSE)
set(VAR2 TRUE)
set(VAR3 "VAR1")

# Evaluate variable
if(${VAR2})
  message("printed 1")
endif()

if(${VAR3}) # ${VAR3} => VAR1 => FALSE
  message("not printed 1")
endif()

# Evaluate unquoted argument
if(FOO) # empty
  message("not printed 2")
endif()

set(FOO "FOO")

# if(VAR) evaluated to false only when VAR is any of following:
# - OFF, NO, FALSE, N, IGNORE, NOTFOUND
# - A string ending with -NOTFOUND
# - An empty string
# - Zero
if(FOO) # => if(DEFINED FOO)
  message("printed 2")
endif()

# Strings are considered Boolean true only if they equal any of the following constants (these comparisons are case insensitive):
# - ON, Y, YES, or TRUE
# - A non-zero number
if ("FOO")
  message("not printed 3")
endif()

if ("ON")
  message("printed 3")
endif()

set(FOO "FOO-NOTFOUND")
if(FOO)
  message("not printed 4")
endif()

if(DEFINED FOO)
  message("printed 4")
endif()

# Compare
if (1 LESS 2)
  message("Correct 1.")
endif()

if (1.3.4 VERSION_LESS_EQUAL 1.4)
  message("Correct 2.")
endif()

set(B "A")
if ("A" STREQUAL "${B}")
  message("Correct 3.")
endif()

# check list
set(MyList "1;2;3;4;5")
if ("1" IN_LIST MyList)
  message("Correct 4.")
endif()

function(func)
  message(func called)
endfunction()
# command available
if (COMMAND func)
  message("Correct 5.")
endif()

# file exist
if (EXISTS "basic.cmake")
  message("Correct 6.")
endif()

if (IS_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
  message("Correct 7.")
endif()
