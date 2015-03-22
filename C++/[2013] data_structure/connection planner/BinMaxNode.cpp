#include "BinMaxNode.h"

BinMaxNode::BinMaxNode(){
	range=0;
	cost=0;
	profit=0;
	Degree=0;
	pBNext=0;
	pChild=0;
	memset(ispName, 0, 20);
}

BinMaxNode::BinMaxNode(int newRange, int newCost, char *newName){
	range=newRange;
	cost=newCost;
	profit=0;
	Degree=0;
	pBNext=0;
	pChild=0;
	strcpy(ispName, newName);
}

BinMaxNode::~BinMaxNode(){
	Degree=0;
	pBNext=0;
	pChild=0;
	memset(ispName, 0, 20);
}

void BinMaxNode::reset(){
	Degree=0;
	pBNext=0;
	pChild=0;
}

void BinMaxNode::setProfit(int num){
	profit=cost-num;
}

void BinMaxNode::addDegree(){
	Degree++; //add degree
}

void BinMaxNode::setBNext(BinMaxNode *pNode){
	pBNext=pNode; //set next sibling node
}

void BinMaxNode::setChild(BinMaxNode *pNode){
	pChild=pNode; //set child node
}

int BinMaxNode::getRange(){
	return range; //return range
}

int BinMaxNode::getProfit(){
	return profit; //return profit
}

int BinMaxNode::getDegree(){
	return Degree; //return degree
}

char* BinMaxNode::getName(){
	return ispName; //return isp name
}

BinMaxNode* BinMaxNode::getBNext(){
	return pBNext; //return next sibling node
}

BinMaxNode* BinMaxNode::getChild(){
	return pChild; //return child node
}