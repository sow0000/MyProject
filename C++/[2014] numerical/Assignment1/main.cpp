#include<iostream>
using namespace std;

short func(short x, short sv);
void divide(short x, short sv, short* res, short* rem);

int main(){
	short x1=1, x2=2, x3=0, sv=1;

	while(sv<16){
		sv*=2;
		x3=x1+x2;
		x1*=2;
		x2*=2;
		(((func(x3, sv)>=0)&&(func(x1, sv)>=0))||((func(x3, sv)<0)&&(func(x1, sv)<0))) ? (x1=x3) : (x2=x3);
		cout<<"loop : "<<"["<<x1<<"/"<<sv<<","<<x2<<"/"<<sv<<"]"<<endl;
	}

	return 0;
}

short func(short x, short sv){
	short int1, int2, rem1, rem2, flo;
	divide(x*x*x,sv*sv*sv,&int1,&rem1);
	divide(4*x*x,sv*sv,&int2,&rem2);
	flo=rem1+(rem2*sv);
	if(flo>sv*sv*sv){
		return int1+int2-9;
	}
	else{
		return int1+int2-10;
	}
}

void divide(short x, short sv, short* res, short* rem){
	(*res)=0;
	while(x>=sv){
		x=x-sv;
		(*res)++;
	}
	(*rem)=x;
}