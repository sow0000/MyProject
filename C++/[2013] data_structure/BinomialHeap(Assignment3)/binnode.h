///////////////////////////////////////////////////////////////////////////////
// File Name      : binnode.h
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : ������
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : Binomial Tree�� ��� (����)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include <string.h>
#include <stdlib.h>
#include <iostream.h>

#ifndef __CBINNODE_H__
#define __CBINNODE_H__

class CBinNode
{
public:
	CBinNode();  // �⺻ ������
	// index�� ���� ��ġ, ũ�⸦ �Ű������� �޴� Binomial Tree�� ��� ����
	CBinNode(const int nIndex, const int nPosition, const int nSize);
	~CBinNode();  // �⺻ �Ҹ���
	void Initialize();  // ��� ������� �ʱ�ȭ
	int GetIndex();  // Memory Block�� index ��ȯ
	int GetStartAdress();  // Memory Block�� ���� �ּ� ��ȯ
	int GetSize();  // Memory Block�� ũ�� ��ȯ
	friend class CBinTree;  // CBinTree Ŭ������ ������� ����
	friend class CLinkedList;  // CLinkedList Ŭ������ ������� ����

private:
	int m_nIndex;  // Memory Block�� index
	int m_nStartAdress;  // Memory Block�� ���� �ּ�
	int m_nSize;  // Memory Block�� ũ��
	int m_nChildDegree;  // ����� �ڽ� ��

	CBinNode * pBrother;  // ����� ������ ����
	CBinNode * pChild;  // ����� �ڽ��� ����
	CBinNode * pNext;  // Linked List ������ ���� ��带 ����
};

#endif	//__CBINNODE_H__
