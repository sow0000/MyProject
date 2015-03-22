///////////////////////////////////////////////////////////////////////////////
// File Name      : bintree.cpp
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : 김태형
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : Binomial Heaps 구조를 이용하여 노드를 삽입 및 삭제 (구현)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include "bintree.h"




///////////////////////////////////////////////////////////////////////////////
// Function : CBinTree::CBinTree()
//=============================================================================
// Input    : 없음
// Output   : 없음
// Purpose  : 기본 생성자(BinTree내 멤버변수 초기화)
///////////////////////////////////////////////////////////////////////////////
CBinTree::CBinTree()
{
	pMaxNode = 0;
	ATreeList = new CBinNode*[10];
	memset(ATreeList, 0, sizeof(CBinNode*)*10);
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinTree::~CBinTree()
//=============================================================================
// Input    : 없음
// Output   : 없음
// Purpose  : 기본 소멸자(BinTree내 ATreeList배열 해제
///////////////////////////////////////////////////////////////////////////////
CBinTree::~CBinTree()
{
	delete [] ATreeList;

	// 트리 내 노드들은 Available LinkedList가 삭제함
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CBinTree::Insert(CBinNode * BinNode)
//=============================================================================
// Input    : 삽입할 노드
// Output   : 없음
// Purpose  : BinTree내에 노드를 삽입
///////////////////////////////////////////////////////////////////////////////
void CBinTree::Insert(CBinNode * BinNode)
{
	// Max노드가 없으면 Tree내 어떤 노드도 없으므로 삽입된 노드가 Max노드가 됨
	if(!pMaxNode)
	{
		pMaxNode = BinNode;
		BinNode->pBrother = BinNode;  // 형제 노드는 자기 자신을 가리킴
		return;
	}

	// 새로 들어온 노드를 Max노드 다음에 삽입
	BinNode->pBrother = pMaxNode->pBrother;
	pMaxNode->pBrother = BinNode;

	// Max노드 보다 삽입된 노드의 빈 공간이 더 크면 그 노드가 Max노드가 됨
	if(pMaxNode->m_nSize < BinNode->m_nSize)
	{
		pMaxNode = BinNode;
	}
	// Max노드와 삽입된 노드의 빈 공간이 같으면
	else if(pMaxNode->m_nSize == BinNode->m_nSize)
	{
		// 삽입된 노드의 주소가 Max노드보다 작으면 그 노드가 Max노드가 됨
		if(pMaxNode->m_nStartAdress > BinNode->m_nStartAdress)
			pMaxNode = BinNode;
	}
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinNode ** CBinTree::DeleteMax(CBinNode* & BinNode)
//=============================================================================
// Input    : 삭제할 노드
// Output   : 삭제할 노드의 주소값을 반환
// Purpose  : BinTree의 Max노드를 반환
///////////////////////////////////////////////////////////////////////////////
CBinNode ** CBinTree::DeleteMax(CBinNode* & BinNode)
{
	memset(ATreeList, 0, sizeof(CBinNode*)*10);  // ATreeList 초기화
	CBinNode * pWalker = 0;  // BinTree를 순회할 포인터
	CBinNode * pChild = 0;  // Max노드의 자식을 가리키는 포인터
	CBinNode * pNext = 0;  // 현재 노드의 다음 노드를 기리키는 포인터

	// Max노드가 없으면 NULL 리턴
	if(pMaxNode == 0)
	{
		cout << "BinTree 내에 삭제할 노드가 없습니다.\n";
		return 0;
	}

	// Max노드를 삭제할 노드에 저장
	BinNode = pMaxNode;

	// pChild는 Max노드의 자식 노드로 이동
	pChild = pMaxNode->pChild;
	
	// Max노드를 다음 노드로 이동, 그 곳에 pWalker를 위치시키고, Max노드는 null 저장
	pWalker = pMaxNode->pBrother;
	pMaxNode = 0;


	// Max노드의 형제노드를 순회하면서 트리정보를 수집
	while(pWalker != BinNode)
	{
		int nDegree;
		
		// pNext에 pWalker의 다음 노드를 저장
		pNext = pWalker->pBrother;

		// pWalker와 자식 수가 같은 트리가 있으면 서로 결합
		for(nDegree = pWalker->m_nChildDegree; ATreeList[nDegree]; nDegree++)
		{
			pWalker = JoinTrees(pWalker, ATreeList[nDegree]);
			ATreeList[nDegree] = 0;
		}
		
		ATreeList[nDegree] = pWalker;  // pWalker를 nDegree위치에 저장
		pWalker = pNext;  // 다음 노드로 이동
	}

	
	// pWalker를 Max노드의 자식노드로 이동
	pWalker = pChild;

	// Max노드의 자식노드를 순회하면서 트리정보를 수집
	while(pWalker)
	{
		int nDegree;
		
		// pNext에 pWalker의 다음 노드를 저장
		pNext = pWalker->pBrother;

		// pWalker와 자식 수가 같은 트리가 있으면 서로 결합
		for(nDegree = pWalker->m_nChildDegree; ATreeList[nDegree]; nDegree++)
		{
			pWalker = JoinTrees(pWalker, ATreeList[nDegree]);
			ATreeList[nDegree] = 0;
		}
		
		ATreeList[nDegree] = pWalker;  // pWalker를 nDegree위치에 저장
		pWalker = pNext;  // 다음 노드로 이동

		// 자식 노드를 순회 완료했으면 반복문 탈출
		if(pWalker == pChild)
			break;
	}


////// ATreeList에 있는 노드들을 전부 형제로 이은 뒤 Max노드 찾아서 저장 //////
	
	CBinNode * pBase = 0;
	CBinNode * pCur = 0;
	pNext = 0;
	int n;

	// ATreeList에 있는 첫번째 노드를 찾음
	for(n=0; n<10; n++)
	{
		// 노드를 찾았으면 pBase, pMaxNode, pNext를 전부 찾은 노드로 초기화
		if(pCur = ATreeList[n])
		{
			pBase = pCur;
			pMaxNode = pCur;
			pNext = pCur;
			break;
		}
	}

	// ATreeList에 있는 나머지 노드들과 형제로 연결
	for(n+=1; n<10; n++)
	{
		// ATreeList의 n번째 배열에 값이 없으면 다음 위치로 이동
		if(!ATreeList[n])
			continue;

		// ATreeList의 n번째 배열에 값이 있으면 노드 연결
		if(pNext = ATreeList[n])
		{
			pCur->pBrother = pNext;
			pCur = pNext;
			
			// Max노드가 다음 노드보다 크기가 작으면 Max노드를 다음 노드로 저장
			if(pMaxNode->GetSize() < pCur->GetSize())
				pMaxNode = pCur;
			else if(pMaxNode->GetSize() == pCur->GetSize())
			{
				// Max노드가 다음 노드보다 시작주소가 크면 Max노드를 다음 노드로 저장
				if(pMaxNode->GetStartAdress() > pCur->GetStartAdress())
					pMaxNode = pCur;
			}
		}
	}

	// 제일 마지막 노드의 다음을 처음 노드로 이어서 circular list 만들기
	if(pNext)
		pNext->pBrother = pBase;

/////////////////////////////////// The End ///////////////////////////////////
	
	// 삭제할 노드의 BinTree내에서 쓰이는 포인터 초기화
	BinNode->pBrother = 0;
	BinNode->pChild = 0;
	BinNode->m_nChildDegree = 0;

	return &BinNode;  // Max 노드 반환
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinNode * CBinTree::JoinTrees(CBinNode * PriNode, CBinNode * SecNode)
//=============================================================================
// Input    : 합칠 두 binomial tree의 max노드들
// Output   : 합쳐진 binomial tree의 max노드
// Purpose  : 두 binomial tree를 하나의 tree로 합침
///////////////////////////////////////////////////////////////////////////////
CBinNode * CBinTree::JoinTrees(CBinNode * PriNode, CBinNode * SecNode)
{
	// 두 노드의 크기가 같으면 시작 주소로 비교
	if(PriNode->GetSize() == SecNode->GetSize())
	{
		if(PriNode->GetStartAdress() > SecNode->GetStartAdress())
			return LinkBrother(PriNode, SecNode);
		else
			return LinkBrother(SecNode, PriNode);
	}
	// PriNode가 SecNode보다 크면
	else if(PriNode->GetSize() > SecNode->GetSize())
		return LinkBrother(PriNode, SecNode);
	// SecNode가 PriNode보다 크면
	else
		return LinkBrother(SecNode, PriNode);
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinNode * CBinTree::LinkBrother(CBinNode * BigNode, CBinNode * SmallNode)
//=============================================================================
// Input    : 합칠 두 binomial tree의 max노드들
// Output   : 합쳐진 binomial tree의 max노드
// Purpose  : 두 binomial tree가 합쳐질 때의 포인터 연결관계를 지정
///////////////////////////////////////////////////////////////////////////////
CBinNode * CBinTree::LinkBrother(CBinNode * BigNode, CBinNode * SmallNode)
{
	CBinNode * pTemp;  // 임시 변수

	// 큰 노드의 자식이 없으면 작은 노드를 바로 큰 노드의 자식으로 저장
	if(BigNode->pChild == 0)
	{
		BigNode->pChild = SmallNode;
		SmallNode->pBrother = SmallNode;
		BigNode->m_nChildDegree++;  // 큰 노드의 degree 증가
		return BigNode;
	}

	pTemp = BigNode->pChild;  // pTemp에 큰 노드의 자식노드 저장

	// 그 위치의 다음 형제로 작은 노드를 연결
	SmallNode->pBrother = pTemp->pBrother;
	pTemp->pBrother = SmallNode;

	BigNode->m_nChildDegree++;  // 큰 노드의 degree 증가

	return BigNode;  // 큰 노드 반환
}




///////////////////////////////////////////////////////////////////////////////
// Function : int CBinTree::GetMaxNodeSize()
//=============================================================================
// Input    : 없음
// Output   : max노드의 크기
// Purpose  : max노드의 크기를 반환
///////////////////////////////////////////////////////////////////////////////
int CBinTree::GetMaxNodeSize()
{
	return pMaxNode->GetSize();
}
