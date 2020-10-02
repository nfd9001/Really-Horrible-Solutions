#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
volatile int i=0;
int us[]={1,0,54,13,33,34,22,16,48,11,6};
int r=sizeof(us)/sizeof(int);
int* s;
pthread_t* p;
void *w(void *a){sleep(us[(intptr_t)a]);s[i]=us[(intptr_t)a];i++;}void sort(void){s=calloc(sizeof(us),1);p=calloc(r,sizeof(pthread_t));for(intptr_t j=0;j<r;j++){pthread_create(p+j,0,w,(void*)j);}for(int j=0;j<r;j++){pthread_join(p[j],0);}}void main(void){sort(); for(int j=0;j<r;j++){printf("%i\n",s[j]);}}
