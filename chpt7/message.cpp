#include "message.pb.h"
#include <fstream>

using namespace std;

int main() {
  Message m;
  m.set_id(23);
  m.PrintDebugString();
  fstream fo("./hello.data", ios::binary | ios::out);
  m.SerializeToOstream(&fo);
  fo.close();
}
