///////////////////////////////////////////////////////////////////////////////
// File Name      : bintree.cpp
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : ������
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : Binomial Heaps ������ �̿��Ͽ� ��带 ���� �� ���� (����)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include "bintree.h"




///////////////////////////////////////////////////////////////////////////////
// Function : CBinTree::CBinTree()
//=============================================================================
// Input    : ����
// Output   : ����
// Purpose  : �⺻ ������(BinTree�� ������� �ʱ�ȭ)
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
// Input    : ����
// Output   : ����
// Purpose  : �⺻ �Ҹ���(BinTree�� ATreeList�迭 ����
///////////////////////////////////////////////////////////////////////////////
CBinTree::~CBinTree()
{
	delete [] ATreeList;

	// Ʈ�� �� ������ Available LinkedList�� ������
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CBinTree::Insert(CBinNode * BinNode)
//=============================================================================
// Input    : ������ ���
// Output   : ����
// Purpose  : BinTree���� ��带 ����
///////////////////////////////////////////////////////////////////////////////
void CBinTree::Insert(CBinNode * BinNode)
{
	// Max��尡 ������ Tree�� � ��嵵 �����Ƿ� ���Ե� ��尡 Max��尡 ��
	if(!pMaxNode)
	{
		pMaxNode = BinNode;
		BinNode->pBrother = BinNode;  // ���� ���� �ڱ� �ڽ��� ����Ŵ
		return;
	}

	// ���� ���� ��带 Max��� ������ ����
	BinNode->pBrother = pMaxNode->pBrother;
	pMaxNode->pBrother = BinNode;

	// Max��� ���� ���Ե� ����� �� ������ �� ũ�� �� ��尡 Max��尡 ��
	if(pMaxNode->m_nSize < BinNode->m_nSize)
	{
		pMaxNode = BinNode;
	}
	// Max���� ���Ե� ����� �� ������ ������
	else if(pMaxNode->m_nSize == BinNode->m_nSize)
	{
		// ���Ե� ����� �ּҰ� Max��庸�� ������ �� ��尡 Max��尡 ��
		if(pMaxNode->m_nStartAdress > BinNode->m_nStartAdress)
			pMaxNode = BinNode;
	}
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinNode ** CBinTree::DeleteMax(CBinNode* & BinNode)
//=============================================================================
// Input    : ������ ���
// Output   : ������ ����� �ּҰ��� ��ȯ
// Purpose  : BinTree�� Max��带 ��ȯ
///////////////////////////////////////////////////////////////////////////////
CBinNode ** CBinTree::DeleteMax(CBinNode* & BinNode)
{
	memset(ATreeList, 0, sizeof(CBinNode*)*10);  // ATreeList �ʱ�ȭ
	CBinNode * pWalker = 0;  // BinTree�� ��ȸ�� ������
	CBinNode * pChild = 0;  // Max����� �ڽ��� ����Ű�� ������
	CBinNode * pNext = 0;  // ���� ����� ���� ��带 �⸮Ű�� ������

	// Max��尡 ������ NULL ����
	if(pMaxNode == 0)
	{
		cout << "BinTree ���� ������ ��尡 �����ϴ�.\n";
		return 0;
	}

	// Max��带 ������ ��忡 ����
	BinNode = pMaxNode;

	// pChild�� Max����� �ڽ� ���� �̵�
	pChild = pMaxNode->pChild;
	
	// Max��带 ���� ���� �̵�, �� ���� pWalker�� ��ġ��Ű��, Max���� null ����
	pWalker = pMaxNode->pBrother;
	pMaxNode = 0;


	// Max����� ������带 ��ȸ�ϸ鼭 Ʈ�������� ����
	while(pWalker != BinNode)
	{
		int nDegree;
		
		// pNext�� pWalker�� ���� ��带 ����
		pNext = pWalker->pBrother;

		// pWalker�� �ڽ� ���� ���� Ʈ���� ������ ���� ����
		for(nDegree = pWalker->m_nChildDegree; ATreeList[nDegree]; nDegree++)
		{
			pWalker = JoinTrees(pWalker, ATreeList[nDegree]);
			ATreeList[nDegree] = 0;
		}
		
		ATreeList[nDegree] = pWalker;  // pWalker�� nDegree��ġ�� ����
		pWalker = pNext;  // ���� ���� �̵�
	}

	
	// pWalker�� Max����� �ڽĳ��� �̵�
	pWalker = pChild;

	// Max����� �ڽĳ�带 ��ȸ�ϸ鼭 Ʈ�������� ����
	while(pWalker)
	{
		int nDegree;
		
		// pNext�� pWalker�� ���� ��带 ����
		pNext = pWalker->pBrother;

		// pWalker�� �ڽ� ���� ���� Ʈ���� ������ ���� ����
		for(nDegree = pWalker->m_nChildDegree; ATreeList[nDegree]; nDegree++)
		{
			pWalker = JoinTrees(pWalker, ATreeList[nDegree]);
			ATreeList[nDegree] = 0;
		}
		
		ATreeList[nDegree] = pWalker;  // pWalker�� nDegree��ġ�� ����
		pWalker = pNext;  // ���� ���� �̵�

		// �ڽ� ��带 ��ȸ �Ϸ������� �ݺ��� Ż��
		if(pWalker == pChild)
			break;
	}


////// ATreeList�� �ִ� ������ ���� ������ ���� �� Max��� ã�Ƽ� ���� //////
	
	CBinNode * pBase = 0;
	CBinNode * pCur = 0;
	pNext = 0;
	int n;

	// ATreeList�� �ִ� ù��° ��带 ã��
	for(n=0; n<10; n++)
	{
		// ��带 ã������ pBase, pMaxNode, pNext�� ���� ã�� ���� �ʱ�ȭ
		if(pCur = ATreeList[n])
		{
			pBase = pCur;
			pMaxNode = pCur;
			pNext = pCur;
			break;
		}
	}

	// ATreeList�� �ִ� ������ ����� ������ ����
	for(n+=1; n<10; n++)
	{
		// ATreeList�� n��° �迭�� ���� ������ ���� ��ġ�� �̵�
		if(!ATreeList[n])
			continue;

		// ATreeList�� n��° �迭�� ���� ������ ��� ����
		if(pNext = ATreeList[n])
		{
			pCur->pBrother = pNext;
			pCur = pNext;
			
			// Max��尡 ���� ��庸�� ũ�Ⱑ ������ Max��带 ���� ���� ����
			if(pMaxNode->GetSize() < pCur->GetSize())
				pMaxNode = pCur;
			else if(pMaxNode->GetSize() == pCur->GetSize())
			{
				// Max��尡 ���� ��庸�� �����ּҰ� ũ�� Max��带 ���� ���� ����
				if(pMaxNode->GetStartAdress() > pCur->GetStartAdress())
					pMaxNode = pCur;
			}
		}
	}

	// ���� ������ ����� ������ ó�� ���� �̾ circular list �����
	if(pNext)
		pNext->pBrother = pBase;

/////////////////////////////////// The End ///////////////////////////////////
	
	// ������ ����� BinTree������ ���̴� ������ �ʱ�ȭ
	BinNode->pBrother = 0;
	BinNode->pChild = 0;
	BinNode->m_nChildDegree = 0;

	return &BinNode;  // Max ��� ��ȯ
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinNode * CBinTree::JoinTrees(CBinNode * PriNode, CBinNode * SecNode)
//=============================================================================
// Input    : ��ĥ �� binomial tree�� max����
// Output   : ������ binomial tree�� max���
// Purpose  : �� binomial tree�� �ϳ��� tree�� ��ħ
///////////////////////////////////////////////////////////////////////////////
CBinNode * CBinTree::JoinTrees(CBinNode * PriNode, CBinNode * SecNode)
{
	// �� ����� ũ�Ⱑ ������ ���� �ּҷ� ��
	if(PriNode->GetSize() == SecNode->GetSize())
	{
		if(PriNode->GetStartAdress() > SecNode->GetStartAdress())
			return LinkBrother(PriNode, SecNode);
		else
			return LinkBrother(SecNode, PriNode);
	}
	// PriNode�� SecNode���� ũ��
	else if(PriNode->GetSize() > SecNode->GetSize())
		return LinkBrother(PriNode, SecNode);
	// SecNode�� PriNode���� ũ��
	else
		return LinkBrother(SecNode, PriNode);
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinNode * CBinTree::LinkBrother(CBinNode * BigNode, CBinNode * SmallNode)
//=============================================================================
// Input    : ��ĥ �� binomial tree�� max����
// Output   : ������ binomial tree�� max���
// Purpose  : �� binomial tree�� ������ ���� ������ ������踦 ����
///////////////////////////////////////////////////////////////////////////////
CBinNode * CBinTree::LinkBrother(CBinNode * BigNode, CBinNode * SmallNode)
{
	CBinNode * pTemp;  // �ӽ� ����

	// ū ����� �ڽ��� ������ ���� ��带 �ٷ� ū ����� �ڽ����� ����
	if(BigNode->pChild == 0)
	{
		BigNode->pChild = SmallNode;
		SmallNode->pBrother = SmallNode;
		BigNode->m_nChildDegree++;  // ū ����� degree ����
		return BigNode;
	}

	pTemp = BigNode->pChild;  // pTemp�� ū ����� �ڽĳ�� ����

	// �� ��ġ�� ���� ������ ���� ��带 ����
	SmallNode->pBrother = pTemp->pBrother;
	pTemp->pBrother = SmallNode;

	BigNode->m_nChildDegree++;  // ū ����� degree ����

	return BigNode;  // ū ��� ��ȯ
}




///////////////////////////////////////////////////////////////////////////////
// Function : int CBinTree::GetMaxNodeSize()
//=============================================================================
// Input    : ����
// Output   : max����� ũ��
// Purpose  : max����� ũ�⸦ ��ȯ
///////////////////////////////////////////////////////////////////////////////
int CBinTree::GetMaxNodeSize()
{
	return pMaxNode->GetSize();
}
