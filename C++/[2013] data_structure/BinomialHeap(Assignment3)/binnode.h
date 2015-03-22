///////////////////////////////////////////////////////////////////////////////
// File Name      : binnode.h
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : 김태형
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : Binomial Tree의 노드 (정의)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include <string.h>
#include <stdlib.h>
#include <iostream.h>

#ifndef __CBINNODE_H__
#define __CBINNODE_H__

class CBinNode
{
public:
	CBinNode();  // 기본 생성자
	// index와 시작 위치, 크기를 매개변수로 받는 Binomial Tree의 노드 생성
	CBinNode(const int nIndex, const int nPosition, const int nSize);
	~CBinNode();  // 기본 소멸자
	void Initialize();  // 노드 멤버변수 초기화
	int GetIndex();  // Memory Block의 index 반환
	int GetStartAdress();  // Memory Block의 시작 주소 반환
	int GetSize();  // Memory Block의 크기 반환
	friend class CBinTree;  // CBinTree 클래스를 프렌드로 선언
	friend class CLinkedList;  // CLinkedList 클래스를 프렌드로 선언

private:
	int m_nIndex;  // Memory Block의 index
	int m_nStartAdress;  // Memory Block의 시작 주소
	int m_nSize;  // Memory Block의 크기
	int m_nChildDegree;  // 노드의 자식 수

	CBinNode * pBrother;  // 노드의 형제를 연결
	CBinNode * pChild;  // 노드의 자식을 연결
	CBinNode * pNext;  // Linked List 구성시 다음 노드를 연결
};

#endif	//__CBINNODE_H__
