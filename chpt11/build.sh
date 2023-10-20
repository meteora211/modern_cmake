cmake -B `pwd`/build -S `pwd`
cmake --build `pwd`/build
cmake --install `pwd`/build

tree ./install

# cat ./build/cmake/CalcTargets.cmake
