#include "StdAfx.h"
#include "IP_ProgrammingMyClass.h"

CIP_ProgrammingMyClass::CIP_ProgrammingMyClass()
	: m_fp(NULL)
	, m_pucBMP(NULL)
	, m_pucImgbuf(NULL)
	, m_uiHeight(0)
	, m_uiWidth(0)
	, m_uiImgSize(0)
	, m_bSequence(FALSE)
{
	//////////////////////////////////////////////////////////////////
	// set the BMP header information
	//////////////////////////////////////////////////////////////////
	m_BMPheader.biSize = sizeof(BITMAPINFOHEADER);
	m_BMPheader.biPlanes = 1;
	m_BMPheader.biBitCount = 24;
	m_BMPheader.biCompression = BI_RGB;
	m_BMPheader.biSizeImage = 0;
	m_BMPheader.biXPelsPerMeter = 0;
	m_BMPheader.biYPelsPerMeter = 0;
	m_BMPheader.biClrUsed = 0;
	m_BMPheader.biClrImportant = 0;
}

CIP_ProgrammingMyClass::~CIP_ProgrammingMyClass(void)
{
	//fclose(m_fp);
	free(m_pucBMP);
	free(m_pucImgbuf);
}

void CIP_ProgrammingMyClass::MyClass_GrayBMP(void)
{
	m_BMPheader.biWidth = m_uiWidth;
	m_BMPheader.biHeight = m_uiHeight;
	
	//////////////////////////////////////////////////////////////////
	// Gray to BMP conversion implementation
	//////////////////////////////////////////////////////////////////
	UINT i, j;

	fread(m_pucImgbuf, sizeof(UCHAR), m_uiImgSize, m_fp); //read data

	for(i=0;i<m_uiHeight;i++){
		for(j=0;j<m_uiWidth;j++){
			m_pucBMP[(i*m_uiWidth*3)+(j*3)]
			=m_pucBMP[(i*m_uiWidth*3)+(j*3)+1]
			=m_pucBMP[(i*m_uiWidth*3)+(j*3)+2]
			=m_pucImgbuf[((m_uiHeight-i-1)*m_uiWidth)+j];
		}
	}
}

void CIP_ProgrammingMyClass::MyClass_ColorBMP(void)
{
	m_BMPheader.biWidth = m_uiWidth;
	m_BMPheader.biHeight = m_uiHeight;
	
	//////////////////////////////////////////////////////////////////
	// Color to BMP conversion implementation
	//////////////////////////////////////////////////////////////////
	UINT i, j;

	fread(m_pucImgbuf, sizeof(UCHAR), m_uiImgSize, m_fp); //read data

	for(i=0;i<m_uiHeight;i++){
		for(j=0;j<m_uiWidth;j++){
			m_pucBMP[(i*m_uiWidth*3)+(j*3)]=m_pucImgbuf[((m_uiHeight-i-1)*m_uiWidth*3)+(j*3)+2];
			m_pucBMP[(i*m_uiWidth*3)+(j*3)+1]=m_pucImgbuf[((m_uiHeight-i-1)*m_uiWidth*3)+(j*3)+1];
			m_pucBMP[(i*m_uiWidth*3)+(j*3)+2]=m_pucImgbuf[((m_uiHeight-i-1)*m_uiWidth*3)+(j*3)];
		}
	}
}

