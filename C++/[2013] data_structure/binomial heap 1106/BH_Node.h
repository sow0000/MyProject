#pragma once

class BH_Node{
private:
	int value;
	int degree;
	BH_Node *pNext;
	BH_Node *pChild;

public:
	BH_Node(void);
	BH_Node(int value);
	~BH_Node(void);

	setValue(int num);
	addDgree(int num);
	setNext(BH_Node *pNode);
	setChild(BH_Node *pChild);
};
