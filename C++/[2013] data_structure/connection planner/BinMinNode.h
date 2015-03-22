#pragma once
#include "Edge.h"

class BinMinNode{
private:
	Edge *pData;
	int Degree; //degree
	BinMinNode *pBNext; //next node in binomial list
	BinMinNode *pChild; //child node in binomial list

public:
	BinMinNode(); //constructor
	BinMinNode(Edge *pNew); //constructor
	~BinMinNode(); //destructor

	void reset(); //reset node in binomial heap
	void addDegree(); //add degree
	void setBNext(BinMinNode *pNode); //set next sibling node
	void setChild(BinMinNode *pCNode); //set child node
	int getWeight(); //get edge data
	int getDegree(); //get degree
	Edge* getEdge(); //get edge
	BinMinNode* getBNext(); //get next sibling node
	BinMinNode* getChild(); //get child node
};