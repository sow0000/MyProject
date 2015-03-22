#pragma once
#include "BinMaxNode.h"
#include "BinomialHeap.hpp"

class BinomialMax : public BinomialHeap<BinMaxNode>{
public:
	BinomialMax(){}
	~BinomialMax(){}
	
	bool Compare(BinMaxNode *pNode1, BinMaxNode *pNode2){
		return pNode1->getProfit()>pNode2->getProfit();
	}
};