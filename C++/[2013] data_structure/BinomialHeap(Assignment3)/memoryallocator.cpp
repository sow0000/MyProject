///////////////////////////////////////////////////////////////////////////////
// File Name      : memoryallocator.cpp
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

#include "memoryallocator.h"




///////////////////////////////////////////////////////////////////////////////
// Function : CMemoryAllocator::CMemoryAllocator()
//=============================================================================
// Input    : ����
// Output   : ����
// Purpose  : �⺻ ������(������� �ʱ�ȭ)
///////////////////////////////////////////////////////////////////////////////
CMemoryAllocator::CMemoryAllocator()
{
	Fin = new CFile();  // Fin ����
	Fout = new CFile();  // Fout ����
	BinTree = new CBinTree();  // Binomial Tree ����
	AllocatedList = new CLinkedList();  // �Ҵ�� Memory List ����
	AvailableList = new CLinkedList();  // ���Ҵ�� Memory List ����

	m_nTotalMBSize = 0;  // ��ü Memory Block�� ũ��
	m_nCoalescingCount = 0;  // Memory Coalescing Ƚ��
	m_nFailureCount = 0;  // Memory Allocation Failure Ƚ��
	m_nCheck = 0;  // ���� ������� üũ
}




///////////////////////////////////////////////////////////////////////////////
// Function : CMemoryAllocator::~CMemoryAllocator()
//=============================================================================
// Input    : ����
// Output   : ����
// Purpose  : �⺻ �Ҹ���(�Ҵ�� ��ü ����)
///////////////////////////////////////////////////////////////////////////////
CMemoryAllocator::~CMemoryAllocator()
{
	delete Fin;  // File ����
	delete Fout;  // File ����
	delete BinTree;  // Binomial Tree ����
	delete AllocatedList;  // �Ҵ�� Memory List ����
	delete AvailableList;  // ���Ҵ�� Memory List ����
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CMemoryAllocator::Run()
//=============================================================================
// Input    : ����
// Output   : ����
// Purpose  : ���Ͽ��� ���ڵ带 �о�ͼ� command�� ���� �����Լ� ȣ��
///////////////////////////////////////////////////////////////////////////////
void CMemoryAllocator::Run()
{
	char * szBuffer = 0;  // ���Ͽ��� ���� ���ڿ�(���ڵ�)
	char * szCommand = 0;  // ���ڿ�(���ڵ�)�� ù��° ��ū(command)
	char * szIndex = 0;  // ���ڿ�(���ڵ�)�� �ι�° ��ū(Memory Block Index)
	char * szSize = 0;  // ���ڿ�(���ڵ�)�� ����° ��ū(Memory Block Size)
	
	int nIndex, nSize;  // Memory Block�� index�� ũ���� ������
	int nLine = 0;  // ������ �� ��
	

	Fin->Open("scenario.in", ios::in);  // ���� ����

	// ������ �� ���� �� ���� �ݺ�
	while(szBuffer = Fin->ReadLine())
	{
		nLine++;  // ������ �� �� ����

		// ������ ù��° ���ڿ��� Total Memory Space�� ����
		if(nLine == 1)
		{
			szSize = strtok(szBuffer, " \t\r\n");
			nSize = atoi(szSize);
			m_nTotalMBSize = nSize;

			// �ʱ� ����� index�� 0, �����ּҴ� 0, ũ��� nSize��
			CBinNode * BinNode = new CBinNode(0, 0, nSize);

			// ���Ҵ� Memory ����Ʈ�� ����
			AvailableList->Insert(BinNode);

			// ��带 BinTree�� ����
			BinTree->Insert(BinNode);

			continue;
		}

		// ���ڵ��� ù��° ��ū(command)�� ����
		szCommand = strtok(szBuffer, " \t\r\n");
		
		//////////////////////
		// �޸� �Ҵ� ��� //
		//////////////////////
		if(strcmp(szCommand, "A") == 0 || strcmp(szCommand, "a") == 0)
		{
			// Memory Block�� index�� ũ�⸦ ����
			szIndex = strtok(NULL, " \t\r\n");
			nIndex = atoi(szIndex);
			szSize = strtok(NULL, " \r\r\n");
			nSize = atoi(szSize);

			// �޸� �Ҵ�
			AllocateMemory(nIndex, nSize);
		}
		//////////////////////
		// �޸� ���� ��� //
		//////////////////////
		else if(strcmp(szCommand, "F") == 0 || strcmp(szCommand, "f") == 0)
		{
			// Memory Block�� index ����
			szIndex = strtok(NULL, " \t\r\n");
			nIndex = atoi(szIndex);

			// �޸� ����
			FreeMemory(nIndex);
		}
		///////////////////////////
		// �޸� �Ҵ� ���� ��� //
		///////////////////////////
		else if(strcmp(szCommand, "S") == 0 || strcmp(szCommand, "s") == 0)
		{
			// �޸� �Ҵ���� ���
			WriteMemoryState();
		}
		///////////////
		// ���� ó�� //
		///////////////
		else
		{
			cout << "������ " << nLine << "��° ���� �ùٸ� �Է� ������ �ƴմϴ�.\n";
		}
	}

	Fin->Close();  // ���� �ݱ�
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CMemoryAllocator::AllocateMemory(int nIndex, int nSize)
//=============================================================================
// Input    : �޸� index�� ũ��
// Output   : ����
// Purpose  : �ش� index�� ũ�⸦ ������ �޸� ����
///////////////////////////////////////////////////////////////////////////////
void CMemoryAllocator::AllocateMemory(int nIndex, int nSize)
{
	///////////////////////////////////////////////////////////////
	// ���Ӱ� �Ҵ��� ��尡 Max��忡 �Ҵ�� �� �ִ��� Ȯ��
	// �Ҵ�� ������ ������, coalescing�� �� �ִ� �޸��� ũ�� Ȯ��
	// ���� coalescing ���� ��쿡 �Ҵ��� �����ϴٸ� coalescing �ǽ�
	// coalescing �ǽõ� ��忡 �Ҵ��� ��
	////////////////////////////////////////////////////////////////

	int nStartAdress;  // ����� �����ּ�

	// �Ҵ��� �޸𸮰� BinTree�� Max��庸�� ũ��
	if(nSize > BinTree->GetMaxNodeSize())
	{
		// ���Ҵ�� �޸��� �� ũ�⺸�� ũ�� �Ҵ� ����
		if(nSize > AvailableList->GetTotalSize())
		{
			m_nFailureCount++;
			return;
		}
		// ���Ҵ�� �޸��� �� ũ�⺸�� ������ Coalescing �ǽ�
		else
		{
			CoalescingMemory();
			m_nCoalescingCount++;
		}
	}

	// Coalescing�� �ǽ��������� Max��庸�� �Ҵ��� �޸𸮰� ũ�� �Ҵ� ����
	if(nSize > BinTree->GetMaxNodeSize())
	{
		m_nFailureCount++;
		return;
	}

	// BinTree�� Max ��带 ����
	CBinNode * BinNode;
	BinNode = *BinTree->DeleteMax(BinNode);

	// Max ��带 ���Ҵ� Memory ����Ʈ������ ����
	BinNode = AvailableList->Delete(BinNode->GetStartAdress(), 1);

	// Max ����� �����ּҸ� ����
	nStartAdress = BinNode->GetStartAdress();
	
	// �Ҵ�� ��� ����
	CBinNode * AllocatedNode = new CBinNode(nIndex, nStartAdress, nSize);
	
	// �Ҵ�� ��带 �Ҵ� Memory ����Ʈ�� ����
	AllocatedList->Insert(AllocatedNode);

	// ���Ҵ�� ����� �����ּ�(�Ҵ�� ����� �����ּ� + ũ��)
	nStartAdress = nStartAdress + nSize;
	
	// ���Ҵ�� ����� ũ��(Max ����� ũ�� - �Ҵ�� ����� ũ��)
	nSize = BinNode->GetSize() - nSize;
	
	// �Ҵ�ǰ� ���� �޸��� ũ�Ⱑ 0�� �ƴϸ� ���� ������ ���Ҵ� �޸� ����
	if(nSize != 0)
	{
		// ���Ҵ�� ��� ����
		CBinNode * AvailableNode = new CBinNode(0, nStartAdress, nSize);

		// ���Ҵ�� ��带 ���Ҵ� Memory ����Ʈ�� ����
		AvailableList->Insert(AvailableNode);

		// ���Ҵ�� ��带 BinTree�� ����
		BinTree->Insert(AvailableNode);
	}

	// Max��� ����
	delete BinNode;
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CMemoryAllocator::FreeMemory(int nIndex)
//=============================================================================
// Input    : �޸� index
// Output   : ����
// Purpose  : �ش� index�� �ش��ϴ� �޸� ����
///////////////////////////////////////////////////////////////////////////////
void CMemoryAllocator::FreeMemory(int nIndex)
{
	// �Ҵ� ����Ʈ���� �ش� index�� �ش��ϴ� ��带 ����
	CBinNode * BinNode = AllocatedList->Delete(nIndex, 0);

	// ��尡 ���ٸ� ���� ����
	if(!BinNode)
	{
		cout << "������ �޸𸮰� �����ϴ�.\n";
		return;
	}

	// BinNode�� ���� �����͸� �ʱ�ȭ �� �� 
	BinNode->Initialize();
	
	// ���Ҵ� Memory ����Ʈ�� ����
	AvailableList->Insert(BinNode);

	// BinTree�� ����
	BinTree->Insert(BinNode);
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CMemoryAllocator::CoalescingMemory()
//=============================================================================
// Input    : ����
// Output   : ����
// Purpose  : ���Ҵ�� �޸𸮵� �� �ּҰ� �̾��� �޸𸮵� ����
///////////////////////////////////////////////////////////////////////////////
void CMemoryAllocator::CoalescingMemory()
{
	// BinTree�� �ִ� ��� ��� ����
	CBinNode * pTemp;
	while(BinTree->DeleteMax(pTemp)){}

	// AvailableList�� ���󰡸鼭 �̾����ִ� ��� ��ġ��
	AvailableList->Coalescing();


	// AvailableList�� �ִ� ��� ���� BinTree�� ����
	for(int n=1; n<=AvailableList->GetTotalNodeCount(); n++)
	{
		BinTree->Insert(AvailableList->GetNode(n));
	}
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CMemoryAllocator::WriteMemoryState()
//=============================================================================
// Input    : ����
// Output   : ����
// Purpose  : �޸� �Ҵ� �� ���Ҵ� ���� ���Ͽ� ���
///////////////////////////////////////////////////////////////////////////////
void CMemoryAllocator::WriteMemoryState()
{
	char szTemp[10] = {0};  // ���ڿ� �ӽ� ���� ����

	if(m_nCheck == 0)
	{
		Fout->Open("result.out", ios::out);  // ���� ����
		m_nCheck++;
	}
	else
		Fout->Open("result.out", ios::out | ios::app);  // ���� �̾�� ���� ����
	

	// ��� �޴� ���
	Fout->WriteLine("\nCurent Memory Allocation State\n");
	Fout->WriteLine("=================================\n");
	
	// ���Ҵ�� �޸� ���
	Fout->WriteLine("Available memory space : ");
	Fout->WriteLine(AvailableList->GetTotalSize());
	Fout->WriteLine("\n");
	for(int n=1; n<=AvailableList->GetTotalNodeCount(); n++)
	{
		Fout->WriteLine(n);
		Fout->WriteLine(" : ");
		Fout->WriteLine(AvailableList->GetNode(n)->GetStartAdress());
		Fout->WriteLine(" - ");
		Fout->WriteLine(AvailableList->GetNode(n)->GetStartAdress() + AvailableList->GetNode(n)->GetSize() - 1);
		Fout->WriteLine("\n");
	}

	// �Ҵ�� �޸� ���
	Fout->WriteLine("\nAllocated memory space : ");
	Fout->WriteLine(AllocatedList->GetTotalSize());
	Fout->WriteLine("\n");
	for(int m=1; m<=AllocatedList->GetTotalNodeCount(); m++)
	{
		Fout->WriteLine(m);
		Fout->WriteLine(" : ");
		Fout->WriteLine(AllocatedList->GetNode(m)->GetStartAdress());
		Fout->WriteLine(" - ");
		Fout->WriteLine(AllocatedList->GetNode(m)->GetStartAdress() + AllocatedList->GetNode(m)->GetSize() - 1);
		Fout->WriteLine("\n");
	}
	
	// Coalescing Ƚ�� ���
	Fout->WriteLine("\ncoalescing count : ");
	Fout->WriteLine(m_nCoalescingCount);
	
	// Allocation Failure Ƚ�� ���
	Fout->WriteLine("\nmemory alloction failure count : ");
	Fout->WriteLine(m_nFailureCount);
	Fout->WriteLine("\n\n\n\n");

	Fout->Close();  // ���� �ݱ�
}
