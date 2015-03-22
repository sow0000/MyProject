#pragma once
#include "File_IO.h"
#include "IspManage.h"
#include "BinomialMax.hpp"
#include "SpanningTree.h"
#include<stdlib.h>
#include<iostream>
using namespace std;

class ConnectionPlanner{
private:
	File_IO *lp;
	File_IO *con;
	File_IO *cities;
	File_IO *fout;
	WeightedGraph *graph;
	BinomialMax *MaxQueue;
	int currentBase;

public:
	ConnectionPlanner();
	~ConnectionPlanner();

	bool Start();
	bool Graph();
	bool Span(SpanningTree *sTree, int range);
};
