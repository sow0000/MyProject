///////////////////////////////////////////////////////////////////////////////
// File Name      : file.h
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : ������
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : ������ ����, �а�, ����, �ݴ� ����� ���� ���� Ŭ���� (����)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include <fstream.h>
#include <string.h>

#ifndef __CFILE_H__
#define __CFILE_H__

class CFile
{
public:
	CFile();   // ���� ������
	~CFile();  // ���� �Ҹ���
	void Open(const char * szFileName, const int nMode);  // szFileName������ nMode���·� ����
	void Close();  // ���� �ݱ�
	char * ReadLine();  // ���Ͽ��� ���� �б�
	void WriteLine(const char * str);  // ���Ͽ� ���� ����
	void WriteLine(const int n);  // ���Ͽ� ���� ����
	
private:
	ofstream fout;  // ǥ�� ���� ��� ��ü
	ifstream fin;   // ǥ�� ���� �Է� ��ü
	char m_szBuffer[80];  // ���Ͽ��� ���� ���� ����
};

#endif	//__CFILE_H__
