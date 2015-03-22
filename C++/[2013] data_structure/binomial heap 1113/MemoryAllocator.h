#pragma once
#pragma warning(disable:4996)
#include "File_IO.h"
#include "BinomialHeap.h"
#include "AllocationList.h"
#include <stdlib.h>
#include <iostream>
#include <iomanip>
#include <string.h>
using namespace std;

class MemoryAllocator{
private:
	File_IO *f_in; //input file
	File_IO *f_out; //output file
	File_IO *t_out; //trace file
	BinomialHeap* AvailableList; //not allocated memory list
	AllocationList* AllocatedList; //allocated memory list
	int coalCount; //coalescing count
	int failureCount; //memory allocation failure count

public:
	MemoryAllocator(); //constructor
	~MemoryAllocator(); //destructor

	bool Start(); //start memory allocator
	bool Allocate(int newIndex, int newSize); //allocate memory
	bool Free(int index); //free memory
	bool Coalescing(); //coalescing memory
	void Write(); //write state of memory
	void Trace(BinTreeNode *pNode, BinTreeNode *pHead); //trace available memory
};