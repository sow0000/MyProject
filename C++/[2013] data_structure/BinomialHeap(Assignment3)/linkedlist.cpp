///////////////////////////////////////////////////////////////////////////////
// File Name      : linkedlist.cpp
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

#include "linkedlist.h"




///////////////////////////////////////////////////////////////////////////////
// Function : CLinkedList::CLinkedList()
//=============================================================================
// Input    : ����
// Output   : ����
// Purpose  : �⺻ ������(��������� �ʱ�ȭ)
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
// Input    : ����
// Output   : ����
// Purpose  : �⺻ �Ҹ���(����Ʈ�� �Ҵ�� ������ �޸� ����)
///////////////////////////////////////////////////////////////////////////////
CLinkedList::~CLinkedList()
{
	CBinNode * pDelete;  // ������ ���
	CBinNode * pWalker;  // ����Ʈ�� ��ȸ�� �ӽ� ������

	pWalker = m_pHead;  // pWalker�� �Ӹ���� ����

	// ����Ʈ ��ȸ�ϸ鼭 ������ ���� �޸� ����
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
// Input    : ������ ���
// Output   : ����
// Purpose  : ����Ʈ�� ��带 ����
///////////////////////////////////////////////////////////////////////////////
void CLinkedList::Insert(CBinNode * BinNode)
{
	CBinNode * pWalker;  // ����Ʈ�� ��ȸ�� �ӽ� ������

	// �Ӹ���尡 ������ ���ε��� ��尡 �Ӹ���尡 ��
	if(m_pHead == 0)
	{
		m_pHead = BinNode;
		m_nTotalNodeCount++;
		m_nTotalSize += BinNode->GetSize();
		return;
	}

	pWalker = m_pHead;  // �Ӹ���带 pWalker�� ����

	// ����Ʈ�� ������ ��ȸ
	while(pWalker)
	{
		// �߰��� ����� �����ּҰ� pWalker ���� ������
		if(pWalker->m_nStartAdress > BinNode->m_nStartAdress)
		{
			// �߰��� ����� �����ּҰ� pWalker���� ���� ����
			// �Ӹ� ���� ���� �� �ۿ� �����Ƿ�
			// �߰��� ��带 �Ӹ� ���� �Ѵ�
			BinNode->pNext = m_pHead;
			m_pHead = BinNode;
			m_nTotalNodeCount++;
			m_nTotalSize += BinNode->GetSize();
			break;
		}
		else  // �߰��� ����� �����ּҰ� pWalker ���� ũ��
		{
			// pWalker�� ���� ��尡 ������ �� ���� ����
			if(pWalker->pNext == 0)
			{
				pWalker->pNext = BinNode;
				m_nTotalNodeCount++;
				m_nTotalSize += BinNode->GetSize();
				break;
			}

			// pWalker�� ���� ��庸�� ������ pWalker�� next�� ����
			if(pWalker->pNext->m_nStartAdress > BinNode->m_nStartAdress)
			{
				BinNode->pNext = pWalker->pNext;
				pWalker->pNext = BinNode;
				m_nTotalNodeCount++;
				m_nTotalSize += BinNode->GetSize();
				break;
			}
			else // pWalker�� ���� ��庸�ٵ� ũ�� pWalker�� ���� ���� �̵�
				pWalker = pWalker->pNext;
		}
	}
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinNode * CLinkedList::Delete(const int nValue, const int nMode)
//=============================================================================
// Input    : ����Ʈ�� ��带 ������ ���� ����(mode)
// Output   : ������ ���
// Purpose  : ���ǿ� ���� index�Ǵ� �����ּҰ� ��ġ�ϴ� ��带 ����Ʈ���� ����
///////////////////////////////////////////////////////////////////////////////
CBinNode * CLinkedList::Delete(const int nValue, const int nMode)
{
	CBinNode * pWalker;  // ����Ʈ�� ��ȸ�� �ӽ� ������
	CBinNode * pDelete;  // ������ ��带 ����
	CBinNode * pPrev;  // pWalker�� �� ���
	int n = 0;

	// �Ӹ���尡 ������ ������ ��尡 �����Ƿ� NULL ��ȯ
	if(m_pHead == 0)
		return 0;

	pWalker = m_pHead;  // �Ӹ���带 pWalker�� ����

	// ����Ʈ�� ������ ��ȸ
	while(pWalker)
	{
		// nMode�� 0(1)�� �� ������ ����� index(���� �ּ�)�� pWalker�� index(���� �ּ�)�� ��ġ�ϸ�
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
		else  // ��ġ���� ������ pWalker�� ���� ���� �̵�
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
// Input    : ����
// Output   : ����
// Purpose  : ����Ʈ�� ��ȸ�ϸ鼭 �޸��� �ּҰ� �̾��� ������ ����
///////////////////////////////////////////////////////////////////////////////
void CLinkedList::Coalescing()
{
	CBinNode * pWalker;  // ����Ʈ�� ��ȸ�� �ӽ� ������
	CBinNode * pPre;  // pWalker�� ������� ������

	pWalker = m_pHead;  // �Ӹ���带 pWalker�� ����
	pPre = pWalker;

	// ����Ʈ�� ������ ��ȸ
	while(pWalker = pWalker->pNext)
	{
		// pPre�� �����ּ�+ũ���� ���� pWalker�� �����ּҿ� ������
		// ��, ��ü Memory���� pPre�� pWalker�� ������ memory���
		if(pPre->GetStartAdress() + pPre->GetSize() == pWalker->GetStartAdress())
		{
			// pPre�� ũ��� pWalker�� ũ�⸦ ��ģ ũ��
			pPre->m_nSize += pWalker->GetSize();

			pPre->pNext = pWalker->pNext;  // pWalker�� next�� pPrev�� next�� ����
			delete pWalker;  // pWalker ����
			m_nTotalNodeCount--;
			pWalker = pPre;  // pPre�� pWalker�� ����
		}
		else  // ������ memory�� �ƴϸ� pPre�� pWalker ����
			pPre = pWalker;
	}
}




///////////////////////////////////////////////////////////////////////////////
// Function : CBinNode * CLinkedList::GetNode(const int nOrder)
//=============================================================================
// Input    : ����Ʈ ����
// Output   : ã�� ���
// Purpose  : ����Ʈ�� ��ȸ�ϸ鼭 �ش� ������ ��ġ�ϴ� ��带 ��ȯ
///////////////////////////////////////////////////////////////////////////////
CBinNode * CLinkedList::GetNode(const int nOrder)
{
	CBinNode * pWalker;  // ����Ʈ�� ��ȸ�� �ӽ� ������
	
	pWalker = m_pHead;  // �Ӹ���带 pWalker�� ����

	// nOrder��° ������ �ִ� ���� pWalker�� �̵�
	for(int n=1; n<nOrder; n++)
	{
		pWalker = pWalker->pNext;
	}

	// pWalker ��ȯ
	return pWalker;
}




///////////////////////////////////////////////////////////////////////////////
// Function : int CLinkedList::GetTotalNodeCount()
//=============================================================================
// Input    : ����
// Output   : ����Ʈ �� �� ����� ��
// Purpose  : ����Ʈ �� �� ����� �� ��ȯ
///////////////////////////////////////////////////////////////////////////////
int CLinkedList::GetTotalNodeCount()
{
	return m_nTotalNodeCount;
}




///////////////////////////////////////////////////////////////////////////////
// Function : int CLinkedList::GetTotalSize()
//=============================================================================
// Input    : ����
// Output   : ����Ʈ �� �� ������ ũ���� ��
// Purpose  : ����Ʈ �� �� ������ ũ���� �� ��ȯ
///////////////////////////////////////////////////////////////////////////////
int CLinkedList::GetTotalSize()
{
	return m_nTotalSize;
}
