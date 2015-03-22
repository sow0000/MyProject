#pragma warning(disable:4996)
#include "BST.h"
#include <stack>
#include <string.h>
#include<iomanip>
#include <iostream>
using namespace std;

BST::BST(){
	root=NULL;
}

BST::~BST(){
	while(root){
		Delete(root->getFirstName(), root->getLastName(), root->getPhoneNum());
	}
}

bool BST::Insert(char* firstName, char* lastName, char* newPhoneNum, char* newAddress){ //Make new Node and insert into Tree
	BST_Node *pWalker=root;
	BST_Node *pCurrent=NULL;
	Child_Node *pChWalker=NULL;

	while(pWalker){
		pCurrent=pWalker;

		if(!strcmp(pCurrent->getLastName(),lastName)){
			if(!strcmp(pCurrent->getFirstName(),firstName)){
				if(!strcmp(pCurrent->getPhoneNum(),newPhoneNum)){
					WriteError(0, "INSERT", firstName, lastName, NULL, newPhoneNum, newAddress);
					return false;
				}
				else if(strcmp(pCurrent->getPhoneNum(),newPhoneNum)<0){
					MoveChildList(pChWalker, pWalker, 1);
				}
				else{
					MoveChildList(pChWalker, pWalker, 0);
				}
			}
			else if(strcmp(pCurrent->getFirstName(),firstName)<0){
				MoveChildList(pChWalker, pWalker, 1);
			}
			else{
				MoveChildList(pChWalker, pWalker, 0);
			}
		}
		else if(strcmp(pCurrent->getLastName(),lastName)<0){
			MoveChildList(pChWalker, pWalker, 1);
		}
		else{
			MoveChildList(pChWalker, pWalker, 0);
		}
	}

	BST_Node *pNode=new BST_Node(firstName, lastName, newPhoneNum, newAddress); //make new node

	if(!root) root=pNode;
	else{
		Child_Node *pNewChild=new Child_Node(pNode);

		if(!strcmp(pCurrent->getLastName(),lastName)){
			if(!strcmp(pCurrent->getFirstName(),firstName)){
				if(strcmp(pCurrent->getPhoneNum(),newPhoneNum)<0){
					pNewChild->setNum(1);
				}
				else{
					pNewChild->setNum(0);
				}
			}
			else if(strcmp(pCurrent->getFirstName(),firstName)<0){
				pNewChild->setNum(1);
			}
			else{
				pNewChild->setNum(0);
			}
		}
		else if(strcmp(pCurrent->getLastName(),lastName)<0){
			pNewChild->setNum(1);
		}
		else{
			pNewChild->setNum(0);
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

bool BST::Delete(char* firstName, char* lastName, char* subKey){ //Delete Node
	if(!root){
		WriteError(2, "DELETE", firstName, lastName, subKey, NULL, NULL);
		return false;
	}

	if(SearchOverlap(firstName, lastName)&&!subKey){
		WriteError(1, "DELETE", firstName, lastName, subKey, NULL, NULL);
		return false;
	}

	BST_Node *pCurrent=root;
	BST_Node *pPost=NULL;
	Child_Node *pChWalker=NULL;
	Child_Node *pPostChild=NULL;

	while(pCurrent){ //find delete node
		if(!strcmp(pCurrent->getLastName(),lastName)&&!strcmp(pCurrent->getFirstName(),firstName)){
			if(!subKey){
				break;
			}
			else if(!strcmp(pCurrent->getPhoneNum(),subKey)){
				break;
			}
		}

		pPost=pCurrent;
		pPostChild=NULL;

		if(!strcmp(pPost->getLastName(),lastName)){
			if(!strcmp(pPost->getFirstName(),firstName)){
				if(subKey&&strcmp(pPost->getPhoneNum(),subKey)<0){
					MoveChildList(pChWalker, pPostChild, pCurrent, 1);
				}
				else if(subKey){
					MoveChildList(pChWalker, pPostChild, pCurrent, 0);
				}
			}
			else if(strcmp(pPost->getFirstName(),firstName)<0){
				MoveChildList(pChWalker, pPostChild, pCurrent, 1);
			}
			else{
				MoveChildList(pChWalker, pPostChild, pCurrent, 0);
			}
		}
		else if(strcmp(pPost->getLastName(),lastName)<0){
			MoveChildList(pChWalker, pPostChild, pCurrent, 1);
		}
		else{
			MoveChildList(pChWalker, pPostChild, pCurrent, 0);
		}
	}

	if(!pCurrent){
		WriteError(2, "DELETE", firstName, lastName, subKey, NULL, NULL);
		return false;
	}

	if(!pCurrent->getChildList()){
		if(pCurrent==root){
			root=NULL;
		}
		else if(pPostChild){
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
			delete pCurrent;
	}
	else{ //find replace node
		Child_Node* pChCurrent=pChWalker;
		BST_Node* pReplace=pCurrent->getChildList()->getChild();
		BST_Node* pTemp=pCurrent;

		pPost=pCurrent;
		pPostChild=NULL;
		pChWalker=pReplace->getChildList();

		if(pCurrent->getChildList()->getNum()==0){
			while(pChWalker){
				pPost=pTemp;
				pTemp=pReplace;
				MoveChildList(pChWalker, pPostChild, pReplace, 1);
				if(!pReplace){
					pReplace=pTemp;
				}
			}
		}
		else{
			while(pChWalker){
				pPost=pTemp;
				pTemp=pReplace;
				MoveChildList(pChWalker, pPostChild, pReplace, 0);
				if(!pReplace){
					pReplace=pTemp;
				}
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
				else{
					pPost->setChildList(NULL);
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

bool BST::Update(char* firstName, char* lastName, char* subKey, char* newPhoneNum, char* newAddress){ //Udpate Node
	if(!root){
		WriteError(3, "UPDATE", firstName, lastName, subKey, newPhoneNum, newAddress);
		return false;
	}

	if(SearchOverlap(firstName, lastName)&&!subKey){
		WriteError(1, "UPDATE", firstName, lastName, subKey, newPhoneNum, newAddress);
		return false;
	}

	BST_Node* update=Search(firstName, lastName, subKey);

	if(!update){
		WriteError(2, "UPDATE", firstName, lastName, subKey, newPhoneNum, newAddress);
		return false;
	}
	else if(subKey){
		Delete(firstName, lastName, subKey);
		Insert(firstName, lastName, newPhoneNum, newAddress);
	}
	else{
		update->setPhoneNum(newPhoneNum);
	}

	return true;
}

void BST::MoveChildList(Child_Node *&pChWalker, BST_Node *&pWalker, int num){ //Move to child node
	pChWalker=pWalker->getChildList();
	pWalker=NULL;
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

void BST::MoveChildList(Child_Node *&pChWalker, Child_Node *&pPostChild, BST_Node *&pWalker, int num){ //Move to child node with saving post child node
	pChWalker=pWalker->getChildList();
	pWalker=NULL;
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

bool BST::Print(){ //Print data of all node
	if(Print(NULL)){
		return true;
	}
	else{
		return false;
	}
}

bool BST::Print(char* lastName){ //Print data of all node last-name-matched node
	stack<BST_Node*> bstStack;
	BST_Node *pWalker=root;
	Child_Node *pChWalker=NULL;

	if(!root){
		if(lastName){
			WriteError(3, "PRINTNAME", NULL, lastName, NULL, NULL, NULL);
		}
		else{
			WriteError(3, "PRINTALL", NULL, lastName, NULL, NULL, NULL);
		}
		return false;
	}

	if(lastName&&!Search(NULL, lastName, NULL)){
		WriteError(2, "PRINTNAME", NULL, lastName, NULL, NULL, NULL);
		return false;
	}

	Write(1);

	while(true){
		while(pWalker){
			bstStack.push(pWalker);
			MoveChildList(pChWalker, pWalker, 0);
		}

		if(bstStack.empty()){
			Write(0);
			return true;
		}
		pWalker=bstStack.top();
		bstStack.pop();
		
		if(lastName){
			if(!strcmp(pWalker->getLastName(),lastName)){
				Write(pWalker->getFirstName(), pWalker->getLastName(), pWalker->getPhoneNum(), pWalker->getAddress());
			}
		}
		else{
			Write(pWalker->getFirstName(), pWalker->getLastName(), pWalker->getPhoneNum(), pWalker->getAddress());
		}

		MoveChildList(pChWalker, pWalker, 1);
	}
}

bool BST::Print(char* firstName, char* lastName, char* subKey){ //Print data of name-matched node
	if(!root){
		WriteError(3, "PRINT", firstName, lastName, subKey, NULL, NULL);
		return false;
	}

	if(SearchOverlap(firstName, lastName)&&!subKey){
		WriteError(1, "PRINT", firstName, lastName, subKey, NULL, NULL);
		return false;
	}

	BST_Node* printNode=Search(firstName, lastName, subKey);

	if(printNode){
		Write(1);
		Write(printNode->getFirstName(), printNode->getLastName(), printNode->getPhoneNum(), printNode->getAddress());
		Write(0);
	}
	else{
		WriteError(2, "PRINT", firstName, lastName, subKey, NULL, NULL);
		return false;
	}
	return true;
}

BST_Node* BST::Search(char* firstName, char* lastName, char* subKey){ //Search and return matched Node
	BST_Node *pWalker=root;
	BST_Node *pCurrent=NULL;
	Child_Node *pChWalker=NULL;

	while(pWalker){
		pCurrent=pWalker;

		if(!strcmp(pCurrent->getLastName(),lastName)){
			if(firstName&&!strcmp(pCurrent->getFirstName(),firstName)){
				if(subKey&&!strcmp(pCurrent->getPhoneNum(),subKey)){
					return pCurrent;
				}
				else if(subKey&&strcmp(pCurrent->getPhoneNum(),subKey)<0){
					MoveChildList(pChWalker, pWalker, 1);
				}
				else if(subKey){
					MoveChildList(pChWalker, pWalker, 0);
				}
				else{
					return pCurrent;
				}
			}
			else if(firstName&&strcmp(pCurrent->getFirstName(),firstName)<0){
				MoveChildList(pChWalker, pWalker, 1);
			}
			else if(firstName){
				MoveChildList(pChWalker, pWalker, 0);
			}
			else{
				return pCurrent;
			}
		}
		else if(strcmp(pCurrent->getLastName(),lastName)<0){
			MoveChildList(pChWalker, pWalker, 1);
		}
		else{
			MoveChildList(pChWalker, pWalker, 0);
		}
	}
	return NULL;
}

bool BST::SearchOverlap(char* firstName, char* lastName){ //Search overlapped node
	int checkOverlap=0;
	stack<BST_Node*> bstStack;
	BST_Node *pWalker=root;
	Child_Node *pChWalker=NULL;

	while(true){
		while(pWalker){
			bstStack.push(pWalker);
			MoveChildList(pChWalker, pWalker, 0);
		}

		if(bstStack.empty()){
			return false;
		}
		pWalker=bstStack.top();
		bstStack.pop();

		if(!strcmp(pWalker->getLastName(),lastName)&&!strcmp(pWalker->getFirstName(),firstName)){
			if(checkOverlap==0){
				checkOverlap++;
			}
			else{
				while(!bstStack.empty()){
					bstStack.pop();
				}
				return true;
			}
		}

		MoveChildList(pChWalker, pWalker, 1);
	}
}