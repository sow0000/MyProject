#include "BinomialHeap.h"

BinomialHeap::BinomialHeap(){
	root=0;
	totalSize=0;
	treeQueue=new BinTreeNode*[10];
	memset(treeQueue,0,sizeof(BinTreeNode*)*10);
}

BinomialHeap::~BinomialHeap(){
	delete [] treeQueue;
}

bool BinomialHeap::Insert(BinTreeNode *pNew){
	if(pNew->getIndex()){ //allocated memory
		return false;
	}

	totalSize+=pNew->getSize(); //add total size

	if(!root){ //no root
		root=pNew;
		pNew->setBNext(pNew); //set circular list
		return true;
	}

	pNew->setBNext(root->getBNext()); //insert next of root
	root->setBNext(pNew);

	root=((root->getSize()==pNew->getSize()) ? (root->getAddress()<pNew->getAddress() ? root:pNew):(root->getSize()>pNew->getSize() ? root:pNew));

	return true;
}

BinTreeNode* BinomialHeap::Delete(){
	if(!root){ //no data
		return 0;
	}

	memset(treeQueue, 0, sizeof(BinTreeNode*)*10);  // treeQueue ÃÊ±âÈ­
	BinTreeNode *pDelete=root; //delete node
	BinTreeNode *pWalker=root->getBNext(); //traveling pointer
	BinTreeNode *pChild=root->getChild(); //childe of root
	BinTreeNode *pBNext=0; //next node of pWalker
	int current; //current degree

	root=0; //initialize root

	while(pWalker!=pDelete){ //traveling sibling node of root
		pBNext=pWalker->getBNext();

		for(current=pWalker->getDegree();treeQueue[current];current++){ //join same dgree
			pWalker=Join(pWalker, treeQueue[current]);
			treeQueue[current]=0;
		}
		treeQueue[current] = pWalker; //save pWalker
		pWalker=pBNext; //go to next
	} //End of while

	pWalker=pChild; //child node of root

	while(pWalker){ //traveling sibling node of pChild
		pBNext=pWalker->getBNext();

		for(current=pWalker->getDegree(); treeQueue[current];current++){ //join same dgree
			pWalker=Join(pWalker, treeQueue[current]);
			treeQueue[current]=0;
		} //End of for
		
		treeQueue[current] = pWalker; //save pWalker
		pWalker=pBNext; //go to next

		if(pWalker==pChild){
			break;
		}
	} //End of while

//Change root
	BinTreeNode *pPrev=0;
	BinTreeNode *pCurrent=0;
	pBNext=0;

	for(current=0;current<10;current++){ //find first node in treeQueue
		if(pCurrent=treeQueue[current]){ //initialize all
			pPrev=pCurrent;
			root=pCurrent;
			pBNext=pCurrent;
			break;
		}
	} //End of for

	for(current+=1;current<10;current++){ //link sibling with other nodes in treeQueue
		if(!treeQueue[current]){
			continue;
		}

		if(pBNext=treeQueue[current]){
			pCurrent->setBNext(pBNext);
			pCurrent=pBNext;

			root=((root->getSize()==pCurrent->getSize()) ? (root->getAddress()<pCurrent->getAddress() ? root:pCurrent):(root->getSize()>pCurrent->getSize() ? root:pCurrent));

		}
	} //End of for

	if(pBNext){ //set circular list
		pBNext->setBNext(pPrev);
	}

	pDelete->reset(); //initialize pDelete
	totalSize-=pDelete->getSize(); //

	return pDelete;
}

bool BinomialHeap::DeleteAll(){
	while(Delete()){}
	totalSize=0;

	return true;
}

BinTreeNode* BinomialHeap::Join(BinTreeNode *pNode1, BinTreeNode *pNode2){
	if((pNode1->getSize()==pNode2->getSize()) ? (pNode1->getAddress()>pNode2->getAddress()):(pNode1->getSize()<pNode2->getSize())){ //pNode1 < pNode2
			BinTreeNode *pTemp=pNode1; //swap nodes
			pNode1=pNode2;
			pNode2=pTemp;
	}

	if(!pNode1->getChild()){ //bigger node has no child
		pNode1->setChild(pNode2);
		pNode2->setBNext(pNode2);
	}
	else{ //bigger node has already child
		pNode2->setBNext(pNode1->getChild()->getBNext());
		pNode1->getChild()->setBNext(pNode2);
	}

	pNode1->addDegree(); //add degree

	return pNode1; //return bigger node
}

BinTreeNode* BinomialHeap::getMax(){
	return root; //return max node
}

int BinomialHeap::getTotalSize(){
	return totalSize; //return total size
}