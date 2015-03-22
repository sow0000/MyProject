#pragma once
#include<string.h>
#include<iostream>
using namespace std;

class BinMaxNode{
private:
	int range; //range
	int cost; //cost
	int profit; //rental profit
	int Degree; //degree
	char ispName[20]; //isp name
	BinMaxNode *pBNext; //next node in binomial list
	BinMaxNode *pChild; //child node in binomial list

public:
	BinMaxNode();
	BinMaxNode(int newRange, int newCost, char *newName);
	~BinMaxNode();

	void setProfit(int num); //set profit
	void reset(); //reset node in binomial heap
	void addDegree(); //add degree
	void setBNext(BinMaxNode *pNode); //set next sibling node
	void setChild(BinMaxNode *pCNode); //set child node
	int getRange(); //get range
	int getProfit(); //get profit
	int getDegree(); //get degree
	char* getName(); //get isp name
	BinMaxNode* getBNext(); //get next sibling node
	BinMaxNode* getChild(); //get child node
};