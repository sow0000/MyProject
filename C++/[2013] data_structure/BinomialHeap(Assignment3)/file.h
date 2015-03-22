///////////////////////////////////////////////////////////////////////////////
// File Name      : file.h
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : 김태형
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : 파일을 열고, 읽고, 쓰고, 닫는 기능을 가진 파일 클래스 (정의)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include <fstream.h>
#include <string.h>

#ifndef __CFILE_H__
#define __CFILE_H__

class CFile
{
public:
	CFile();   // 파일 생성자
	~CFile();  // 파일 소멸자
	void Open(const char * szFileName, const int nMode);  // szFileName파일을 nMode형태로 열기
	void Close();  // 파일 닫기
	char * ReadLine();  // 파일에서 한줄 읽기
	void WriteLine(const char * str);  // 파일에 한줄 쓰기
	void WriteLine(const int n);  // 파일에 한줄 쓰기
	
private:
	ofstream fout;  // 표준 파일 출력 객체
	ifstream fin;   // 표준 파일 입력 객체
	char m_szBuffer[80];  // 파일에서 읽은 한줄 저장
};

#endif	//__CFILE_H__
