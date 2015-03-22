#pragma once
#include "BinTreeNode.h"
#include<string.h>

class AllocationList{
private:
	BinTreeNode** pSegHead; //segment head
	int TotalSize; //total size
	int Partition; //partition number

public:
	AllocationList(); //constructor
	~AllocationList(); //destructor

	void setTotalSize(int size, int partition); //set total size and partition number
	void setPartition(BinTreeNode *pNode); //set segment head
	bool Check(BinTreeNode *pMax, int newSize); //check allocatable
	BinTreeNode* Insert(BinTreeNode *pMax, int newIndex, int newSize); //allocate node
	BinTreeNode* Delete(int num); //delete node
	bool CanCoalescing(); //check coalescing
	void Coalescing(); //coalescing
	BinTreeNode* getNode(BinTreeNode* pNode); //get next node of pNode
	int getTotalSize(); //get total size
};
