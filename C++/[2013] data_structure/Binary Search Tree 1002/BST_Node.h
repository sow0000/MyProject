#pragma once
#include "Child_Node.h"

class BST_Node{
private:
	char firstName[10], lastName[10], phoneNum[10], address[50]; //Data of Node
	Child_Node *pChildList; //Pointer for child list

public:
	BST_Node(); //Constructor
	BST_Node(char* newFirstName, char* newLastName, char* newPhoneNum, char* newAddress); //Constructor with data
	virtual ~BST_Node(); //Destructor

	void setPhoneNum(char* newPhoneNum); //Set phone number
	void setAddress(char* newAddress); //Set address
	void setChildList(Child_Node *pNew); //set child list
	char* getFirstName(); //Return first name
	char* getLastName(); //Return last name
	char* getPhoneNum(); //Return phone number
	char* getAddress(); //Return address
	Child_Node* getChildList(); //return Child_Node
};
