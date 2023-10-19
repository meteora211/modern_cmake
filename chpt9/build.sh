cmake -B `pwd`/build -S `pwd`
cmake --build `pwd`/build -t valgrind memcheck
