#pragma warning(disable:4996)
#include "AVL_Node.h"
#include<iostream>
#include<string.h>

AVL_Node::AVL_Node(){
	num=0;
	bFactor=0;
	pChildList=NULL;
}

AVL_Node::AVL_Node(int newNum){
	num=newNum;
	bFactor=0;
	pChildList=NULL;
}

AVL_Node::~AVL_Node(){
	num=0;
	bFactor=0;
	pChildList=NULL;
}

void AVL_Node::setNum(int newNum){ //Set number
	num=newNum;
}

void AVL_Node::setFactor(int newFactor){ //Set Factor
	bFactor=newFactor;
}

void AVL_Node::setChild(int num, AVL_Node *pNew){ //Set child
	Child_Node *pChWalker=pChildList;
	Child_Node *pChPast=NULL;

	while(pChWalker){
		if(pChWalker->getNum()!=num){
			pChPast=pChWalker;
			pChWalker=pChWalker->getNext();
		}
		else{
			break;
		}
	}

	if(pNew&&pChWalker){
		pChWalker->setChild(pNew);
	}
	else if(pNew){
		Child_Node *pNewChild=new Child_Node(num, pNew);

		if(!pChildList){ //if no child
			pChildList=pNewChild;
		}
		else{ //if already child in
			pChildList->setNext(pNewChild);
		}
	}
	else if(pChWalker){
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

int AVL_Node::getNum(){ //return number
	return num;
}

int AVL_Node::getFactor(){ //return balance factor
	return bFactor;
}

Child_Node* AVL_Node::getChildList(){ //return Child_Node
	return pChildList;
}

AVL_Node* AVL_Node::getChild(int num){ //return Node
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