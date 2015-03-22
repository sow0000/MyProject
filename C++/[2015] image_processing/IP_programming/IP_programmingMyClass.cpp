#include "StdAfx.h"
#include "IP_programmingMyClass.h"

CIP_programmingMyClass::CIP_programmingMyClass()
	: m_fp(NULL)
	, m_pucBMP(NULL)
	, m_pucImgbuf(NULL)
	, m_uiHeight(0)
	, m_uiWidth(0)
	, m_uiImgSize(0)
	, m_uiPadding(0)
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

CIP_programmingMyClass::~CIP_programmingMyClass(void)
{
	free(m_pucBMP); //clear memory
	free(m_pucImgbuf);
}

void CIP_programmingMyClass::MyClass_GrayBMP(void)
{
	m_BMPheader.biWidth = m_uiWidth; //BMP header
	m_BMPheader.biHeight = m_uiHeight;
	
	//////////////////////////////////////////////////////////////////
	// Gray to BMP conversion implementation
	//////////////////////////////////////////////////////////////////
	UINT i, j; //condition for loop

	fread(m_pucImgbuf, sizeof(UCHAR), m_uiImgSize, m_fp); //read data

	for(i=0;i<m_uiHeight;i++){
		for(j=0;j<m_uiWidth;j++){
			m_pucBMP[(i*m_uiPadding)+(j*3)]
			=m_pucBMP[(i*m_uiPadding)+(j*3)+1]
			=m_pucBMP[(i*m_uiPadding)+(j*3)+2]
			=m_pucImgbuf[((m_uiHeight-i-1)*m_uiWidth)+j]; //R=G=B<=gray
		}
	}
}

void CIP_programmingMyClass::MyClass_ColorBMP(void)
{
	m_BMPheader.biWidth = m_uiWidth; //BMP header
	m_BMPheader.biHeight = m_uiHeight;
	
	//////////////////////////////////////////////////////////////////
	// Color to BMP conversion implementation
	//////////////////////////////////////////////////////////////////
	UINT i, j; //condition for loop

	fread(m_pucImgbuf, sizeof(UCHAR), m_uiImgSize, m_fp); //read data

	for(i=0;i<m_uiHeight;i++){
		for(j=0;j<m_uiWidth;j++){ //R-G-B => B-G-R, swap up and down
			m_pucBMP[(i*m_uiPadding)+(j*3)]=m_pucImgbuf[((m_uiHeight-i-1)*m_uiWidth*3)+(j*3)+2];
			m_pucBMP[(i*m_uiPadding)+(j*3)+1]=m_pucImgbuf[((m_uiHeight-i-1)*m_uiWidth*3)+(j*3)+1];
			m_pucBMP[(i*m_uiPadding)+(j*3)+2]=m_pucImgbuf[((m_uiHeight-i-1)*m_uiWidth*3)+(j*3)];
		}
	}
}