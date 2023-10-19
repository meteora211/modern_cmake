add_executable(main main.cpp)
include(Format)
Format(main .)

# include(ClangTidy)
# AddClangTidy(main)

include(Valgrind)
AddValgrind(main)

include(Memcheck)
AddMemcheck(main)