void CIP_ProgrammingMyClass::MyClass_YUVBMP(void)
{
	m_BMPheader.biWidth = m_uiWidth;
	m_BMPheader.biHeight = m_uiHeight;
	
	//////////////////////////////////////////////////////////////////
	// YUV to RGB conversion implementation
	//////////////////////////////////////////////////////////////////
	UINT i, j;
	UCHAR *m_pucCb, *m_pucCr;
	DOUBLE m_ucY, m_ucCb, m_ucCr;

	if(feof(m_fp))
		return;

	fread(m_pucImgbuf, sizeof(UCHAR), m_uiImgSize, m_fp); //read Y
	m_pucCb=m_pucImgbuf+m_uiHeight*m_uiWidth; //Cb
	m_pucCr=m_pucCb+m_uiHeight*m_uiWidth/4; //Cr

	for(i=0;i<m_uiHeight;i+=2){
		for(j=0;j<m_uiWidth;j+=2){

			m_ucCb=(DOUBLE)m_pucCb[(i*m_uiWidth/4)+j/2]-128; //Cb
			m_ucCr=(DOUBLE)m_pucCr[(i*m_uiWidth/4)+j/2]-128; //Cr
			
			m_ucY=(DOUBLE)m_pucImgbuf[(i*m_uiWidth)+j]; //Y
			m_pucBMP[((m_uiHeight-i-1)*m_uiWidth*3)+(j*3)+2]=Clip(m_ucY+(1.402*m_ucCr)); //R
			m_pucBMP[((m_uiHeight-i-1)*m_uiWidth*3)+(j*3)+1]=Clip(m_ucY-(0.344*m_ucCb)-(0.714*m_ucCr)); //G
			m_pucBMP[((m_uiHeight-i-1)*m_uiWidth*3)+(j*3)]=Clip(m_ucY+(1.772*m_ucCb)); //B
			
			m_ucY=(DOUBLE)m_pucImgbuf[(i*m_uiWidth)+j+1]; //Y
			m_pucBMP[((m_uiHeight-i-1)*m_uiWidth*3)+((j+1)*3)+2]=Clip(m_ucY+(1.402*m_ucCr)); //R
			m_pucBMP[((m_uiHeight-i-1)*m_uiWidth*3)+((j+1)*3)+1]=Clip(m_ucY-(0.344*m_ucCb)-(0.714*m_ucCr)); //G
			m_pucBMP[((m_uiHeight-i-1)*m_uiWidth*3)+((j+1)*3)]=Clip(m_ucY+(1.772*m_ucCb)); //B
			
			m_ucY=(DOUBLE)m_pucImgbuf[((i+1)*m_uiWidth)+j]; //Y
			m_pucBMP[((m_uiHeight-i-2)*m_uiWidth*3)+(j*3)+2]=Clip(m_ucY+(1.402*m_ucCr)); //R
			m_pucBMP[((m_uiHeight-i-2)*m_uiWidth*3)+(j*3)+1]=Clip(m_ucY-(0.344*m_ucCb)-(0.714*m_ucCr)); //G
			m_pucBMP[((m_uiHeight-i-2)*m_uiWidth*3)+(j*3)]=Clip(m_ucY+(1.772*m_ucCb)); //B
			
			m_ucY=(DOUBLE)m_pucImgbuf[((i+1)*m_uiWidth)+j+1]; //Y
			m_pucBMP[((m_uiHeight-i-2)*m_uiWidth*3)+((j+1)*3)+2]=Clip(m_ucY+(1.402*m_ucCr)); //R
			m_pucBMP[((m_uiHeight-i-2)*m_uiWidth*3)+((j+1)*3)+1]=Clip(m_ucY-(0.344*m_ucCb)-(0.714*m_ucCr)); //G
			m_pucBMP[((m_uiHeight-i-2)*m_uiWidth*3)+((j+1)*3)]=Clip(m_ucY+(1.772*m_ucCb)); //B
		}
	}
}

void CIP_ProgrammingMyClass::MyClass_MakeNoise(UINT m_uiNoise)
{
	UINT i, j, k, wb;
	UINT noise=(m_uiHeight*m_uiWidth*m_uiNoise)/100;
	UCHAR *m_ucCheck=(UCHAR*)calloc(sizeof(UCHAR), m_uiHeight*m_uiWidth);

	srand(time(NULL));

	for(k=0;k<noise;k)
	{
		i=rand()%m_uiHeight;
		j=rand()%m_uiWidth;
		if(!m_ucCheck[i*j])
		{
			m_ucCheck[i*j]=1;
			wb=rand()%100;
			if(wb<50)
			{
				m_pucBMP[(i*m_uiWidth*3)+(j*3)]=0;
				m_pucBMP[(i*m_uiWidth*3)+(j*3)+1]=0;
				m_pucBMP[(i*m_uiWidth*3)+(j*3)+2]=0;
			}
			else
			{
				m_pucBMP[(i*m_uiWidth*3)+(j*3)]=255;
				m_pucBMP[(i*m_uiWidth*3)+(j*3)+1]=255;
				m_pucBMP[(i*m_uiWidth*3)+(j*3)+2]=255;
			}
			k++;
		}
	}

	free(m_ucCheck);
}

void CIP_ProgrammingMyClass::MyClass_MeanFilter(UINT m_uiWindow)
{
	UINT i, j, k;
	UINT window=(m_uiWindow+1)/2;
	UINT size=m_uiWidth*m_uiHeight;
	UCHAR *temp=(UCHAR*)malloc(m_uiWidth*m_uiHeight*3);
	UCHAR meanR, meanG, meanB;

	memcpy(temp, m_pucBMP, m_uiWidth*m_uiHeight*3);

	for(i=0;i<size;i++)
	{
		for(j=0;j<m_uiWindow;i++)
		{
			for(k=0;k<m_uiWindow;k++)
			{
				meanR+=temp[(i-k+window)];
				meanG+=temp[i];
				meanB+=temp[i];
			}
		}
		m_pucBMP[i*3]=meanR/(m_uiWindow*m_uiWindow);
		m_pucBMP[i*3+1]=meanG/(m_uiWindow*m_uiWindow);
		m_pucBMP[i*3+2]=meanB/(m_uiWindow*m_uiWindow);
	}
}

void CIP_ProgrammingMyClass::MyClass_Stop(void)
{
	fseek(m_fp, 0, SEEK_SET);
	MyClass_YUVBMP();
}

void CIP_ProgrammingMyClass::MyClass_Reverse(void)
{
	if(ftell(m_fp)==m_uiImgSize)
		return;

	fseek(m_fp, m_uiImgSize*(-2), SEEK_CUR);
	MyClass_YUVBMP();
}

bool CIP_ProgrammingMyClass::MyClass_IsSequence(void)
{
	return m_bSequence;
}

UCHAR CIP_ProgrammingMyClass::Clip(DOUBLE m_dData)
{
	return (UCHAR)((m_dData>255) ? 255 : ((m_dData<0) ? 0 : m_dData));
}