#pragma warning(disable:4996)
#include "BST_Node.h"
#include<iostream>
#include<string.h>

BST_Node::BST_Node(){
	memset(firstName, NULL, 10);
	memset(lastName, NULL, 10);
	memset(phoneNum, NULL, 10);
	memset(address, NULL, 50);
	pChildList=NULL;
}

BST_Node::BST_Node(char* newFirstName, char* newLastName, char* newPhoneNum, char* newAddress){
	strcpy(firstName,newFirstName);
	strcpy(lastName,newLastName);
	strcpy(phoneNum,newPhoneNum);
	strcpy(address,newAddress);
	pChildList=NULL;
}

BST_Node::~BST_Node(){
	memset(firstName, NULL, 10);
	memset(lastName, NULL, 10);
	memset(phoneNum, NULL, 10);
	memset(address, NULL, 50);
	pChildList=NULL;
}

void BST_Node::setPhoneNum(char* newPhoneNum){ //Set phone number
	strcpy(phoneNum,newPhoneNum);
}

void BST_Node::setAddress(char* newAddress){ //Set address
	strcpy(address,newAddress);
}

void BST_Node::setChildList(Child_Node *pNew){ //set child list
	pChildList=pNew;
}

Child_Node* BST_Node::getChildList(){ //Return first name
	return pChildList;
}

char* BST_Node::getFirstName(){ //Return last name
	return firstName;
}

char* BST_Node::getLastName(){ //Return phone number
	return lastName;
}

char* BST_Node::getPhoneNum(){ //Return address
	return phoneNum;
}

char* BST_Node::getAddress(){ //return Child_Node
	return address;
}