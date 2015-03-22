///////////////////////////////////////////////////////////////////////////////
// File Name      : memoryallocator.cpp
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : 김태형
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : 메모리를 B-Tree를 이용하여 할당 및 해제하고
//                  메모리 할당 상태를 출력 (구현)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include "memoryallocator.h"




///////////////////////////////////////////////////////////////////////////////
// Function : CMemoryAllocator::CMemoryAllocator()
//=============================================================================
// Input    : 없음
// Output   : 없음
// Purpose  : 기본 생성자(멤버변수 초기화)
///////////////////////////////////////////////////////////////////////////////
CMemoryAllocator::CMemoryAllocator()
{
	Fin = new CFile();  // Fin 생성
	Fout = new CFile();  // Fout 생성
	BinTree = new CBinTree();  // Binomial Tree 생성
	AllocatedList = new CLinkedList();  // 할당된 Memory List 생성
	AvailableList = new CLinkedList();  // 비할당된 Memory List 생성

	m_nTotalMBSize = 0;  // 전체 Memory Block의 크기
	m_nCoalescingCount = 0;  // Memory Coalescing 횟수
	m_nFailureCount = 0;  // Memory Allocation Failure 횟수
	m_nCheck = 0;  // 파일 쓰기상태 체크
}




///////////////////////////////////////////////////////////////////////////////
// Function : CMemoryAllocator::~CMemoryAllocator()
//=============================================================================
// Input    : 없음
// Output   : 없음
// Purpose  : 기본 소멸자(할당된 객체 해제)
///////////////////////////////////////////////////////////////////////////////
CMemoryAllocator::~CMemoryAllocator()
{
	delete Fin;  // File 제거
	delete Fout;  // File 제거
	delete BinTree;  // Binomial Tree 제거
	delete AllocatedList;  // 할당된 Memory List 제거
	delete AvailableList;  // 비할당된 Memory List 제거
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CMemoryAllocator::Run()
//=============================================================================
// Input    : 없음
// Output   : 없음
// Purpose  : 파일에서 레코드를 읽어와서 command에 따라 서브함수 호출
///////////////////////////////////////////////////////////////////////////////
void CMemoryAllocator::Run()
{
	char * szBuffer = 0;  // 파일에서 읽은 문자열(레코드)
	char * szCommand = 0;  // 문자열(레코드)의 첫번째 토큰(command)
	char * szIndex = 0;  // 문자열(레코드)의 두번째 토큰(Memory Block Index)
	char * szSize = 0;  // 문자열(레코드)의 세번째 토큰(Memory Block Size)
	
	int nIndex, nSize;  // Memory Block의 index와 크기의 정수형
	int nLine = 0;  // 파일의 줄 수
	

	Fin->Open("scenario.in", ios::in);  // 파일 열기

	// 파일을 다 읽을 때 까지 반복
	while(szBuffer = Fin->ReadLine())
	{
		nLine++;  // 파일의 줄 수 증가

		// 파일의 첫번째 문자열인 Total Memory Space를 저장
		if(nLine == 1)
		{
			szSize = strtok(szBuffer, " \t\r\n");
			nSize = atoi(szSize);
			m_nTotalMBSize = nSize;

			// 초기 노드의 index는 0, 시작주소는 0, 크기는 nSize임
			CBinNode * BinNode = new CBinNode(0, 0, nSize);

			// 비할당 Memory 리스트에 삽입
			AvailableList->Insert(BinNode);

			// 노드를 BinTree에 삽입
			BinTree->Insert(BinNode);

			continue;
		}

		// 레코드의 첫번째 토큰(command)을 저장
		szCommand = strtok(szBuffer, " \t\r\n");
		
		//////////////////////
		// 메모리 할당 명령 //
		//////////////////////
		if(strcmp(szCommand, "A") == 0 || strcmp(szCommand, "a") == 0)
		{
			// Memory Block의 index와 크기를 얻어옴
			szIndex = strtok(NULL, " \t\r\n");
			nIndex = atoi(szIndex);
			szSize = strtok(NULL, " \r\r\n");
			nSize = atoi(szSize);

			// 메모리 할당
			AllocateMemory(nIndex, nSize);
		}
		//////////////////////
		// 메모리 해제 명령 //
		//////////////////////
		else if(strcmp(szCommand, "F") == 0 || strcmp(szCommand, "f") == 0)
		{
			// Memory Block의 index 얻어옴
			szIndex = strtok(NULL, " \t\r\n");
			nIndex = atoi(szIndex);

			// 메모리 해제
			FreeMemory(nIndex);
		}
		///////////////////////////
		// 메모리 할당 상태 출력 //
		///////////////////////////
		else if(strcmp(szCommand, "S") == 0 || strcmp(szCommand, "s") == 0)
		{
			// 메모리 할당상태 출력
			WriteMemoryState();
		}
		///////////////
		// 예외 처리 //
		///////////////
		else
		{
			cout << "파일의 " << nLine << "번째 줄이 올바른 입력 형식이 아닙니다.\n";
		}
	}

	Fin->Close();  // 파일 닫기
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CMemoryAllocator::AllocateMemory(int nIndex, int nSize)
//=============================================================================
// Input    : 메모리 index와 크기
// Output   : 없음
// Purpose  : 해당 index와 크기를 가지는 메모리 생성
///////////////////////////////////////////////////////////////////////////////
void CMemoryAllocator::AllocateMemory(int nIndex, int nSize)
{
	///////////////////////////////////////////////////////////////
	// 새롭게 할당할 노드가 Max노드에 할당될 수 있는지 확인
	// 할당될 공간이 없으면, coalescing할 수 있는 메모리의 크기 확인
	// 만약 coalescing 했을 경우에 할당이 가능하다면 coalescing 실시
	// coalescing 실시된 노드에 할당을 함
	////////////////////////////////////////////////////////////////

	int nStartAdress;  // 노드의 시작주소

	// 할당할 메모리가 BinTree의 Max노드보다 크면
	if(nSize > BinTree->GetMaxNodeSize())
	{
		// 비할당된 메모리의 총 크기보다 크면 할당 실패
		if(nSize > AvailableList->GetTotalSize())
		{
			m_nFailureCount++;
			return;
		}
		// 비할당된 메모리의 총 크기보다 작으면 Coalescing 실시
		else
		{
			CoalescingMemory();
			m_nCoalescingCount++;
		}
	}

	// Coalescing을 실시했음에도 Max노드보다 할당할 메모리가 크면 할당 실패
	if(nSize > BinTree->GetMaxNodeSize())
	{
		m_nFailureCount++;
		return;
	}

	// BinTree의 Max 노드를 꺼냄
	CBinNode * BinNode;
	BinNode = *BinTree->DeleteMax(BinNode);

	// Max 노드를 비할당 Memory 리스트에서도 꺼냄
	BinNode = AvailableList->Delete(BinNode->GetStartAdress(), 1);

	// Max 노드의 시작주소를 얻어옴
	nStartAdress = BinNode->GetStartAdress();
	
	// 할당된 노드 생성
	CBinNode * AllocatedNode = new CBinNode(nIndex, nStartAdress, nSize);
	
	// 할당된 노드를 할당 Memory 리스트에 연결
	AllocatedList->Insert(AllocatedNode);

	// 비할당된 노드의 시작주소(할당된 노드의 시작주소 + 크기)
	nStartAdress = nStartAdress + nSize;
	
	// 비할당된 노드의 크기(Max 노드의 크기 - 할당된 노드의 크기)
	nSize = BinNode->GetSize() - nSize;
	
	// 할당되고 남은 메모리의 크기가 0이 아니면 남은 공간에 비할당 메모리 생성
	if(nSize != 0)
	{
		// 비할당된 노드 생성
		CBinNode * AvailableNode = new CBinNode(0, nStartAdress, nSize);

		// 비할당된 노드를 비할당 Memory 리스트에 연결
		AvailableList->Insert(AvailableNode);

		// 비할당된 노드를 BinTree에 삽입
		BinTree->Insert(AvailableNode);
	}

	// Max노드 삭제
	delete BinNode;
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CMemoryAllocator::FreeMemory(int nIndex)
//=============================================================================
// Input    : 메모리 index
// Output   : 없음
// Purpose  : 해당 index에 해당하는 메모리 해제
///////////////////////////////////////////////////////////////////////////////
void CMemoryAllocator::FreeMemory(int nIndex)
{
	// 할당 리스트에서 해당 index에 해당하는 노드를 꺼냄
	CBinNode * BinNode = AllocatedList->Delete(nIndex, 0);

	// 노드가 없다면 해제 실패
	if(!BinNode)
	{
		cout << "해제할 메모리가 없습니다.\n";
		return;
	}

	// BinNode의 연결 포인터를 초기화 한 뒤 
	BinNode->Initialize();
	
	// 비할당 Memory 리스트에 연결
	AvailableList->Insert(BinNode);

	// BinTree에 삽입
	BinTree->Insert(BinNode);
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CMemoryAllocator::CoalescingMemory()
//=============================================================================
// Input    : 없음
// Output   : 없음
// Purpose  : 비할당된 메모리들 중 주소가 이어진 메모리들 병합
///////////////////////////////////////////////////////////////////////////////
void CMemoryAllocator::CoalescingMemory()
{
	// BinTree에 있는 노드 모두 꺼냄
	CBinNode * pTemp;
	while(BinTree->DeleteMax(pTemp)){}

	// AvailableList를 따라가면서 이어져있는 노드 합치기
	AvailableList->Coalescing();


	// AvailableList에 있는 노드 전부 BinTree에 삽입
	for(int n=1; n<=AvailableList->GetTotalNodeCount(); n++)
	{
		BinTree->Insert(AvailableList->GetNode(n));
	}
}




///////////////////////////////////////////////////////////////////////////////
// Function : void CMemoryAllocator::WriteMemoryState()
//=============================================================================
// Input    : 없음
// Output   : 없음
// Purpose  : 메모리 할당 및 비할당 상태 파일에 출력
///////////////////////////////////////////////////////////////////////////////
void CMemoryAllocator::WriteMemoryState()
{
	char szTemp[10] = {0};  // 문자열 임시 저장 변수

	if(m_nCheck == 0)
	{
		Fout->Open("result.out", ios::out);  // 파일 열기
		m_nCheck++;
	}
	else
		Fout->Open("result.out", ios::out | ios::app);  // 파일 이어쓰기 모드로 열기
	

	// 상단 메뉴 출력
	Fout->WriteLine("\nCurent Memory Allocation State\n");
	Fout->WriteLine("=================================\n");
	
	// 비할당된 메모리 출력
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

	// 할당된 메모리 출력
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
	
	// Coalescing 횟수 출력
	Fout->WriteLine("\ncoalescing count : ");
	Fout->WriteLine(m_nCoalescingCount);
	
	// Allocation Failure 횟수 출력
	Fout->WriteLine("\nmemory alloction failure count : ");
	Fout->WriteLine(m_nFailureCount);
	Fout->WriteLine("\n\n\n\n");

	Fout->Close();  // 파일 닫기
}
