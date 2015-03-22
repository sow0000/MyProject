#include "BST_Node.h"

class BST
{
private:
	BST_Node *root;

public:
	BST();
	virtual ~BST();
	bool Insert(char ch);
	void Print();
	void PrintChar(BST_Node *CurrentNode);
	bool Search(char ch);
};
