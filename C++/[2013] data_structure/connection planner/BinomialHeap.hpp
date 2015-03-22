#pragma once
#include <string.h>

template<class T>
class BinomialHeap{
private:
	T* pHead; //head
	T** treeQueue; //array for join

public:
	BinomialHeap(); //constructor
	~BinomialHeap(); //destructor

	virtual bool Compare(T *pNode1, T *pNode2) = 0; //compare nodes
	bool Insert(T *pNew); //insert not allocated node
	T* Delete(); //delete node
	bool DeleteAll(); //delete all node
	T* Join(T *pNode1, T *pNode2); //combine two nodes that same degree
	T* getHead(); //get pHead
};

template<class T>
BinomialHeap<T>::BinomialHeap(){
	pHead=0;
	treeQueue=new T*[10];
	memset(treeQueue,0,sizeof(T*)*10);
}

template<class T>
BinomialHeap<T>::~BinomialHeap(){
	delete [] treeQueue;
}

template<class T>
bool BinomialHeap<T>::Insert(T *pNew){
	if(!pHead){ //no pHead
		pHead=pNew;
		pNew->setBNext(pNew); //set circular list
		return true;
	}

	pNew->setBNext(pHead->getBNext()); //insert next of pHead
	pHead->setBNext(pNew);

	pHead=Compare(pHead, pNew) ? pHead:pNew;

	return true;
}

template<class T>
T* BinomialHeap<T>::Delete(){
	if(!pHead){ //no data
		return 0;
	}

	memset(treeQueue, 0, sizeof(T*)*10);  //treeQueue initialize
	T *pDelete=pHead; //delete node
	T *pWalker=pHead->getBNext(); //traveling pointer
	T *pChild=pHead->getChild(); //childe of pHead
	T *pBNext=0; //next node of pWalker
	int current; //current degree

	pHead=0; //initialize pHead

	while(pWalker!=pDelete){ //traveling sibling node of pHead
		pBNext=pWalker->getBNext();

		for(current=pWalker->getDegree();treeQueue[current];current++){ //join same dgree
			pWalker=Join(pWalker, treeQueue[current]);
			treeQueue[current]=0;
		}
		treeQueue[current] = pWalker; //save pWalker
		pWalker=pBNext; //go to next
	} //End of while

	pWalker=pChild; //child node of pHead

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

//Change pHead
	T *pPrev=0;
	T *pCurrent=0;
	pBNext=0;

	for(current=0;current<10;current++){ //find first node in treeQueue
		if(pCurrent=treeQueue[current]){ //initialize all
			pPrev=pCurrent;
			pHead=pCurrent;
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

			pHead=Compare(pHead, pCurrent) ? pHead:pCurrent;

		}
	} //End of for

	if(pBNext){ //set circular list
		pBNext->setBNext(pPrev);
	}

	pDelete->reset(); //initialize pDelete

	return pDelete;
}

template<class T>
bool BinomialHeap<T>::DeleteAll(){
	while(Delete()){}
	return true;
}

template<class T>
T* BinomialHeap<T>::Join(T *pNode1, T *pNode2){
	if(Compare(pNode2, pNode1)){
			T *pTemp=pNode1; //swap nodes
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

template<class T>
T* BinomialHeap<T>::getHead(){
	return pHead; //return head
}