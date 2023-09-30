# cmake -P useful_commands.cmake --log-level TRACE --log-context
cmake_minimum_required(VERSION 3.20.0)

# message(<MODE> "text")
message(WARNING "warning")
message(STATUS "status")
message(VERBOSE "verbose")
message(DEBUG "debug")
message(TRACE "trace")

# message with CMAKE_MESSAGE_CONTEXT
function(foo)
  list(APPEND CMAKE_MESSAGE_CONTEXT "foo")
  list(APPEND CMAKE_MESSAGE_INDENT "    ")
  message("foo message")
endfunction()

list(APPEND CMAKE_MESSAGE_CONTEXT "top")
message("before foo")
foo()
message("after foo")

# include()
# include(<file|module> [OPTIONAL] [RESULT_VARIABLE <var>])
include("${CMAKE_CURRENT_LIST_DIR}/include_guard.cmake" RESULT_VARIABLE include_result_good)
include("${CMAKE_CURRENT_LIST_DIR}/doesnt_exists.cmake" OPTIONAL RESULT_VARIABLE include_result_bad)
# include_result will be: FULLPATH OF THE FILE or NOTFOUND
message(${include_result_good})
message(${include_result_bad})

# file()
# TBD

# execute_process()
# TBD
