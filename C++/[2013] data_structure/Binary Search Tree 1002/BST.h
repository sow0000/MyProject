#pragma once
#include "BST_Node.h"
#include "Child_Node.h"
#include "FILE_IO.h"
#include<fstream>

class BST : public FILE_IO{
private:
	BST_Node *root; //root Node


public:
	BST(); //Constructor
	virtual ~BST(); //Destructor
	bool Insert(char* firstName, char* lastName, char* newPhoneNum, char* newAddress); //Make new Node and insert into Tree
	bool Delete(char* firstName, char* lastName, char* subKey); //Delete Node
	bool Update(char* firstName, char* lastName, char* subKey, char* newPhoneNum, char* newAddress); //Udpate Node
	void MoveChildList(Child_Node *&pChWalker, BST_Node *&pWalker, int num); //Move to child node
	void MoveChildList(Child_Node *&pChWalker, Child_Node *&pPostChild, BST_Node *&pWalker, int num); //Move to child node with saving post child node
	bool Print(); //Print data of all node
	bool Print(char* lastName); //Print data of all node last-name-matched node
	bool Print(char* firstName, char* lastName, char* subKey); //Print data of name-matched node
	BST_Node* Search(char* firstName, char* lastName, char* subKey); //Search and return matched Node
	bool SearchOverlap(char* firstName, char* lastName); //Search overlapped node
};
