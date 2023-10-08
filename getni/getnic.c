#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
  char hostname[1024];
  gethostname(hostname, 1024);
  puts("host:");
  puts(hostname);

  char domain[1024];
  getdomainname(domain, 1024);
  puts("domain:");
  puts(domain);

  return EXIT_SUCCESS;
}
