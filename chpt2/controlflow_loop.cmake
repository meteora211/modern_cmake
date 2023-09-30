cmake_minimum_required(VERSION 3.20.0)

# while loop
message("===========while==========")
set(VAR 0)
while(${VAR} LESS 3)
  MATH(EXPR VAR "${VAR}+1")
  message("looping: ${VAR}")
endwhile()

message("===========foreach range==========")

# for each

# foreach(<loop_var> RANGE <min> <max> [<step>])
foreach(VAR RANGE 0 6 2)
  message("looping: ${VAR}")
endforeach()

message("===========foreach var==========")
set(MyList 1 2 3)

# foreach(<loop_variable> IN [LISTS <lists>] [ITEMS <items>])
foreach(VAR IN LISTS MyList ITEMS 4 5 6)
  message("looping: ${VAR}")
endforeach()

# foreach(<loop_var>... IN ZIP_LISTS <lists>)
set(L1 "one;two;three")
set(L2 1 2 3)
foreach(VAR1 VAR2 IN ZIP_LISTS L1 L2)
  message("zip looping: ${VAR1} ${VAR2}")
endforeach()
