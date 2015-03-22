///////////////////////////////////////////////////////////////////////////////
// File Name      : bintree.h
// Date(Modify)   : 2005. 12. 9
// Compiler       : g++ 2.9.6
// OS             : Redhat Linux 7.1
// Author         : 김태형
// StudentID      : 2000120007
// ============================================================================
// Version        : 1.0.0
// Description    : Binomial Heaps 구조를 이용하여 노드를 삽입 및 삭제 (정의)
// Etc            : Data Structure Assignment 3
///////////////////////////////////////////////////////////////////////////////

#include "binnode.h"

#ifndef __CBINTREE_H__
#define __CBINTREE_H__

class CBinTree
{
public:
	CBinTree();  // 기본 생성자
	~CBinTree();  // 기본 소멸자
	// 노드를 Binomial Tree에 삽입
	void Insert(CBinNode * BinNode);
	// Binomial Tree의 Max 노드(Max Memory Block Size)를 Tree에서 제거 및 반환
	CBinNode ** DeleteMax(CBinNode* & BinNode);
	// 두개의 Binomial Tree를 합친 뒤 합친 Tree의 Max 노드 반환
	CBinNode * JoinTrees(CBinNode * PriNode, CBinNode * SecNode);
	// 두개의 Binomial Tree 중 루트가 작은 Tree를 큰 트리의 자식의 형제로 연결
	CBinNode * LinkBrother(CBinNode * BigNode, CBinNode * SmallNode);
	// pMaxNode의 크기를 반환
	int GetMaxNodeSize();

private:
	CBinNode * pMaxNode;  // Binomial Tree의 Max 노드
	CBinNode ** ATreeList;  // Tree 내 노드를 저장할 배열
};

#endif	//#define __CBINTREE_H__
