#include "Child_Node.h"
#include <iostream>

Child_Node::Child_Node(){
	nodeNum=0;
	pChild=NULL;
	pNext=NULL;
}

Child_Node::Child_Node(BST_Node *child){
	nodeNum=0;
	pChild=child;
	pNext=NULL;
}

Child_Node::~Child_Node(){
	nodeNum=0;
	pChild=NULL;
	pNext=NULL;
}

void Child_Node::setChild(BST_Node *pNew){ //set Child_Node
	pChild=pNew;
}

void Child_Node::setNext(Child_Node *pNew){ //Set next Child_Node
	pNext=pNew;
}

void Child_Node::setNum(int num){ //Set nodeNum
	nodeNum=num;
}

BST_Node* Child_Node::getChild(){ //Return child BST_Node
	return pChild;
}

Child_Node* Child_Node::getNext(){ //Return next Child_Node
	return pNext;
}

int Child_Node::getNum(){ //Return nodeNum
	return nodeNum;
}