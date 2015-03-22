#include "BST_Node.h"
#include <iostream>

BST_Node::BST_Node(){
	charData='0';
	numData=0;
	pChildList=NULL;
}

BST_Node::BST_Node(char c, int n){
	charData=c;
	numData=n;
	pChildList=NULL;
}

BST_Node::~BST_Node(){
	charData='0';
	numData=0;
	pChildList=NULL;
}

void BST_Node::setIntData(int n){
	numData=n;
}

void BST_Node::setCharData(char c){
	charData=c;
}

void BST_Node::setChildList(Child_Node *pNew){
	pChildList=pNew;
}

int BST_Node::getIntData(){
	return numData;
}

char BST_Node::getCharData(){
	return charData;
}

Child_Node* BST_Node::getChildList(){
	return pChildList;
}