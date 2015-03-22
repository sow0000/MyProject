#pragma once
class BST_Node;

class Child_Node{
private:
	int nodeNum;
	BST_Node *pChild;
	Child_Node *pNext;

public:
	Child_Node();
	Child_Node(BST_Node *child);
	virtual ~Child_Node();

	void setChild(BST_Node *pNew);
	void setNext(Child_Node *pNew);
	void setNum(int num);
	BST_Node* getChild();
	Child_Node* getNext();
	int getNum();
};
