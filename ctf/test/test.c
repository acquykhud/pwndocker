#include <stdio.h>
#include <stdlib.h>

int main()
{
    char* a = (char*)malloc(10);
   a[1]= 0;
   a[0] = '\n';
   printf(a);
 free(a);
return 0;
}
