#include "BinTreeNode.h"

BinTreeNode::BinTreeNode(){ //constructor
	Seg=0;
	Index=0;
	Saddr=0;
	Size=0;
	Flag=0;
	Degree=0;
	pNext=0;
	pBNext=0;
	pChild=0;
}

BinTreeNode::BinTreeNode(int newSeg, int newIndex, int newSaddr, int newSize){ //constructor with value
	Seg=newSeg;
	Index=newIndex;
	Saddr=newSaddr;
	Size=newSize; 
	Flag=0;
	Degree=0;
	pNext=0;
	pBNext=0;
	pChild=0;
}

BinTreeNode::~BinTreeNode(){ //desturctor
}

void BinTreeNode::reset(){ //reset node in binomial heap
	Degree=0;
	pBNext=0;
	pChild=0;
}

void BinTreeNode::addDegree(){
	Degree++; //add degree
}

void BinTreeNode::setSeg(int num){
	Seg=num; //set segment
}

void BinTreeNode::setIndex(int num){
	Index=num; //set index
}

void BinTreeNode::setAddress(int num){
	Saddr=num; //set start address
}

void BinTreeNode::setSize(int num){
	Size=num; //set size
}

void BinTreeNode::setFlag(int num){
	Flag=num; //set flag
}

void BinTreeNode::setNext(BinTreeNode *pNode){
	pNext=pNode; //set next node
}

void BinTreeNode::setBNext(BinTreeNode *pNode){
	pBNext=pNode; //set next sibling node
}

void BinTreeNode::setChild(BinTreeNode *pNode){
	pChild=pNode; //set child node
}

int BinTreeNode::getSeg(){
	return Seg; //return segment
}

int BinTreeNode::getIndex(){
	return Index; //return index
}

int BinTreeNode::getAddress(){
	return Saddr; //return start address
}

int BinTreeNode::getSize(){
	return Size; //return size
}

int BinTreeNode::getFlag(){
	return Flag; //return flag
}

int BinTreeNode::getDegree(){
	return Degree; //return degree
}

BinTreeNode* BinTreeNode::getNext(){
	return pNext; //return next node
}

BinTreeNode* BinTreeNode::getBNext(){
	return pBNext; //return next sibling node
}

BinTreeNode* BinTreeNode::getChild(){
	return pChild; //return child node
}