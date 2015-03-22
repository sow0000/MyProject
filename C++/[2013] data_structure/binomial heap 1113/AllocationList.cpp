#include "AllocationList.h"

AllocationList::AllocationList(){
	pSegHead=0;
	TotalSize=0;
	Partition=0;
}

AllocationList::~AllocationList(){
}

void AllocationList::setTotalSize(int newSize, int newPart){ //set total size and partition
	TotalSize=newSize;
	Partition=newPart;
	pSegHead=new BinTreeNode*[Partition];
	memset(pSegHead,0,sizeof(BinTreeNode*)*Partition);
}

void AllocationList::setPartition(BinTreeNode *pNode){ //link segment head
	pSegHead[pNode->getSeg()-1]=pNode;
}

bool AllocationList::Check(BinTreeNode *pMax, int newSize){ //check allocatable
	if(pMax->getSize()<newSize){
		BinTreeNode *pTemp=pMax->getNext(); //near area of pMax
		int needSize=newSize-pMax->getSize(); //need size after allocate in pMax

		if(!pTemp){
			pTemp=pSegHead[pMax->getSeg()];
		}
		if((pTemp->getIndex())||(pTemp->getSize()<needSize)){ //near area can not allocate
			return false;
		}
	}

	return true;
}

BinTreeNode* AllocationList::Insert(BinTreeNode *pMax, int newIndex, int newSize){
	if(pMax->getSize()>newSize){ //available size > allocate size
		BinTreeNode *pNew=new BinTreeNode(pMax->getSeg(), 0, pMax->getAddress()+newSize, pMax->getSize()-newSize);

		pNew->setNext(pMax->getNext()); //allocate in pMax and create node with remain memory
		pMax->setNext(pNew);
		pMax->setSize(newSize);
		pMax->setIndex(newIndex);

		return pNew; //return new node for insert binomial heap
	}
	else if(pMax->getSize()<newSize){ //available size < allocate size
		BinTreeNode *pTemp=pMax->getNext(); //node for allocate memory behind of pMax
		int needSize=newSize-pMax->getSize(); //need size after allocate in pMax

		if(!pTemp){ //pMax is end of segment
			pTemp=pSegHead[pMax->getSeg()];
		}
		if(pTemp->getSize()>needSize){ //pTemp size > need size
			BinTreeNode *pNew=new BinTreeNode(pTemp->getSeg(), 0, pTemp->getAddress()+needSize, pTemp->getSize()-needSize);

			pNew->setNext(pTemp->getNext()); //allocate in pTemp and create node with remain memory
			pTemp->setNext(pNew);
			pTemp->setSize(needSize);
		}

		pTemp->setIndex(newIndex); //allocate in pMax and link with pTemp
		pMax->setIndex(newIndex);
		pMax->setFlag(1);
		pMax->setNext(pTemp);

		return 0;
	}
	else{
		pMax->setIndex(newIndex); //allocate in pMax

		return pMax;
	}
}

BinTreeNode* AllocationList::Delete(int index){
	if(!pSegHead[1]){ //no data
		return 0;
	}

	BinTreeNode *pWalker=0; //traveling pointer

	for(int current=0;current<Partition;current++){ //move segment
		pWalker=pSegHead[current];

		while(pWalker){ //find node
			if(pWalker->getIndex()==index){
				return pWalker;
			}

			pWalker=pWalker->getNext();
		} //End of while
	} //End of for

	return 0;
}

bool AllocationList::CanCoalescing(){
	BinTreeNode *pWalker; //traveling pointer
	BinTreeNode *pPrev;  //prev node of pWalker

	for(int current=0;current<Partition;current++){
		pWalker=pSegHead[current];
		pPrev=pSegHead[current];

		while(pWalker=pWalker->getNext()){ //move next node
			if(pPrev->getSeg()!=pWalker->getSeg()){ //not same segment
				break;
			}

			if(!(pPrev->getIndex())&&!(pWalker->getIndex())){ //pPre and pWalker is near area
				return true;
			}
			else{ //pPre and pWalker is not near
				pPrev=pWalker;
			}
		} //End of while
	} //End of for

	return false;
}

void AllocationList::Coalescing(){
	BinTreeNode *pWalker; //traveling pointer
	BinTreeNode *pPrev;  //prev node of pWalker

	for(int current=0;current<Partition;current++){
		pWalker=pSegHead[current];
		pPrev=pSegHead[current];

		while(pWalker=pWalker->getNext()){ //move next node
			if(pPrev->getSeg()!=pWalker->getSeg()){ //not same segment
				break;
			}

			if(!(pPrev->getIndex())&&!(pWalker->getIndex())){ //pPre and pWalker is near area
				pPrev->setSize(pPrev->getSize()+pWalker->getSize());

				pPrev->setNext(pWalker->getNext()); //link next node of pWalker with pPrev
				delete pWalker; //delete pWalker
				pWalker=pPrev; //pWalker=pPrev
			}
			else{ //pPre and pWalker is not near
				pPrev=pWalker;
			}
		} //End of while
	} //End of for
}

BinTreeNode* AllocationList::getNode(BinTreeNode* pNode){
	if(!pNode){ //pNode is NULL, return first node
		return pSegHead[0];
	}

	BinTreeNode* pNext=pNode->getNext(); //get next node

	if(!pNext&&pNode->getSeg()<Partition){ //pNode is end of segment, move next segment
		pNext=pSegHead[pNode->getSeg()];
	}

	return pNext; //return pNext
}

int AllocationList::getTotalSize(){
	return TotalSize; //return total size
}
