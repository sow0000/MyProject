#pragma once

class BinTreeNode{
private:
	int Seg; //segment
	int Index; //index
	int Saddr; //start address
	int Size; //memory size
	int Flag; //flag
	int Degree; //degree
	BinTreeNode *pNext; //next node in allocation list
	BinTreeNode *pBNext; //next node in binomial list
	BinTreeNode *pChild; //child node in binomial list

public:
	BinTreeNode(); //constructor
	BinTreeNode(int newSeg, int newIndex, int newSaddr, int newSize); //constructor with value
	~BinTreeNode(); //destructor

	void reset(); //reset node in binomial heap
	void addDegree(); //add degree
	void setSeg(int num); //set segment
	void setIndex(int num); //set index
	void setAddress(int num); //set start address
	void setSize(int num); //set size
	void setFlag(int num); //set flag
	void setNext(BinTreeNode *pNode); //set next node
	void setBNext(BinTreeNode *pNode); //set next sibling node
	void setChild(BinTreeNode *pCNode); //set child node
	int getSeg(); //get segment
	int getIndex(); //get index
	int getAddress(); //get address
	int getSize(); //get size
	int getFlag(); //get flag
	int getDegree(); //get degree
	BinTreeNode* getNext(); //get next node
	BinTreeNode* getBNext(); //get next sibling node
	BinTreeNode* getChild(); //get child node
};