#pragma once
#include "Child_Node.h"

class AVL_Node{
private:
	int num, bFactor; //Data of Node
	Child_Node *pChildList; //Pointer for child list

public:
	AVL_Node(); //Constructor
	AVL_Node(int newNum); //Constructor with data
	virtual ~AVL_Node(); //Destructor

	void setNum(int newNum); //Set phone number
	void setFactor(int newFactor); //Set balance factor
	void setChild(int num, AVL_Node *pNew); //Set left child
	int getNum(); //Return phone number
	int getFactor(); //Return balance factor
	Child_Node* getChildList(); //return Child_Node
	AVL_Node* getChild(int num); //return child
};
