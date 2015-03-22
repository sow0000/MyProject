#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define WIDTH		352
#define HEIGHT		288

#define IPATH		"foreman.cif"
#define OPATH		"output.raw"

int main(){
	int i, j;
	int ISIZE=(WIDTH*HEIGHT*3)/2;
	int OSIZE=WIDTH*HEIGHT*3;
	unsigned char *input=(unsigned char*)malloc(ISIZE);
	unsigned char *output=(unsigned char*)malloc(OSIZE);
	unsigned char *m_pucCb, *m_pucCr;
	double m_ucY, m_ucCb, m_ucCr, m_ucR, m_ucG, m_ucB;
	FILE *fp;

	fp=fopen(IPATH, "rb");
	fread((unsigned char*)input, sizeof(unsigned char), ISIZE, fp);
	fclose(fp);
	
	m_pucCb=input+WIDTH*HEIGHT; //Cb array
	m_pucCr=m_pucCb+WIDTH*HEIGHT/4; //Cr array

	for(i=0;i<HEIGHT;i++){
		for(j=0;j<WIDTH;j++){
			m_ucY=(double)input[(i*WIDTH)+j];
			m_ucCb=(double)m_pucCb[((i*WIDTH/4))+j/2]-128; //Cb
			m_ucCr=(double)m_pucCr[((i*WIDTH/4))+j/2]-128; //Cr

			m_ucR=(unsigned char)(m_ucY+(1.402*m_ucCr)); //R
			m_ucG=(unsigned char)(m_ucY-(0.344*m_ucCb)-(0.714*m_ucCr)); //G
			m_ucB=(unsigned char)(m_ucY+(1.772*m_ucCb)); //B

			output[(i*WIDTH*3)+j*3]=(m_ucR>255) ? 255 : ((m_ucR<0) ? 0 : m_ucR); //R
			output[(i*WIDTH*3)+j*3+1]=(m_ucG>255) ? 255 : ((m_ucG<0) ? 0 : m_ucG); //G
			output[(i*WIDTH*3)+j*3+2]=(m_ucB>255) ? 255 : ((m_ucB<0) ? 0 : m_ucB); //B
		}
	}

	fp=fopen(OPATH, "wb");
	fwrite(output, sizeof(unsigned char), OSIZE, fp);
	fclose(fp);

	return 0;
}