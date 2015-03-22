#pragma once
class AVL_Node;

class Child_Node{
private:
	int nodeNum; //Relationship between parent Node and child Node
	AVL_Node *pChild; //Pointer for child AVL_Node
	Child_Node *pNext; //Pointer for next Child_Node

public:
	Child_Node(); //Constructor
	Child_Node(int num, AVL_Node *child); //Constructor with AVL_Node
	virtual ~Child_Node(); //Destructor

	void setChild(AVL_Node* pNew); //Set new AVL_Node
	void setNext(Child_Node *pNew); //Set next Child_Node
	void setNum(int num); //Set nodeNum
	AVL_Node* getChild(); //Return child AVL_Node
	Child_Node* getNext(); //Return next Child_Node
	int getNum(); //Return nodeNum
};
