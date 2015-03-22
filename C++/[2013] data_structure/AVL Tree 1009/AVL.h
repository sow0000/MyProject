#pragma once
#include "AVL_Node.h"
#include "Child_Node.h"
#include<fstream>

class AVL{
private:
	AVL_Node *root; //root Node

public:
	AVL(); //Constructor
	virtual ~AVL(); //Destructor

	bool Insert(int newNum); //Make new Node and insert into Tree
	bool Print(); //Print data of all node
};