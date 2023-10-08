#include <iostream>
#include <configured/configure.h>
#define str(s) #s
#define xstr(s) str(s)

void show_gui();

int main() {
  show_gui();
#if defined(SHA)
  std::cout << "GIT commit: " << xstr(SHA) << std::endl;
#endif

#ifdef FOO_ENABLE
  std::cout <<"FOO_ENABLE ON" << std::endl;
#endif
  std::cout <<"FOO_ENABLE1: " << xstr(FOO_ENABLE1) << std::endl;
  std::cout <<"FOO_ENABLE2: " << xstr(FOO_ENABLE2) << std::endl;
  std::cout <<"FOO_UNDEFINED: " << xstr(FOO_UNDEFINED) << std::endl;
}
