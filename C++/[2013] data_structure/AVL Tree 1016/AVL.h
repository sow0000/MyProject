#pragma once
#include "AVL_Node.h"
#include "Child_Node.h"
#include<fstream>

class AVL{
private:
	AVL_Node* root_name; //name root Node
	AVL_Node* root_phone; //phone number root Node

public:
	AVL(); //Constructor
	virtual ~AVL(); //Destructor

	bool Insert(char* firstName, char* lastName, char* newPhoneNum, char* newAddress); //Make new Node and insert into name tree
	bool InsertName(AVL_Node* pNew); //insert into name tree
	bool InsertPhone(AVL_Node* pNew); //insert into phone number tree
	bool Delete(char* firstName, char* lastName); //Delete Node with name
	bool Delete(char* firstName, char* lastName, char* subKey); //Delete Node with name and sub key
	bool Delete(char* phoneNum); //Delete Node with phone number
	bool UpdateName(char* firstName, char* lastName, char* newPhoneNum, char* newAddress); //Udpate Node without subkey
	bool UpdateName(char* firstName, char* lastName, char* subKey, char* newPhoneNum, char* newAddress); //Udpate Node
	bool UpdatePhone(char* phoneNum, char* newAddress); //Udpate phone
	bool PrintAll(); //Print data of all node
	bool PrintName(char* lastName); //Print data of all node last-name-matched node
	bool PrintName(char* firstName, char* lastName); //Print name without sub key
	bool PrintName(char* firstName, char* lastName, char* subKey); //Print name
	bool PrintPhone(char* phoneNum); //Print phone
	bool SearchOverlap(char* firstName, char* lastName); //Search overlapped node
};