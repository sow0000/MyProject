#pragma once
#include "Child_Node.h"

typedef struct data{
	char firstName[10], lastName[10], phoneNum[10], address[50]; //Data of Node
}Data;

class AVL_Node{
private:
	Data nodeData; //Data of Node
	int bf_Name; //name balance factor
	int bf_Phone; //phone number balance factor
	Child_Node *pChildList; //Pointer for child list

public:
	AVL_Node(); //Constructor
	AVL_Node(char* newFirstName, char* newLastName, char* newPhoneNum, char* newAddress); //Constructor with data
	virtual ~AVL_Node(); //Destructor

	void setPhoneNum(char* newPhoneNum); //Set phone number
	void setAddress(char* newAddress); //Set address
	void setNameFactor(int newFactor); //Set name balance factor
	void setPhoneFactor(int newFactor); //Set phone number balance factor
	void setChild(int num, AVL_Node *pNew); //Set child
	int compareName(AVL_Node *pNode); //compare name data
	int compareName(char* firstName, char* lastName, char* phoneNum); //compare name data
	int getNameFactor(); //Return name balance factor
	int getPhoneFactor(); //Return phone number balance factor 
	char* getFirstName(); //Return first name
	char* getLastName(); //Return last name
	char* getPhoneNum(); //Return phone number
	char* getAddress(); //Return address
	AVL_Node* getChild(int num); //return child
};
