# single line comment

message("Hi") # comment after command

#[=[
bracked comment
#[[
nested bracked comment
#]]
#]=]

# bracket arguments
message([[multiline
        bracked
        argument]])

# quoted arguments
message("1. escape sequence: \" \n in a quoted argument")
message("2. multi...
line")
message("3. and variable ${CMAKE_VERSION}")

# unquoted arguments
message(a\ single\ argument)
message(two argument)
message(three;separated;arguments)
message(${CMAKE_VERSION})
message(()()()) # matching parentheses
