#include<iostream>
#include<fstream>
#include<math.h>
using namespace std;

#define IFILE "Lenna128_128.raw" //source file
#define OFILE "Lenna512_512.raw" //original file
#define BFILE "Lenna512_512_bi.raw" //bilinear file
#define LFILE "Lenna512_512_la.raw" //lagrange file
#define SFILE "Lenna512_512_si.raw" //six-tab file
#define ILINE 128
#define OLINE 512

unsigned char input[ILINE][ILINE]={0,}; //input array
unsigned char ori[OLINE][OLINE]={0,}; //original array
unsigned char bio[OLINE][OLINE]={0,}; //bilinear array
unsigned char lao[OLINE][OLINE]={0,}; //lagrange array
unsigned char sio[OLINE][OLINE]={0,}; //six-tab array

void bilinear(int i, int j); //bilinear function
void lagrange_X(int i, int j); //lagrange for x
void lagrange_Y(int i, int j); //lagrange for y
void sixtab_H(int i, int j); //six-tab half pel
void sixtab_Q(int i, int j); //six-tab quarter pel
void PSNR(); //Peak Signal to Noise Ratio
void RMS(); //Root Mean Square Error

int main(){
	int i, j; //condition for loop
	ifstream fin; //input file
	ofstream fout; //output file

	fin.open(OFILE, ios_base::in | ios_base::binary); //open original file
	for(i=0;i<OLINE;i++){ //read
		fin.read((char*)ori[i], OLINE);
	}
	fin.close(); //close original file

	fin.open(IFILE, ios_base::in | ios_base::binary); //open source file
	for(i=0;i<ILINE;i++){ //read and expand
		fin.read((char*)input[i], ILINE);
		for(j=0;j<ILINE;j++){
			bio[i*4][j*4]=input[i][j];
			lao[i*4][j*4]=input[i][j];
			sio[i*4][j*4]=input[i][j];
		}
	}
	fin.close(); //close source file

	for(i=0;i<OLINE;i+=4){ //interpolation
		for(j=0;j<OLINE;j+=4){
			bilinear(i,j); //bilinear function
			lagrange_Y(i,j); //lagrange for y
			sixtab_H(i,j); //six-tab half pel
		}
	}

	for(i=0;i<OLINE;i+=4){
		for(j=0;j<OLINE;j+=4){
			lagrange_X(i,j); //lagrange for x
			sixtab_Q(i,j); //six-tab quarter pel
		}
	}

	fout.open(BFILE, ios_base::out | ios_base::trunc | ios_base::binary); //open output file
	for(i=0;i<OLINE;i++) fout.write((char*)bio[i], OLINE); //bilinear output
	fout.close(); //close output file

	fout.open(LFILE, ios_base::out | ios_base::trunc | ios_base::binary); //open output file
	for(i=0;i<OLINE;i++) fout.write((char*)lao[i], OLINE); //lagrange output
	fout.close(); //close output file

	fout.open(SFILE, ios_base::out | ios_base::trunc | ios_base::binary); //open output file
	for(i=0;i<OLINE;i++) fout.write((char*)sio[i], OLINE); //six-tab output
	fout.close(); //close output file

	PSNR();

	return 0;
}

void bilinear(int i, int j){
	unsigned char B=(j>504) ? bio[i][j] : bio[i][j+4]; //handling edges
	unsigned char C=(i>504) ? bio[i][j] : bio[i+4][j];
	unsigned char D=((i>504)&&(j>504)) ? bio[i][j] : ((i>504) ? bio[i][j+4] : ((j>504) ? bio[i+4][j] : bio[i+4][j+4]));
	unsigned char BD=(B+D+1)/2;
	unsigned char CD=(C+D+1)/2;
	unsigned char CDD=(CD+D+1)/2;

	bio[i][j+2]=(bio[i][j]+B+1)/2; //b
	bio[i+2][j]=(bio[i][j]+C+1)/2; //h
	bio[i+2][j+2]=(bio[i][j+2]+CD+1)/2; //j

	bio[i][j+1]=(bio[i][j]+bio[i][j+2]+1)/2; //a
	bio[i][j+3]=(bio[i][j+2]+B+1)/2; //c
	bio[i+2][j+1]=(bio[i+2][j]+bio[i+2][j+2]+1)/2; //i
	bio[i+2][j+3]=(bio[i+2][j+2]+BD+1)/2; //k

	bio[i+1][j]=(bio[i][j]+bio[i+2][j]+1)/2; //d
	bio[i+3][j]=(bio[i+2][j]+C+1)/2; //n
	bio[i+1][j+2]=(bio[i][j+2]+bio[i+2][j+2]+1)/2; //f
	bio[i+3][j+2]=(bio[i+2][j+2]+CD+1)/2; //q

	bio[i+1][j+1]=(bio[i][j+1]+bio[i+2][j+1]+1)/2; //e
	bio[i+1][j+3]=(bio[i][j+3]+bio[i+2][j+3]+1)/2; //g
	bio[i+3][j+1]=(bio[i+3][j]+bio[i+3][j+2]+1)/2; //q
	bio[i+3][j+3]=(bio[i+2][j+3]+CDD+1)/2; //r
}

