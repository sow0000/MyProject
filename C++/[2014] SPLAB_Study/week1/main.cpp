#include<iostream>
#include<time.h>
#include<math.h>
#include<fstream>
using namespace std;

#define pSub ((double)20000/1024)*pow((double)10,1.5)*pow((double)10,-11.1)

int main(){
	double x,y,r,p;
	ofstream fp;

	fp.open("result.txt");

	srand(time(NULL));

	for(int i=0;i<1000;i++){
		do{
			x=(rand()%200)*0.01-1;
			y=(rand()%200)*0.01-1;
		}while(x*x+y*y>1);

		r=sqrt(x*x+y*y);
		p=pSub*pow(r,-3.7);
		
		fp<<x<<'\t'<<y<<"\t"<<r<<"\t"<<p<<endl;
	}

	fp.close();

	return 0;
}