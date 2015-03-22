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

void Child_Node::setChild(BST_Node *pNew){
	pChild=pNew;
}

void Child_Node::setNext(Child_Node *pNew){
	pNext=pNew;
}

void Child_Node::setNum(int num){
	nodeNum=num;
}

BST_Node* Child_Node::getChild(){
	return pChild;
}

Child_Node* Child_Node::getNext(){
	return pNext;
}

int Child_Node::getNum(){
	return nodeNum;
}