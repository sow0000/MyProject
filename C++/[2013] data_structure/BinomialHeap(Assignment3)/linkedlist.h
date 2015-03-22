///////////////////////////////////////////////////////////////////////////////
// File Name      : linkedlist.h
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : 김태형
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : 할당 또는 비할당된 노드들을 linked list 구조로
//                  Memory Block의 주소순으로 연결 (정의)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include "binnode.h"

#ifndef __CLINKEDLIST_H__
#define __CLINKEDLIST_H__

class CLinkedList
{
public:
	CLinkedList();  // 기본 생성자
	~CLinkedList();  // 기본 소멸자
	void Insert(CBinNode * BinNode);  // 노드를 linked list에 삽입
	// 해당 모드에 따른 nValue값의 노드를 linked list에서 제거
	CBinNode * Delete(const int nValue, const int nMode);
	void Coalescing();  // 주소가 이어진 노드들을 합치기
	CBinNode * GetNode(const int nOrder);  // 해당 위치 노드 반환
	int GetTotalNodeCount();  // 리스트에 연결된 노드 수를 반환
	int GetTotalSize();  // 리스트에 연결된 비할당 메모리의 총 크기 반환

private:
	CBinNode * m_pHead;  // linked list의 머리 노드
	int m_nTotalNodeCount;  // 리스트에 연결된 노드 수
	int m_nTotalSize;  // 리스트에 연결된 메모리의 총 크기
};

#endif	//__CLINKEDLIST_H__
