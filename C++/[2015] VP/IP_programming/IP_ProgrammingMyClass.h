#pragma once

class CIP_ProgrammingMyClass
{
public:
	BITMAPINFOHEADER	m_BMPheader;
	FILE*				m_fp;
	UCHAR*				m_pucBMP;
	UCHAR*				m_pucImgbuf;
	UINT				m_uiHeight;
	UINT				m_uiWidth;
	UINT				m_uiImgSize;
	BOOL				m_bSequence;

public:
	CIP_ProgrammingMyClass(void);
	~CIP_ProgrammingMyClass(void);

	void MyClass_GrayBMP(void);
	void MyClass_ColorBMP(void);
	void MyClass_YUVBMP(void);

	void MyClass_MakeNoise(UINT m_uiNoise);
	void MyClass_MeanFilter(UINT m_uiWindow);

	void MyClass_Stop(void);
	void MyClass_Reverse(void);

	bool MyClass_IsSequence();

	UCHAR Clip(DOUBLE m_dData);
};
