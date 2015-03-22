///////////////////////////////////////////////////////////////////////////////
// File Name      : memoryallocator.h
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : 김태형
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : 메모리를 B-Tree를 이용하여 할당 및 해제하고
//                  메모리 할당 상태를 출력 (정의)
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
	CMemoryAllocator();  // 기본 생성자
	~CMemoryAllocator();  // 기본 소멸자
	void Run();  // 전체적인 프로그램을 관리 및 실행
	// 메모리 할당
	void AllocateMemory(int nIndex, int nSize);
	// 메모리 해제
	void FreeMemory(int nIndex);
	// 메모리 병합
	void CoalescingMemory();
	// 메모리 할당상태 출력
	void WriteMemoryState();

private:
	CFile * Fin;  // File 객체
	CFile * Fout;  // File 객체
	CBinTree * BinTree;  // Binomial Tree 객체
	CLinkedList * AllocatedList;  // 할당된 Memory List
	CLinkedList * AvailableList;  // 비할당된 Memory List
	int m_nTotalMBSize;  // 전체 Memory Block의 크기
	int m_nCoalescingCount;  // Memory Coalescing 횟수
	int m_nFailureCount;  // Memory Allocation Failure 횟수
	int m_nCheck;  // 파일 쓰기상태 체크
};

#endif	//__CMEMORYALLOCATOR_H__