void lagrange_X(int i, int j){
	unsigned char B, C, D;
	for(int y=0;y<4;y++){
		for(int x=0;x<4;x++){ //lagrange interpolation for all x
			B=(j>504) ? lao[i+y][j] : lao[i+y][j+4]; //handling edges
			C=(j>500) ? B : lao[i+y][j+8];
			D=(j>496) ? C : lao[i+y][j+12];
			lao[i+y][j+x]=(((x-4)*(x-8)*(x-12)*lao[i+y][j])/(-384))+((x*(x-8)*(x-12)*B)/(128))
				+((x*(x-4)*(x-12)*C)/(-128))+((x*(x-4)*(x-8)*D)/(384));
		}
	}
}

void lagrange_Y(int i, int j){
	unsigned char B, C, D;
	for(int x=0;x<4;x++){ //lagrange interpolation for original pixels
		if(x%4==0) continue; //skip original pixels
		B=(i>504) ? lao[i][j] : lao[i+4][j]; //handling edges
		C=(i>500) ? B : lao[i+8][j];
		D=(i>496) ? C : lao[i+12][j];
		lao[i+x][j]=(((x-4)*(x-8)*(x-12)*lao[i][j])/(-384))+((x*(x-8)*(x-12)*B)/(128))
			+((x*(x-4)*(x-12)*C)/(-128))+((x*(x-4)*(x-8)*D)/(384));
	}
}

void sixtab_H(int i, int j){
	unsigned char F=(j<4) ? sio[i][j] : sio[i][j-4]; //handling edges
	unsigned char E=(j<8) ? F : sio[i][j-8];
	unsigned char H=(j>504) ? sio[i][j] : sio[i][j+4];
	unsigned char I=(j>500) ? H : sio[i][j+8];
	unsigned char J=(j>496) ? I : sio[i][j+12];
	unsigned char C=(i<4) ? sio[i][j] : sio[i-4][j];
	unsigned char A=(i<8) ? C : sio[i-8][j];
	unsigned char M=(i>504) ? sio[i][j] : sio[i+4][j];
	unsigned char R=(i>500) ? M : sio[i+8][j];
	unsigned char T=(i>496) ? R : sio[i+12][j];

	sio[i][j+2]=(E-(5*F)+(20*sio[i][j])+(20*H)-(5*I)+J+16)/32; //b
	sio[i+2][j]=(A-(5*C)+(20*sio[i][j])+(20*M)-(5*R)+T+16)/32; //h
}

void sixtab_Q(int i, int j){
	unsigned char dd=(j<4) ? sio[i+2][j] : sio[i+2][j-4]; //handling edges
	unsigned char cc=(j<8) ? dd : sio[i+2][j-8];
	unsigned char m=(j>504) ? sio[i+2][j] : sio[i+2][j+4];
	unsigned char ee=(j>500) ? m : sio[i+2][j+8];
	unsigned char ff=(j>496) ? ee : sio[i+2][j+12];
	unsigned char s=(i>504) ? sio[i][j+2] : sio[i+4][j+2];
	unsigned char H=(j>504) ? sio[i][j] : sio[i][j+4];
	unsigned char M=(i>504) ? sio[i][j] : sio[i+4][j];

	sio[i+2][j+2]=(cc-(5*dd)+(20*sio[i+2][j])+(20*m)-(5*ee)+ff+16)/32; //j

	sio[i][j+1]=(sio[i][j]+sio[i][j+2]+1)/2; //a
	sio[i][j+3]=(sio[i][j+2]+H+1)/2; //c
	sio[i+2][j+1]=(sio[i+2][j]+sio[i+2][j+2]+1)/2; //i
	sio[i+2][j+3]=(sio[i+2][j+2]+m+1)/2; //k

	sio[i+1][j]=(sio[i][j]+sio[i+2][j]+1)/2; //d
	sio[i+3][j]=(sio[i+2][j]+M+1)/2; //n
	sio[i+1][j+2]=(sio[i][j+2]+sio[i+2][j+2]+1)/2; //f
	sio[i+3][j+2]=(sio[i+2][j+2]+s+1)/2; //q

	sio[i+1][j+1]=(sio[i+2][j]+sio[i][j+2]+1)/2; //e
	sio[i+3][j+1]=(sio[i+2][j]+s+1)/2; //p
	sio[i+1][j+3]=(sio[i][j+2]+m+1)/2; //g
	sio[i+3][j+3]=(m+s+1)/2; //r
}

void PSNR(){
	int tbi, tla, tsi, mse_bi=0, mse_la=0, mse_si=0;
	double rms_bi, rms_la, rms_si, psnr_bi, psnr_la, psnr_si;

	for(int i=0;i<OLINE;i++){
		for(int j=0;j<OLINE;j++){
			tbi=(int)(ori[i][j]-bio[i][j]); //gap
			tla=(int)(ori[i][j]-lao[i][j]);
			tsi=(int)(ori[i][j]-sio[i][j]);
			mse_bi+=(tbi*tbi);
			mse_la+=(tla*tla);
			mse_si+=(tsi*tsi);
		}
	}
	rms_bi=sqrt((double)(mse_bi/(OLINE*OLINE))); //RMS
	rms_la=sqrt((double)(mse_la/(OLINE*OLINE)));
	rms_si=sqrt((double)(mse_si/(OLINE*OLINE)));
	
	psnr_bi=20*log10((double)(255/rms_bi)); //PSNR
	psnr_la=20*log10((double)(255/rms_la));
	psnr_si=20*log10((double)(255/rms_si));

	cout<<"PSNR :\t"<<psnr_bi<<"\t"<<psnr_la<<"\t"<<psnr_si<<endl;
	cout<<"RMS :\t"<<rms_bi<<"\t"<<rms_la<<"\t"<<rms_si<<endl;
}