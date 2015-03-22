///////////////////////////////////////////////////////////////////////////////
// File Name      : bintree.h
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

#include "binnode.h"

#ifndef __CBINTREE_H__
#define __CBINTREE_H__

class CBinTree
{
public:
	CBinTree();  // �⺻ ������
	~CBinTree();  // �⺻ �Ҹ���
	// ��带 Binomial Tree�� ����
	void Insert(CBinNode * BinNode);
	// Binomial Tree�� Max ���(Max Memory Block Size)�� Tree���� ���� �� ��ȯ
	CBinNode ** DeleteMax(CBinNode* & BinNode);
	// �ΰ��� Binomial Tree�� ��ģ �� ��ģ Tree�� Max ��� ��ȯ
	CBinNode * JoinTrees(CBinNode * PriNode, CBinNode * SecNode);
	// �ΰ��� Binomial Tree �� ��Ʈ�� ���� Tree�� ū Ʈ���� �ڽ��� ������ ����
	CBinNode * LinkBrother(CBinNode * BigNode, CBinNode * SmallNode);
	// pMaxNode�� ũ�⸦ ��ȯ
	int GetMaxNodeSize();

private:
	CBinNode * pMaxNode;  // Binomial Tree�� Max ���
	CBinNode ** ATreeList;  // Tree �� ��带 ������ �迭
};

#endif	//#define __CBINTREE_H__
