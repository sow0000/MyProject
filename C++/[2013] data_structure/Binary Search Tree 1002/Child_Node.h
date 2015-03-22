#pragma once
class BST_Node;

class Child_Node{
private:
	int nodeNum; //Relationship between parent Node and child Node
	BST_Node *pChild; //Pointer for child BST_Node
	Child_Node *pNext; //Pointer for next Child_Node

public:
	Child_Node(); //Constructor
	Child_Node(BST_Node *child); //Constructor with BST_Node
	virtual ~Child_Node(); //Destructor

	void setChild(BST_Node *pNew); //Set child BST_Node
	void setNext(Child_Node *pNew); //Set next Child_Node
	void setNum(int num); //Set nodeNum
	BST_Node* getChild(); //Return child BST_Node
	Child_Node* getNext(); //Return next Child_Node
	int getNum(); //Return nodeNum
};
