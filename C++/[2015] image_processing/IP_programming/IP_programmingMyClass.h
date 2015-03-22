#pragma once

class CIP_programmingMyClass
{
public:
	BITMAPINFOHEADER	m_BMPheader; //BMP header
	FILE*				m_fp; //file pointer
	UCHAR*				m_pucBMP; //BMP buffer
	UCHAR*				m_pucImgbuf; //original image buffer
	UINT				m_uiHeight; //image height
	UINT				m_uiWidth; //image width
	UINT				m_uiPadding; //width + padding pixel
	UINT				m_uiImgSize; //image size

public:
	CIP_programmingMyClass(void); //constructor
	~CIP_programmingMyClass(void); //destructor

	void MyClass_GrayBMP(void); //gray to BMP
	void MyClass_ColorBMP(void); //color to BMP
};
