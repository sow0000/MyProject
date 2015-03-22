#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<time.h>

void merge(int* in, int n); //function for merge sort

int main(){
	int i, n, *in=0; //condition, input array
	long start, finish; //calculating running time
	struct timespec tp; //timespec structure

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
	merge(in, n); //merge sort
	clock_gettime(CLOCK_REALTIME, &tp);
	finish=tp.tv_nsec;

	printf("\nResult : ");
	for(i=0;i<n;i++) printf("%d ",in[i]);
	printf("\n%ld\n",finish-start);

	free(in);

	return 0;
}

void merge(int* in, int n){
	if(n>2){
		int tn1=n/2, tn2=tn1+(n%2), i, j=0, k=0, //divided size, sort condition
			*in1, *in2;
		in1=(int*)calloc(tn1+1,sizeof(int));
		in2=(int*)calloc(tn2+1,sizeof(int));

		memcpy(in1,in,sizeof(int)*tn1); //copy 1~n/2
		memcpy(in2,in+tn1,sizeof(int)*tn2); //copy n/2~n

		merge(in1, tn1); //merge 1~n/2
		merge(in2, tn2); //merge n/2~n
		
		for(i=0;i<n;i++){
			if(j==tn1){ //if in1 sorted
				in[i]=in2[k];
				k++;
			}
			else if(k==tn2){ //if in2 sorted
				in[i]=in1[j];
				j++;
			}
			else if(in1[j]<in2[k]){ //in1 < in2
				in[i]=in1[j];
				j++;
			}
			else{ //in2 < in1
				in[i]=in2[k];
				k++;
			}
		}

		free(in1);
		free(in2);
	}
	else if((n!=1)&&(in[0]>in[1])){ //swap data
		int t=in[0];
		in[0]=in[1];
		in[1]=t;
	}
}
