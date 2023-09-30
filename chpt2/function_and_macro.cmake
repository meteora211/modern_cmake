cmake_minimum_required(VERSION 3.20.0)

# macro
macro(MyMacro macroVar)
  set(macroVar "new value")
  message("argument: ${macroVar}")
  message("arg0: ${ARG0}")
  message("arg1: ${ARG1}")
  message("argc: ${ARGC}")
  message("argv: ${ARGV}")
  message("argn: ${ARGN}")
endmacro()

set(macroVar "init value")
message("macroVar init with: ${macroVar}")
MyMacro("call value" "arg1" "arg2")
# NOTE: macro call changes macroVar
message("macroVar return with: ${macroVar}")

# function
function(MyFunc funcVar)
  set(funcVar "new value")
  message("argument: ${funcVar}")
  message("arg0: ${ARG0}")
  message("arg1: ${ARG1}")
  message("argc: ${ARGC}")
  message("argv: ${ARGV}")
  message("argn: ${ARGN}")
  message("Function: ${CMAKE_CURRENT_FUNCTION}")
  message("File: ${CMAKE_CURRENT_FUNCTION_LIST_FILE}")
  message("Dir: ${CMAKE_CURRENT_FUNCTION_LIST_DIR}")
  message("Line: ${CMAKE_CURRENT_FUNCTION_LIST_LINE}")
endfunction()

set(funcVar "init value")
message("funcVar init with: ${funcVar}")
MyFunc("call value" "arg1" "arg2")
message("funcVar return with: ${funcVar}")
