cmake -B `pwd`/build -S `pwd` -DCMAKE_BUILD_TYPE=Debug
cmake --build `pwd`/build
cmake --build `pwd`/build -t coverage-calc_test
cmake --build `pwd`/build -t coverage-tui_test
cmake --build `pwd`/build -t memcheck-calc_test
cmake --build `pwd`/build -t memcheck-tui_test
cmake --install `pwd`/build

tree ../install
cd build && cpack -G "ZIP;7Z;DEB" -B packages

