cmake -B `pwd`/build -S `pwd`
cmake --build `pwd`/build
cmake --install `pwd`/build


# cat ./build/cmake/CalcTargets.cmake

cmake -B `pwd`/find_package/build -S `pwd`/find_package -DCMAKE_PREFIX_PATH=`pwd`/../install/

tree ../install
