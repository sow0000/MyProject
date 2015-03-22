#pragma once
#include "BinomialMin.hpp"
#include "WeightedGraph.h"

class SpanningTree{
private:
	int state; //usable
	int *m_iParent; //array for join
	int edgeNum; //edge number
	int vertexNum; //vertex number
	int cost; //cost
	BinomialMin *MinQueue; //min-priority queue
	BinMinNode *m_pRoot; //root

public:
	SpanningTree(); //constructor
	~SpanningTree(); //destructor

	bool span(int num); //spanning
	int isUsable(); //is usable?
	int find(int v); //find
	void unionVertex(int v, int w); //union
	void insertQueue(Edge *pEdge); //insert min-priority queue
};
