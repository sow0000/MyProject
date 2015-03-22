#pragma once
#include "BST_Node.h"
#include "Child_Node.h"

class BST
{
private:
	BST_Node *root;

public:
	BST();
	virtual ~BST();
	bool Insert(char ch, int n);
	bool Delete(char ch, int n);
	void MoveChildList(Child_Node *&pChWalker, BST_Node *&pWalker, int num);
	void MoveChildList(Child_Node *&pChWalker, Child_Node *&pPostChild, BST_Node *&pWalker, int num);
	void Print();
	void PrintChar(BST_Node *CurrentNode);
	BST_Node* Search(char ch, int n);
};
