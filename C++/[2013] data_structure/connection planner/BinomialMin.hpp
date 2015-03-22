#pragma once
#include "BinMinNode.h"
#include "BinomialHeap.hpp"

class BinomialMin : public BinomialHeap<BinMinNode>{
public:
	BinomialMin(){}
	~BinomialMin(){}
	
	bool Compare(BinMinNode *pNode1, BinMinNode *pNode2){
		return pNode1->getWeight()<pNode2->getWeight();
	}
};