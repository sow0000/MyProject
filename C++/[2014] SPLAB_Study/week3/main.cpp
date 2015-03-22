#include<iostream>
#include<time.h>
#include<math.h>
#include<fstream>
using namespace std;

#define S p/(in+(pow((double)10,-17.4)*(10000000/1024)))
#define SDB (double)10*log10(S)
#define C ((double)(10*768*26)*(log((double)1+S)/log((double)2)))/(double)(1024*42)

double range(double x, double y, double xb, double yb);
double power(double r);
double Throughput(double c);

int main(){
	double x,y,r,p,in=0,rt=sqrt((double)3);
	ofstream fp;

	fp.open("result.txt");

	srand(time(NULL));
	fp<<"x"<<'\t'<<"y"<<"\t"<<"r"<<"\t"<<"P( r )"<<"\t"<<"I"<<"\t"<<"SINR"<<"\t"<<"SINRdB"<<'\t'<<"SC"<<'\t'<<"Throughput"<<endl;

	for(int i=0;i<1000;i++){
		while(1){
			x=(rand()%200)*0.01-1;
			y=(rand()%200)*0.01-1;
			if((y<=rt/2)&&(y>=-rt/2)&&(y<=(1+x)*rt)&&(y<=(1-x)*rt)&&(y>=(-1+x)*rt)&&(y>=(-1-x)*rt)) break;
		}
		r=range(x,y,0,0);
		p=power(r);
		in=0;
		in+=power(range(x,y,(double)-1.5,rt/2));
		in+=power(range(x,y,(double)-1.5,(-1)*rt/2));
		in+=power(range(x,y,0,rt));
		in+=power(range(x,y,0,(-1)*rt));
		in+=power(range(x,y,(double)1.5,rt/2));
		in+=power(range(x,y,(double)1.5,(-1)*rt/2));
		fp<<x<<'\t'<<y<<"\t"<<r<<"\t"<<p<<"\t"<<in<<"\t"<<S<<"\t"<<SDB<<"\t"<<C<<"\t"<<Throughput(C)<<endl;
	}

	fp.close();

	return 0;
}

double range(double x, double y, double xb, double yb){
	double r=sqrt((x-xb)*(x-xb)+(y-yb)*(y-yb));
	return r;
}

double power(double r){
	double p=((double)20000/1024)*pow((double)10,1.5)*pow((double)10,-11.1)*pow(r,-3.7);
	return p;
}

double Throughput(double c){
	if(c<1.3312) return 0.6656;
	else if(c<2.6624) return 1.3312;
	else if(c<3.9936) return 2.6624;
	else if(c<5.3248) return 3.9936;
	else if(c<7.9872) return 5.3248;
	else if(c<10.6496) return 7.9872;
	else if(c<11.9808) return 10.6496;
	else if(c<15.9640) return 11.9808;
	else if(c<19.9680) return 15.9640;
	else return 19.9680;
}