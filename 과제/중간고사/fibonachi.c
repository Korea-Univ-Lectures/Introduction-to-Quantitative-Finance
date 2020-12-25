#include "stdio.h"


int main() {

  int i=1,j=2,k=0,t=2;

  while (1) {

  k=i+j;
  if (k <= 2000000 && k % 2 == 0) {
    t += k;
  }else if (k> 2000000) break;
   
  i=j;
  j=k;

  }
  printf("%d",t);

  return 0;
}