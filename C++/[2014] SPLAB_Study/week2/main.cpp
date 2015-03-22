#include<iostream>
#include<time.h>
#include<math.h>
#include<fstream>
using namespace std;

#define R sqrt(x*x+y*y)
#define P ((double)20000/1024)*pow((double)10,1.5)*pow((double)10,-11.1)*pow(R,-3.7)
#define S (double)10*log10(P/(pow((double)10,-17.4)*(pow((double)10,7)/1024)))

int main(){
	double x,y,r=sqrt((double)3);
	ofstream fp;

	fp.open("result.txt");

	srand(time(NULL));

	for(int i=0;i<1000;i++){
		while(1){
			x=(rand()%200)*0.01-1;
			y=(rand()%200)*0.01-1;
			if((y<=r/2)&&(y>=-r/2)&&(y<=(1+x)*r)&&(y<=(1-x)*r)&&(y>=(-1+x)*r)&&(y>=(-1-x)*r)) break;
		}

		fp<<x<<'\t'<<y<<"\t"<<R<<"\t"<<P<<"\t"<<S<<endl;
	}

	fp.close();

	return 0;
}