#include "Bin_Heap.h"

Bin_Heap::Bin_Heap(void){
	root=NULL;
}

Bin_Heap::~Bin_Heap(void){
}

int Bin_Heap::Insert(BH_Nnode *pNew){
	if(!root){
		root=pNew;
		pNew->pNext=root;
	}

	

	return 0;
}