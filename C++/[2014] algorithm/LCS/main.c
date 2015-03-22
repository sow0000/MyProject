#include <stdio.h>
#include <string.h>

#define LEN_X 7
#define LEN_Y 6

enum dir{LEFTUP=1, LEFT, UP};

char max(char a, char b); //function for max
char prob6_1(char *x, char *y, int i, int j); //function for memoization
void prob6_2(char *x, char *y); //function for dynamic programming
void print_LCS(int i, int j); //function for print out LCS

char x[LEN_X+1]="ABCBDAB"; //sequence x
char y[LEN_Y+1]="BDCABA"; //sequence y
char a[LEN_X+1][LEN_Y+1]; //length array for 6-1
char b[LEN_X+1][LEN_Y+1]={0,}; //direction array for 6-2
char c[LEN_X+1][LEN_Y+1]={0,}; //length array for 6-2

int main(){
	char n;
	memset(a, -1, sizeof(a));

	n=prob6_1(x, y, LEN_X, LEN_Y); //top-down
	printf("Problem 6-1 : %d\n", n);

	prob6_2(x, y); //bottom-up

	return 0;
}

char max(char a, char b){
	if(a>b) return a;
	else return b;
}

char prob6_1(char *x, char *y, int i, int j){
	if(i==0 || j==0) return 0; //if end of sequence, return 0
	if(a[i][j]==-1){ //if a[i][j] is not calculated
		if(x[i-1]==y[j-1]) a[i][j]=prob6_1(x, y, i-1, j-1)+1; //x and y are same
		else a[i][j]=max(prob6_1(x, y, i-1, j), prob6_1(x, y, i, j-1)); //x and y are not same
	}
	return a[i][j]; //return a[i][j]
}

void prob6_2(char *x, char *y){
	int i, j; //variable for loop

	for(i=1;i<=LEN_X;i++){
		for(j=1;j<=LEN_Y;j++){
			if(x[i-1]==y[j-1]){ //x and y are same
				c[i][j]=c[i-1][j-1]+1; //c(i-1,j-1)+1
				b[i][j]=LEFTUP; //left up
			}
			else if(c[i-1][j]>=c[i][j-1]){ //length of (i-1,j) is bigger than (i,j-1)
				c[i][j]=c[i-1][j]; //c(i-1,j)
				b[i][j]=UP; //up
			}
			else{ //length of (i-1,j) is smaller than (i,j-1)
				c[i][j]=c[i][j-1]; //c(i,j-1)
				b[i][j]=LEFT; //left
			}
		}
	}

	printf("Problem 6-2 : %d\n", c[i-1][j-1]); //print out length
	printf("Result of LCS : ");
	print_LCS(LEN_X, LEN_Y); //print out LCS
	printf("\n");
}

void print_LCS(int i, int j){
	if(i==0 || j==0) return; //if end of sequence, return
	if(b[i][j]==LEFTUP){ //if left up
		print_LCS(i-1, j-1); //print out common seqeunce
		printf("%c ", x[i-1]);
	}
	else if(b[i][j]==UP) print_LCS(i-1, j); //if up, move up
	else print_LCS(i, j-1); //if left, move left
}