///////////////////////////////////////////////////////////////////////////////
// File Name      : memoryallocator.h
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : ������
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : �޸𸮸� B-Tree�� �̿��Ͽ� �Ҵ� �� �����ϰ�
//                  �޸� �Ҵ� ���¸� ��� (����)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include "file.h"
#include "bintree.h"
#include "linkedlist.h"

#ifndef __CMEMORYALLOCATOR_H__
#define __CMEMORYALLOCATOR_H__

class CMemoryAllocator
{
public:
	CMemoryAllocator();  // �⺻ ������
	~CMemoryAllocator();  // �⺻ �Ҹ���
	void Run();  // ��ü���� ���α׷��� ���� �� ����
	// �޸� �Ҵ�
	void AllocateMemory(int nIndex, int nSize);
	// �޸� ����
	void FreeMemory(int nIndex);
	// �޸� ����
	void CoalescingMemory();
	// �޸� �Ҵ���� ���
	void WriteMemoryState();

private:
	CFile * Fin;  // File ��ü
	CFile * Fout;  // File ��ü
	CBinTree * BinTree;  // Binomial Tree ��ü
	CLinkedList * AllocatedList;  // �Ҵ�� Memory List
	CLinkedList * AvailableList;  // ���Ҵ�� Memory List
	int m_nTotalMBSize;  // ��ü Memory Block�� ũ��
	int m_nCoalescingCount;  // Memory Coalescing Ƚ��
	int m_nFailureCount;  // Memory Allocation Failure Ƚ��
	int m_nCheck;  // ���� ������� üũ
};

#endif	//__CMEMORYALLOCATOR_H__
