#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>
#include<time.h>

void insertion(int* in, int n); //function for insertion sort

int main(){
	int i, n, *in=0; //condition, input array
	long start, finish;
	struct timespec tp;

	srand(time(NULL)); //randomize

	printf("Insert size : "); //read size
	scanf("%d",&n);

	in=(int*)calloc(n+1,sizeof(int)); //memory allocate

	printf("\nInput : "); //random data
	for(i=0;i<n;i++){
		in[i]=rand()%n+1;
		printf("%d ",in[i]);
	}

	clock_gettime(CLOCK_REALTIME, &tp);
	start=tp.tv_nsec;
	insertion(in, n);
	clock_gettime(CLOCK_REALTIME, &tp);
	finish=tp.tv_nsec;

	printf("\nResult : ");
	for(i=0;i<n;i++) printf("%d ",in[i]);
	printf("\n%ld\n",finish-start);

	free(in);

	return 0;
}

void insertion(int* in, int n){
	int k, i, j; //key, loop condition
	for(j=1;j<n;j++){
		k=in[j];
		i=j-1;
		while(i>=0 && in[i]>k){
			in[i+1]=in[i];
			i--;
		} //end of while
		in[i+1]=k;
	} //end of for
}
