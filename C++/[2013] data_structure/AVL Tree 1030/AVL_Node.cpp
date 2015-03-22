#pragma warning(disable:4996)
#include "AVL_Node.h"
#include<iostream>
#include<string.h>

AVL_Node::AVL_Node(){
	memset(nodeData.firstName, NULL, 10);
	memset(nodeData.lastName, NULL, 10);
	memset(nodeData.phoneNum, NULL, 10);
	memset(nodeData.address, NULL, 50);
	bf_Name=0;
	bf_Phone=0;
	pChildList=NULL;
}

AVL_Node::AVL_Node(char* newFirstName, char* newLastName, char* newPhoneNum, char* newAddress){
	strcpy(nodeData.firstName,newFirstName);
	strcpy(nodeData.lastName,newLastName);
	strcpy(nodeData.phoneNum,newPhoneNum);
	strcpy(nodeData.address,newAddress);
	bf_Name=0;
	bf_Phone=0;
	pChildList=NULL;
}

AVL_Node::~AVL_Node(){
	memset(nodeData.firstName, NULL, 10);
	memset(nodeData.lastName, NULL, 10);
	memset(nodeData.phoneNum, NULL, 10);
	memset(nodeData.address, NULL, 50);
	bf_Name=0;
	bf_Phone=0;
	pChildList=NULL;
}

void AVL_Node::setPhoneNum(char* newPhoneNum){ //Set phone number
	strcpy(nodeData.phoneNum,newPhoneNum);
}

void AVL_Node::setAddress(char* newAddress){ //Set address
	strcpy(nodeData.address,newAddress);
}

void AVL_Node::setNameFactor(int newFactor){ //Set name balance factor
	bf_Name=newFactor;
}

void AVL_Node::setPhoneFactor(int newFactor){ //Set phone number balance factor
	bf_Phone=newFactor;
}

void AVL_Node::setChild(int num, AVL_Node *pNew){ //Set child
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

int AVL_Node::compareName(AVL_Node *pNode){ //compare name data
	int num=strcmp(nodeData.lastName, pNode->getLastName());

	if(num==0){
		num=strcmp(nodeData.firstName, pNode->getFirstName());
		if(num==0){
			if(pNode->getPhoneNum()){
				return strcmp(nodeData.phoneNum, pNode->getPhoneNum());
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

int AVL_Node::compareName(char* firstName, char* lastName, char* phoneNum){ //compare name data
	int num=strcmp(nodeData.lastName,lastName);

	if(num==0){
		num=strcmp(nodeData.firstName, firstName);
		if(num==0){
			if(phoneNum){
				return strcmp(nodeData.phoneNum, phoneNum);
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

int AVL_Node::getNameFactor(){ //Return name balance factor
	return bf_Name;
}

int AVL_Node::getPhoneFactor(){ //Return phone number balance factor
	return bf_Phone;
}

char* AVL_Node::getFirstName(){ //Return first name
	return nodeData.firstName;
}

char* AVL_Node::getLastName(){ //Return last name
	return nodeData.lastName;
}

char* AVL_Node::getPhoneNum(){ //Return phone number
	return nodeData.phoneNum;
}

char* AVL_Node::getAddress(){ //Return address
	return nodeData.address;
}

AVL_Node* AVL_Node::getChild(int num){ //return child
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