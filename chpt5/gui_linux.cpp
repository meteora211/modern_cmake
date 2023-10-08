#include <iostream>
#include <test.h>

void show_gui() {
  std::cout << "linux gui" << std::endl;
  show_gui_more();
#if defined(ABC)
  std::cout << "ABC" << std::endl;
#endif

#if (DEF > 3)
  std::cout << "DEF" << std::endl;
#endif
}
