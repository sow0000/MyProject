#include "BinMinNode.h"

BinMinNode::BinMinNode(){
	pData=0;
	Degree=0;
	pBNext=0;
	pChild=0;
}

BinMinNode::BinMinNode(Edge *pNew){
	pData=pNew;
	Degree=0;
	pBNext=0;
	pChild=0;
}

BinMinNode::~BinMinNode(){
	pData=0;
	Degree=0;
	pBNext=0;
	pChild=0;
}

void BinMinNode::reset(){
	Degree=0;
	pBNext=0;
	pChild=0;
}

void BinMinNode::addDegree(){
	Degree++; //add degree
}

void BinMinNode::setBNext(BinMinNode *pNode){
	pBNext=pNode; //set next sibling node
}

void BinMinNode::setChild(BinMinNode *pNode){
	pChild=pNode; //set child node
}

int BinMinNode::getWeight(){
	return pData->getWeight(); //return data
}

int BinMinNode::getDegree(){
	return Degree; //return degree
}

Edge* BinMinNode::getEdge(){
	return pData; //return edge
}

BinMinNode* BinMinNode::getBNext(){
	return pBNext; //return next sibling node
}

BinMinNode* BinMinNode::getChild(){
	return pChild; //return child node
}
