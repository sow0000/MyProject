#pragma warning(disable:4996)
#pragma once
#include "Child_Node.h"
#include<iostream>
#include<string.h>

typedef struct name{}Name; //Key of Name

typedef struct phone{} Phone; //Key of Phone

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
	AVL_Node(){ //Constructor
	memset(nodeData.firstName, NULL, 10);
	memset(nodeData.lastName, NULL, 10);
	memset(nodeData.phoneNum, NULL, 10);
	memset(nodeData.address, NULL, 50);
	bf_Name=0;
	bf_Phone=0;
	pChildList=NULL;
}

	AVL_Node(char* newFirstName, char* newLastName, char* newPhoneNum, char* newAddress){ //Constructor with data
	strcpy(nodeData.firstName,newFirstName);
	strcpy(nodeData.lastName,newLastName);
	strcpy(nodeData.phoneNum,newPhoneNum);
	strcpy(nodeData.address,newAddress);
	bf_Name=0;
	bf_Phone=0;
	pChildList=NULL;
}

	~AVL_Node(){ //Destructor
	memset(nodeData.firstName, NULL, 10);
	memset(nodeData.lastName, NULL, 10);
	memset(nodeData.phoneNum, NULL, 10);
	memset(nodeData.address, NULL, 50);
	bf_Name=0;
	bf_Phone=0;
	pChildList=NULL;
}

	void setPhoneNum(char* newPhoneNum){ //Set phone number
	strcpy(nodeData.phoneNum,newPhoneNum);
}

	void setAddress(char* newAddress){ //Set address
	strcpy(nodeData.address,newAddress);
}

	template<class k>
	void setFactor(int newFactor); //Set balance factor

	template<class k>
	void setChild(int num, AVL_Node *pNew); //Set child

	template<class k>
	int compare(Data d); //compare name data
	template<class k>
	int compare(char* firstName, char* lastName, char* phoneNum); //compare name data
	template<class k>
	int getFactor(); //Return name balance factor
	char* getFirstName(){ //Return first name
		return nodeData.firstName;
	}

	char* getLastName(){ //Return last name
		return nodeData.lastName;
	}
	char* getPhoneNum(){ //Return phone number
		return nodeData.phoneNum;
	}
	char* getAddress(){ //Return address
		return nodeData.address;
	}

	template<class k>
	AVL_Node* getChild(int num); //return child
};

template<>
void AVL_Node::setFactor<Name>(int newFactor){ //Set name balance factor
	bf_Name=newFactor;
}

template<>
void AVL_Node::setFactor<Phone>(int newFactor){ //Set phone number balance factor
	bf_Phone=newFactor;
}

template<>
void AVL_Node::setChild<Name>(int num, AVL_Node *pNew){ //Set child
	Child_Node *pChWalker=pChildList;
	Child_Node *pChPast=NULL;

	while(pChWalker){ //find same numbered child
		if(pChWalker->getNum()!=num){
			pChPast=pChWalker;
			pChWalker=pChWalker->getNext();
		}
		else{
			break;
		}
	}

	if(pNew&&pChWalker){ //if same numbered child in
		pChWalker->setChild(pNew);
	}
	else if(pNew){ //if no same numbered child
		Child_Node *pNewChild=new Child_Node(num, pNew);

		if(!pChildList){ //if no child
			pChildList=pNewChild;
		}
		else{ //if already child in
			pChWalker=pChildList;
			while(pChWalker->getNext()){
				pChWalker=pChWalker->getNext();
			}
			pChWalker->setNext(pNewChild);
		}
	}
	else if(pChWalker){ //delete Child_Node
		if(pChWalker==pChildList){
			pChildList=pChWalker->getNext();
			delete pChWalker;
		}
		else{
			pChPast->setNext(pChWalker->getNext());
			delete pChWalker;
		}
	}
}

template<>
void AVL_Node::setChild<Phone>(int num, AVL_Node *pNew){ //Set child
	setChild<Name>(num+2, pNew);
}

template<>
int AVL_Node::compare<Name>(Data d){ //compare name data
	int num=strcmp(nodeData.lastName, d.lastName);

	if(num==0){
		num=strcmp(nodeData.firstName, d.firstName);
		if(num==0){
			if(*d.phoneNum){
				return strcmp(nodeData.phoneNum, d.phoneNum);
			}
			else{
				return 0;
			}
		}
		else{
			return num;
		}
	}

	return num;
}

template<>
int AVL_Node::compare<Phone>(Data d){ //compare name data
	return strcmp(nodeData.phoneNum, d.phoneNum);
}

template<>
int AVL_Node::getFactor<Name>(){ //Return name balance factor
	return bf_Name;
}

template<>
int AVL_Node::getFactor<Phone>(){ //Return phone number balance factor
	return bf_Phone;
}

template<>
AVL_Node* AVL_Node::getChild<Name>(int num){ //return child
	Child_Node* pChWalker=pChildList;

	while(pChWalker){
		if(pChWalker->getNum()!=num){
			pChWalker=pChWalker->getNext();
		}
		else{
			return pChWalker->getChild();
		}
	}
	return NULL;
}

template<>
AVL_Node* AVL_Node::getChild<Phone>(int num){ //return child
	return getChild<Name>(num+2);
}