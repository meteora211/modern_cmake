# cmake -B <build tree> -S <source tree>
# cmake --build <build tree>

cmake -B `pwd`/build -S `pwd`
cmake --build `pwd`/build

# run cmake script
cmake -P `pwd`/script.cmake

# cmake command-line tool
cmake -E cat hello.cc
