#pragma once
#include "BH_Node.h"
#include<iostream>
using namespace std;

struct Bnode{
};

class Bin_Heap{
private:
	struct BH_Node* root;

public:
	Bin_Heap(void);
	~Bin_Heap(void);

	int Insert(BH_Node *pNew);
};
