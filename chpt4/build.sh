cmake -B `pwd`/build -S `pwd` --graphviz=`pwd`/build/test.dot
# cmake --build `pwd`/build --target destination
cmake --build `pwd`/build --target all
cmake --build `pwd`/build --target efa

# cat `pwd`/build/test.dot
