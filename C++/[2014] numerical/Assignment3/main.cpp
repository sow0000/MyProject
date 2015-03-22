#include<iostream>
#include<fstream>
#include<math.h>
using namespace std;

#define IFILE "Lenna512_512.raw" //input file
#define LFILE "Lenna512_512_LoG.raw" //LoG output file
#define ZFILE "Lenna512_512_ZC.raw" //zero crossing output file
#define LZFILE "Lenna512_512_LZ.raw" //LoG with zero crossing output file
#define LINE 512 //image line
#define FLINE 3 //filter line
#define CRIT -100 //critical value
#define LCRIT -3000 //critical value for LoG

unsigned char input[LINE+2][LINE+2]={0,}; //input array
unsigned char go[LINE+2][LINE+2]={0,}; //gaussian output array
unsigned char lgo[LINE+2][LINE+2]={0,}; //laplacian output array
unsigned char zco[LINE][LINE]={0,}; //zero crossing output array
unsigned char lzo[LINE][LINE]={0,}; //LoG with zero crossing output array

void gaussian(int i, int j); //gaussian filter
int laplacian(int i, int j); //laplacian filter
int loz(int i, int j); //laplacian filter with zero crossing

int main(){
	int i, j, p1, p2, p3, p4, p5; //condition for loop
	ifstream fin; //input file
	ofstream fout; //output file

	fin.open(IFILE, ios_base::in | ios_base::binary);
	for(i=0;i<LINE;i++){ //read original file
		for(j=0;j<LINE;j++){
			fin.get((char&)input[i+1][j+1]);
			if(j==0) input[i+1][j]=input[i+1][j+1];
			if(j==LINE-1) input[i+1][j+2]=input[i+1][j+1];
		}
		if(i==0) memcpy(input[i], input[i+1], LINE+2);
		if(i==LINE-1) memcpy(input[i+2], input[i+1], LINE+2);
	}
	fin.close(); //close original file
	//memcpy(go, input, (LINE+2)*(LINE+2));

	for(i=1;i<=LINE;i++){ //gaussian
		for(j=1;j<=LINE;j++){
			gaussian(i, j);
		}
		if(i==1) memcpy(go[i-1], go[i], LINE+2);
		if(i==LINE) memcpy(go[i+1], go[i], LINE+2);
	}

	for(i=1;i<=LINE;i++){ //laplacian & zero crossing
		for(j=1;j<=LINE;j++){
			p1=laplacian(i, j); //middle point
			p2=(j==LINE) ? p1 : laplacian(i, j+1); //right point
			p3=((i==LINE)||(j==LINE)) ? p1 : laplacian(i+1, j+1); //diagonal point1
			p4=(i==LINE) ? p1 : laplacian(i+1, j); //bottom point
			p5=((i==LINE)||(j==1)) ? p1 : laplacian(i+1, j-1); //diagonal point2
			if((p1*p2<CRIT)||(p1*p3<CRIT)||(p1*p4<CRIT)||(p1*p5<CRIT)){
				if(p1<0) p1=0;
				if(p1>255) p1=255;
				lgo[i][j]=(unsigned char) p1;
				zco[i-1][j-1]=(unsigned char) p1;
			}
			else{
				if(p1<0) p1=p1*(-1);
				if(p1>255) p1=255;
				lgo[i][j]=(unsigned char) p1;
			}
			if(j==1) lgo[i][j-1]=lgo[i][j];
			if(j==LINE) lgo[i][j+1]=lgo[i][j];
		}
		if(i==1) memcpy(lgo[i-1], lgo[i], LINE+2);
		if(i==LINE) memcpy(lgo[i+1], lgo[i], LINE+2);
	}

	for(i=1;i<=LINE;i++){ //laplacian with zero crossing
		for(j=1;j<=LINE;j++){
			p1=loz(i, j); //middle point
			p2=(j==LINE) ? p1 : loz(i, j+1); //right point
			p3=((i==LINE)||(j==LINE)) ? p1 : loz(i+1, j+1); //diagonal point1
			p4=(i==LINE) ? p1 : loz(i+1, j); //bottom point
			p5=((i==LINE)||(j==1)) ? p1 : loz(i+1, j-1); //diagonal point2
			if((p1*p2<LCRIT)||(p1*p3<LCRIT)||(p1*p4<LCRIT)||(p1*p5<LCRIT)){
				if(p1<0) p1=0;
				if(p1>255) p1=255;
				lzo[i-1][j-1]=(unsigned char) p1;
			}
		}
	}

	fout.open(LFILE, ios_base::out | ios_base::trunc | ios_base::binary); //open output file
	for(i=1;i<=LINE;i++) fout.write((char*)lgo[i]+1, LINE); //LoG output
	fout.close(); //close output file

	fout.open(ZFILE, ios_base::out | ios_base::trunc | ios_base::binary); //open output file
	for(i=0;i<LINE;i++) fout.write((char*)zco[i], LINE); //zero crossing output
	fout.close(); //close output file

	fout.open(LZFILE, ios_base::out | ios_base::trunc | ios_base::binary); //open output file
	for(i=0;i<LINE;i++) fout.write((char*)lzo[i], LINE); //zero crossing output
	fout.close(); //close output file

	return 0;
}

void gaussian(int i, int j){
	int p00=(int)input[i-1][j-1];
	int p01=(int)input[i-1][j];
	int p02=(int)input[i-1][j+1];
	int p10=(int)input[i][j-1];
	int p12=(int)input[i][j+1];
	int p21=(int)input[i+1][j-1];
	int p22=(int)input[i+1][j];
	int p23=(int)input[i+1][j+1];
	int ptmp=(int)input[i][j];
	ptmp=(p00+(2*p01)+p02+(2*p10)+(2*p12)+p21+(2*p22)+p23)/16;
	go[i][j]=(unsigned char)ptmp;
	if(j==1) go[i][j-1]=go[i][j];
	if(j==LINE) go[i][j+1]=go[i][j];
}

int laplacian(int i, int j){
	int p00=(int)go[i-1][j-1];
	int p01=(int)go[i-1][j];
	int p02=(int)go[i-1][j+1];
	int p10=(int)go[i][j-1];
	int p12=(int)go[i][j+1];
	int p21=(int)go[i+1][j-1];
	int p22=(int)go[i+1][j];
	int p23=(int)go[i+1][j+1];
	int ptmp=(int)go[i][j];
	ptmp=((-8)*ptmp)+p00+p01+p02+p10+p12+p21+p22+p23;
	return ptmp;
}

int loz(int i, int j){
	int p00=(int)lgo[i-1][j-1];
	int p01=(int)lgo[i-1][j];
	int p02=(int)lgo[i-1][j+1];
	int p10=(int)lgo[i][j-1];
	int p12=(int)lgo[i][j+1];
	int p21=(int)lgo[i+1][j-1];
	int p22=(int)lgo[i+1][j];
	int p23=(int)lgo[i+1][j+1];
	int ptmp=(int)lgo[i][j];
	ptmp=((-8)*ptmp)+p00+p01+p02+p10+p12+p21+p22+p23;
	return ptmp;
}