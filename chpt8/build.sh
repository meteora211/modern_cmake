cmake -B `pwd`/build -S `pwd` -DCMAKE_BUILD_TYPE=Debug
cmake --build `pwd`/build -t coverage


# OUTPUT:
# Capturing coverage data from .
# geninfo cmd: '/usr/local/Cellar/lcov/2.0/bin/geninfo . --output-filename coverage.info --memory 0'
# Found LLVM gcov version 14.0.3, which emulates gcov version 4.2.0
# Using intermediate gcov format
# Writing temporary data to /tmp/geninfo_datq9uu
# Scanning . for .gcda files ...
# Found 1 data files in .
# Processing ./bin/CMakeFiles/sut.dir/calc.cpp.gcda
# Finished .info-file creation
# Removed 0 files
# Writing data to filtered.info
# Summary coverage rate:
#   lines......: 100.0% (6 of 6 lines)
#   functions..: 100.0% (3 of 3 functions)
#   branches...: no data found
# lcov: WARNING: ('unused') 'exclude' pattern '/usr/include*' is unused.
# Found 1 entries.
# Found common filename prefix "/Users/zhaoruichen/workspace/modern_cmake/chpt8"
# Generating output.
# Processing file src/calc.cpp
#   lines=6 hit=6 functions=3 hit=3
# Overall coverage rate:
#   lines......: 100.0% (6 of 6 lines)
#   functions......: 100.0% (3 of 3 functions)
# [100%] Built target coverage
