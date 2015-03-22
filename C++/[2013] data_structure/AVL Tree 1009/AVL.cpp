#include "AVL.h"
#include <stack>
#include <string.h>
#include <iostream>
using namespace std;

typedef enum {LEFT, RIGHT};

AVL::AVL()
{
	root=NULL;
}

AVL::~AVL()
{
	delete root;
}

bool AVL::Insert(int newNum){
	if(!root){ //insert root
		root=new AVL_Node(newNum);
		return true;
	}

	AVL_Node *pCurrent=root; //current node with bf=1 or br=-1
	AVL_Node *pParrent=NULL; //parrent of pCurrent
	AVL_Node *pWalker=root; //pointer for moving through the tree
	AVL_Node *pWalParrent=NULL; //parent of pWalker

	while(pWalker){ //while pWalker is not NULL
		if(pWalker->getFactor()){ //if bf of pWalker is not 0
			pCurrent=pWalker;
			pParrent=pWalParrent;
		}
		if(pWalker->getNum()>newNum){ //if new data is smaller than data of pWalker
			pWalParrent=pWalker;
			pWalker=pWalker->getChild(LEFT); //go to LEFT child
		}
		else if(pWalker->getNum()<newNum){ //if new data is bigger than data of pWalker
			pWalParrent=pWalker;
			pWalker=pWalker->getChild(RIGHT); //go to RIGHT child
		}
		else{ //if new data is already in tree
			return false; //return false
		}
	} //End of while

	AVL_Node *pNew=new AVL_Node(newNum); //new node

	if(pWalParrent->getNum()>newNum){ //set LEFT child
		pWalParrent->setChild(LEFT, pNew);
	}
	else{ //set RIGHT child
		pWalParrent->setChild(RIGHT, pNew);
	}

	//rebalance
	int bfDef=0; //balance factor definition
	AVL_Node *pCurChild; //child of pCurrent
	AVL_Node *pGrdChild; //child of pCurChild

	if(pCurrent->getNum()<newNum){
		pCurChild=pWalker=pCurrent->getChild(1);
		bfDef=-1;
	}
	else{
		pCurChild=pWalker=pCurrent->getChild(LEFT);
		bfDef=1;
	}

	while(pWalker!=pNew){
		if(pWalker->getNum()<newNum){ //height of RIGHT added
			pWalker->setFactor(-1);
			pWalker=pWalker->getChild(RIGHT);
		}
		else{ //height of LEFT added
			pWalker->setFactor(1);
			pWalker=pWalker->getChild(LEFT);
		}
	}

	if(!(pCurrent->getFactor())||!(pCurrent->getFactor()+bfDef)){ //tree is balanced
		pCurrent->setFactor(pCurrent->getFactor()+bfDef);
		return true;
	}
	if(bfDef==1){ //LEFT imbalance
		if(pCurChild->getFactor()==1){ //LL
			pCurrent->setChild(LEFT, pCurChild->getChild(RIGHT));
			pCurChild->setChild(RIGHT, pCurrent);
			pCurrent->setFactor(0);
			pCurChild->setFactor(0);
		} //End of LL
		else { //LR
			pGrdChild=pCurChild->getChild(RIGHT);
			pCurChild->setChild(RIGHT, pGrdChild->getChild(LEFT));
			pCurrent->setChild(LEFT, pGrdChild->getChild(RIGHT));
			pGrdChild->setChild(LEFT, pCurChild);
			pGrdChild->setChild(RIGHT, pCurrent);

			switch(pGrdChild->getFactor()){
				case 1:
					{
						pCurrent->setFactor(-1);
						pCurChild->setFactor(0);
						break;
					}
				case -1:
					{
						pCurrent->setFactor(0);
						pCurChild->setFactor(1);
						break;
					}
				case 0:
					{
						pCurrent->setFactor(0);
						pCurChild->setFactor(0);
						break;
					}
			}
			pGrdChild->setFactor(0);
			pCurChild=pGrdChild;
		} //End of LR
	}
	else{ //RIGHT imbalance
		if(pCurChild->getFactor()==-1){ //RR
			pCurrent->setChild(RIGHT, pCurChild->getChild(LEFT));
			pCurChild->setChild(LEFT, pCurrent);
			pCurrent->setFactor(0);
			pCurChild->setFactor(0);
		} //End of RR
		else { //RL
			pGrdChild=pCurChild->getChild(LEFT);
			pCurChild->setChild(LEFT, pGrdChild->getChild(RIGHT));
			pCurrent->setChild(RIGHT, pGrdChild->getChild(LEFT));
			pGrdChild->setChild(RIGHT, pCurChild);
			pGrdChild->setChild(LEFT, pCurrent);

			switch(pGrdChild->getFactor()){
				case 1:
					{
						pCurrent->setFactor(1);
						pCurChild->setFactor(0);
						break;
					}
				case -1:
					{
						pCurrent->setFactor(0);
						pCurChild->setFactor(-1);
						break;
					}
				case 0:
					{
						pCurrent->setFactor(0);
						pCurChild->setFactor(0);
						break;
					}
			}
			pGrdChild->setFactor(0);
			pCurChild=pGrdChild;
		} //End of RL
	}

	if(!pParrent){
		root=pCurChild;
	}
	else if(pCurrent==pParrent->getChild(LEFT)){
		pParrent->setChild(LEFT, pCurChild);
	}
	else{
		pParrent->setChild(RIGHT, pCurChild);
	}

	return true;
}

bool AVL::Print(){
	stack<AVL_Node*> avlStack;
	AVL_Node *pWalker=root;

	if(!root){
		return false;
	}

	while(true){
		while(pWalker){
			avlStack.push(pWalker);
			pWalker=pWalker->getChild(LEFT);
		}

		if(avlStack.empty()){
			return true;
		}
		pWalker=avlStack.top();
		avlStack.pop();

		cout<<pWalker->getNum()<<endl;

		pWalker=pWalker->getChild(RIGHT);
	}
}