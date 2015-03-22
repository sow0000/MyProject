///////////////////////////////////////////////////////////////////////////////
// File Name      : linkedlist.h
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : ������
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : �Ҵ� �Ǵ� ���Ҵ�� ������ linked list ������
//                  Memory Block�� �ּҼ����� ���� (����)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include "binnode.h"

#ifndef __CLINKEDLIST_H__
#define __CLINKEDLIST_H__

class CLinkedList
{
public:
	CLinkedList();  // �⺻ ������
	~CLinkedList();  // �⺻ �Ҹ���
	void Insert(CBinNode * BinNode);  // ��带 linked list�� ����
	// �ش� ��忡 ���� nValue���� ��带 linked list���� ����
	CBinNode * Delete(const int nValue, const int nMode);
	void Coalescing();  // �ּҰ� �̾��� ������ ��ġ��
	CBinNode * GetNode(const int nOrder);  // �ش� ��ġ ��� ��ȯ
	int GetTotalNodeCount();  // ����Ʈ�� ����� ��� ���� ��ȯ
	int GetTotalSize();  // ����Ʈ�� ����� ���Ҵ� �޸��� �� ũ�� ��ȯ

private:
	CBinNode * m_pHead;  // linked list�� �Ӹ� ���
	int m_nTotalNodeCount;  // ����Ʈ�� ����� ��� ��
	int m_nTotalSize;  // ����Ʈ�� ����� �޸��� �� ũ��
};

#endif	//__CLINKEDLIST_H__
