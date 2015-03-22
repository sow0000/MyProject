///////////////////////////////////////////////////////////////////////////////
// File Name      : linkedlist.cpp
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : 김태형
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : 할당 또는 비할당된 노드들을 linked list 구조로
//                  Memory Block의 주소순으로 연결 (구현)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include "linkedlist.h"




///////////////////////////////////////////////////////////////////////////////
// Function : CLinkedList::CLinkedList()
//=============================================================================
// Input    : 없음
// Output   : 없음
// Purpose  : 기본 생성자(멤버변수를 초기화)
///////////////////////////////////////////////////////////////////////////////
CLinkedList::CLinkedList()
{
	m_pHead = 0;
	m_nTotalNodeCount = 0;
	m_nTotalSize = 0;
}




///////////////////////////////////////////////////////////////////////////////
// Function : CLinkedList::~CLinkedList()
//=============================================================================
// Input    : 없음
// Output   : 없음
// Purpose  : 기본 소멸자(리스트내 할당된 노드들의 메모리 해제)
///////////////////////////////////////////////////////////////////////////////
CLinkedList::~CLinkedList()
{
	CBinNode * pDelete;  // 삭제할 노드
	CBinNode * pWalker;  // 리스트를 순회할 임시 포인터

	pWalker = m_pHead;  // pWalker에 머리노드 저장

	// 리스트 순회하면서 노드들을 전부 메모리 해제
	while(pWalker)
	{
		pDelete = pWalker;
		pWalker = pWalker->pNext;
		delete pDelete;
	}
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CLinkedList::Insert(CBinNode * BinNode)
//=============================================================================
// Input    : 삽입할 노드
// Output   : 없음
// Purpose  : 리스트내 노드를 삽입
///////////////////////////////////////////////////////////////////////////////
void CLinkedList::Insert(CBinNode * BinNode)
{
	CBinNode * pWalker;  // 리스트를 순회할 임시 포인터

	// 머리노드가 없으면 새로들어온 노드가 머리노드가 됨
	if(m_pHead == 0)
	{
		m_pHead = BinNode;
		m_nTotalNodeCount++;
		m_nTotalSize += BinNode->GetSize();
		return;
	}

	pWalker = m_pHead;  // 머리노드를 pWalker에 저장

	// 리스트의 끝까지 순회
	while(pWalker)
	{
		// 추가할 노드의 시작주소가 pWalker 보다 작으면
		if(pWalker->m_nStartAdress > BinNode->m_nStartAdress)
		{
			// 추가할 노드의 시작주소가 pWalker보다 작은 경우는
			// 머리 노드와 비교할 때 밖에 없으므로
			// 추가할 노드를 머리 노드로 한다
			BinNode->pNext = m_pHead;
			m_pHead = BinNode;
			m_nTotalNodeCount++;
			m_nTotalSize += BinNode->GetSize();
			break;
		}
		else  // 추가할 노드의 시작주소가 pWalker 보다 크고
		{
			// pWalker의 다음 노드가 없으면 그 곳에 삽입
			if(pWalker->pNext == 0)
			{
				pWalker->pNext = BinNode;
				m_nTotalNodeCount++;
				m_nTotalSize += BinNode->GetSize();
				break;
			}

			// pWalker의 다음 노드보다 작으면 pWalker의 next에 삽입
			if(pWalker->pNext->m_nStartAdress > BinNode->m_nStartAdress)
			{
				BinNode->pNext = pWalker->pNext;
				pWalker->pNext = BinNode;
				m_nTotalNodeCount++;
				m_nTotalSize += BinNode->GetSize();
				break;
			}
			else // pWalker의 다음 노드보다도 크면 pWalker를 다음 노드로 이동
				pWalker = pWalker->pNext;
		}
	}
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinNode * CLinkedList::Delete(const int nValue, const int nMode)
//=============================================================================
// Input    : 리스트내 노드를 삭제할 값과 조건(mode)
// Output   : 삭제할 노드
// Purpose  : 조건에 따라서 index또는 시작주소가 일치하는 노드를 리스트에서 제거
///////////////////////////////////////////////////////////////////////////////
CBinNode * CLinkedList::Delete(const int nValue, const int nMode)
{
	CBinNode * pWalker;  // 리스트를 순회할 임시 포인터
	CBinNode * pDelete;  // 삭제될 노드를 저장
	CBinNode * pPrev;  // pWalker의 전 노드
	int n = 0;

	// 머리노드가 없으면 삭제할 노드가 없으므로 NULL 반환
	if(m_pHead == 0)
		return 0;

	pWalker = m_pHead;  // 머리노드를 pWalker에 저장

	// 리스트의 끝까지 순회
	while(pWalker)
	{
		// nMode가 0(1)일 때 삭제할 노드의 index(시작 주소)와 pWalker의 index(시작 주소)가 일치하면
		if((nMode == 0) ? (pWalker->m_nIndex == nValue) : (pWalker->m_nStartAdress == nValue))
		{
			pDelete = pWalker;

			if(n == 0)
				m_pHead = pWalker->pNext;
			else
				pPrev->pNext = pWalker->pNext;
				
			m_nTotalNodeCount--;
			m_nTotalSize -= pDelete->GetSize();
			return pDelete;
		}
		else  // 일치하지 않으면 pWalker를 다음 노드로 이동
		{
			pPrev = pWalker;
			pWalker = pWalker->pNext;
			n++;
		}
	}

	return 0;
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CLinkedList::Coalescing()
//=============================================================================
// Input    : 없음
// Output   : 없음
// Purpose  : 리스트를 순회하면서 메모리의 주소가 이어진 노드들을 병합
///////////////////////////////////////////////////////////////////////////////
void CLinkedList::Coalescing()
{
	CBinNode * pWalker;  // 리스트를 순회할 임시 포인터
	CBinNode * pPre;  // pWalker를 따라오는 포인터

	pWalker = m_pHead;  // 머리노드를 pWalker에 저장
	pPre = pWalker;

	// 리스트의 끝까지 순회
	while(pWalker = pWalker->pNext)
	{
		// pPre의 시작주소+크기의 값이 pWalker의 시작주소와 같으면
		// 즉, 전체 Memory에서 pPre와 pWalker가 인접한 memory라면
		if(pPre->GetStartAdress() + pPre->GetSize() == pWalker->GetStartAdress())
		{
			// pPre의 크기는 pWalker의 크기를 합친 크기
			pPre->m_nSize += pWalker->GetSize();

			pPre->pNext = pWalker->pNext;  // pWalker의 next를 pPrev의 next에 저장
			delete pWalker;  // pWalker 삭제
			m_nTotalNodeCount--;
			pWalker = pPre;  // pPre를 pWalker에 저장
		}
		else  // 인접한 memory가 아니면 pPre에 pWalker 저장
			pPre = pWalker;
	}
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinNode * CLinkedList::GetNode(const int nOrder)
//=============================================================================
// Input    : 리스트 순서
// Output   : 찾은 노드
// Purpose  : 리스트를 순회하면서 해당 순서에 위치하는 노드를 반환
///////////////////////////////////////////////////////////////////////////////
CBinNode * CLinkedList::GetNode(const int nOrder)
{
	CBinNode * pWalker;  // 리스트를 순회할 임시 포인터
	
	pWalker = m_pHead;  // 머리노드를 pWalker에 저장

	// nOrder번째 순서에 있는 노드로 pWalker를 이동
	for(int n=1; n<nOrder; n++)
	{
		pWalker = pWalker->pNext;
	}

	// pWalker 반환
	return pWalker;
}




///////////////////////////////////////////////////////////////////////////////
// Function : int CLinkedList::GetTotalNodeCount()
//=============================================================================
// Input    : 없음
// Output   : 리스트 내 총 노드의 수
// Purpose  : 리스트 내 총 노드의 수 반환
///////////////////////////////////////////////////////////////////////////////
int CLinkedList::GetTotalNodeCount()
{
	return m_nTotalNodeCount;
}




///////////////////////////////////////////////////////////////////////////////
// Function : int CLinkedList::GetTotalSize()
//=============================================================================
// Input    : 없음
// Output   : 리스트 내 총 노드들의 크기의 합
// Purpose  : 리스트 내 총 노드들의 크기의 합 반환
///////////////////////////////////////////////////////////////////////////////
int CLinkedList::GetTotalSize()
{
	return m_nTotalSize;
}
