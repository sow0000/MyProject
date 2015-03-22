#pragma once
#include "BinTreeNode.h"
#include <string.h>

class BinomialHeap{
private:
	BinTreeNode* root; //max node
	BinTreeNode** treeQueue; //array for join
	int totalSize; //total size

public:
	BinomialHeap(); //constructor
	~BinomialHeap(); //destructor

	bool Insert(BinTreeNode *pNew); //insert not allocated node
	BinTreeNode* Delete(); //delete node
	bool DeleteAll(); //delete all node
	BinTreeNode* Join(BinTreeNode *pNode1, BinTreeNode *pNode2); //combine two nodes that same degree
	BinTreeNode* getMax(); //get max node
	int getTotalSize(); //get total size
};
