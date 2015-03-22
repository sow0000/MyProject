#include "BST.h"
#include <string.h>
#include <iostream>
using namespace std;

BST::BST(){
	root=NULL;
}

BST::~BST(){
	delete root;
}

bool BST::Insert(char ch, int n){
	BST_Node *pWalker=root;
	BST_Node *pCurrent=NULL;
	Child_Node *pChWalker=NULL;

	while(pWalker){
		pCurrent=pWalker;
		pChWalker=pWalker->getChildList();
		pWalker=NULL;

		if(pCurrent->getCharData()==ch){
			if(pCurrent->getIntData()==n){
				return false;
			}
			if(pCurrent->getIntData()<n){
				MoveChildList(pChWalker, pWalker, 1);
			}
			else{
				MoveChildList(pChWalker, pWalker, 0);
			}
		}
		if(pCurrent->getCharData()<ch){
			MoveChildList(pChWalker, pWalker, 1);
		}
		else{
			MoveChildList(pChWalker, pWalker, 0);
		}
	}

	BST_Node *pNode=new BST_Node(ch, n);

	if(!root) root=pNode;
	else{
		Child_Node *pNewChild=new Child_Node(pNode);

		if(pCurrent->getCharData()==ch){
			if(pCurrent->getIntData()>n){
				pNewChild->setNum(0);
			}
			else{
				pNewChild->setNum(1);
			}
		}
		else if(pCurrent->getCharData()>ch){
			pNewChild->setNum(0);
		}
		else{
			pNewChild->setNum(1);
		}

		if(pCurrent->getChildList()==NULL){
			pCurrent->setChildList(pNewChild);
		}
		else{
			pCurrent->getChildList()->setNext(pNewChild);
		}
	}

	return true;
}

bool BST::Delete(char ch, int n){
	BST_Node *pCurrent=root;
	BST_Node *pPost=NULL;
	Child_Node *pChWalker=NULL;
	Child_Node *pPostChild=NULL;

	while(true){
		if(pCurrent->getCharData()==ch&&pCurrent->getIntData()==n){
			break;
		}
		else if(!pCurrent->getChildList()){
			pCurrent=NULL;
			break;
		}

		pPost=pCurrent;
		pChWalker=pCurrent->getChildList();
		pPostChild=NULL;

		if(pCurrent->getCharData()==ch){
			if(pCurrent->getIntData()<n){
				MoveChildList(pChWalker, pPostChild, pCurrent, 1);
			}
			else{
				MoveChildList(pChWalker, pPostChild, pCurrent, 0);
			}
		}
		if(pCurrent->getCharData()<ch){
			MoveChildList(pChWalker, pPostChild, pCurrent, 1);
		}
		else{
			MoveChildList(pChWalker, pPostChild, pCurrent, 0);
		}
	}


	if(!pCurrent){
		return false;
	}

	if(!pCurrent->getChildList()){
		if(pCurrent==root){
			delete pCurrent;
		}
		if(pPostChild){
			pPostChild->setNext(NULL);
			delete pChWalker;
		}
		else{
			if(pChWalker->getNext()){
				pPost->setChildList(pChWalker->getNext());
			}
			else{
				pPost->setChildList(NULL);
			}
			delete pChWalker;
		}
	}
	else{
		Child_Node* pChCurrent=pChWalker;
		BST_Node* pReplace=pCurrent->getChildList()->getChild();
		BST_Node* pTemp=pCurrent;

		pPost=pCurrent;
		pPostChild=NULL;

		if(pCurrent->getChildList()->getNum()==0){
			while(pChWalker){
				pChWalker=pReplace->getChildList();
				pPost=pTemp;
				pTemp=pReplace;
				MoveChildList(pChWalker, pPostChild, pReplace, 1);
			}
		}
		else{
			while(pChWalker){
				pChWalker=pReplace->getChildList();
				pPost=pTemp;
				pTemp=pReplace;
				MoveChildList(pChWalker, pPostChild, pReplace, 0);
			}
		}

		if(pReplace->getChildList()){
			pPostChild=NULL;
		}

		if(pPostChild){
			pPostChild->getNext()->setChild(NULL);
			delete pPostChild->getNext();
			
			if(pReplace->getChildList()){
				pPostChild->setNext(pReplace->getChildList());
			}
			else{
				pPostChild->setNext(NULL);
			}
		}
		else{
			if(pPost->getChildList()->getNext()){
				Child_Node* temp=pPost->getChildList();
				if(pReplace->getChildList()){
					pPost->setChildList(pReplace->getChildList());
					pPost->getChildList()->setNext(temp->getNext());
				}
				else{
					pPost->setChildList(temp->getNext());
				}
				delete temp;
			}
			else{
				delete pPost->getChildList();
				if(pReplace->getChildList()){
					pPost->setChildList(pReplace->getChildList());
				}
			}
		}

		if(pCurrent==root){
			pReplace->setChildList(root->getChildList());
			root=pReplace;
		}
		else{
			pChCurrent->setChild(pReplace);
			pReplace->setChildList(pCurrent->getChildList());
		}

		delete pCurrent;
	}

	return true;
}

void BST::MoveChildList(Child_Node *&pChWalker, BST_Node *&pWalker, int num){
	while(pChWalker){
		if(pChWalker->getNum()!=num){
			pChWalker=pChWalker->getNext();
		}
		else{
			pWalker=pChWalker->getChild();
			break;
		}
	}
}
void BST::MoveChildList(Child_Node *&pChWalker, Child_Node *&pPostChild, BST_Node *&pWalker, int num){
	while(pChWalker){
		if(pChWalker->getNum()!=num){
			pPostChild=pChWalker;
			pChWalker=pChWalker->getNext();
		}
		else{
			pWalker=pChWalker->getChild();
			break;
		}
	}
}

void BST::Print(){
	PrintChar(root);
}

void BST::PrintChar(BST_Node *CurrentNode){
	if(CurrentNode){
		BST_Node *pWalker=NULL;
		Child_Node *pChWalker=CurrentNode->getChildList();

		MoveChildList(pChWalker, pWalker, 0);
		PrintChar(pWalker);

		cout<<CurrentNode->getCharData()<<" "<<CurrentNode->getIntData()<<endl;

		pChWalker=CurrentNode->getChildList();
		pWalker=NULL;

		MoveChildList(pChWalker, pWalker, 1);
		PrintChar(pWalker);
	}
}

BST_Node* BST::Search(char ch, int n){
	BST_Node *pWalker=root;
	BST_Node *pCurrent=NULL;
	Child_Node *pChWalker=NULL;

	while(pWalker){
		pCurrent=pWalker;
		pChWalker=pWalker->getChildList();
		pWalker=NULL;

		if(pCurrent->getCharData()==ch){
			if(pCurrent->getIntData()==n){
				return pCurrent;
			}
			if(pCurrent->getIntData()<n){
				MoveChildList(pChWalker, pWalker, 1);
			}
			else{
				MoveChildList(pChWalker, pWalker, 0);
			}
		}
		if(pCurrent->getCharData()<ch){
			MoveChildList(pChWalker, pWalker, 1);
		}
		else{
			MoveChildList(pChWalker, pWalker, 0);
		}
	}

	return NULL;
}