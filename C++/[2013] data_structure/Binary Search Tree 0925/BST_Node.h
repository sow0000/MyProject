#pragma once
#include "Child_Node.h"

class BST_Node{
private:
	char charData;
	int numData;
	Child_Node *pChildList;

public:
	BST_Node();
	BST_Node(char c, int n);
	virtual ~BST_Node();

	void setIntData(int n);
	void setCharData(char c);
	void setChildList(Child_Node *pNew);
	int getIntData();
	char getCharData();
	Child_Node* getChildList();
};
