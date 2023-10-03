cmake -B `pwd`/build -S `pwd` --graphviz=`pwd`/build/test.dot
cmake --build `pwd`/build

cat `pwd`/build/test.dot
