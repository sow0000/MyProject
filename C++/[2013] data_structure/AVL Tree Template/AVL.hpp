#pragma once
#include "AVL_Node.hpp"
#include "FILE_IO.h"
#include <fstream>
#include <stack>
#include <string.h>
#include <iostream>
#include <iomanip>
using namespace std;

class AVL{
private:
	AVL_Node* root_name; //name root Node
	AVL_Node* root_phone; //phone number root Node

public:
	AVL(){ //Constructor
		root_name=NULL;
		root_phone=NULL;
	}

	~AVL(){ //Destructor
		while(root_phone){
			Delete(root_phone->getPhoneNum());
		}
	}

	template<class k>
	void setRoot(AVL_Node *pNew); //set root

	template<class k>
	AVL_Node* getRoot(); //return root

	bool Insert(char* firstName, char* lastName, char* newPhoneNum, char* newAddress){ //Make new Node and insert into tree
		AVL_Node *pNew=new AVL_Node(firstName, lastName, newPhoneNum, newAddress); //new node

		if(!root_name){ //insert root
			root_name=root_phone=pNew;
			return true;
		}

		if(!Insert<Name>(pNew)){ //insert name tree
			delete pNew; //already in tree
			return false;
		}
		Insert<Phone>(pNew); //insert phone tree

		return true;
	}

	template<class k>
	bool Insert(AVL_Node* pNew){ //insert into tree
		Data data;
		strcpy(data.firstName,pNew->getFirstName());
		strcpy(data.lastName,pNew->getLastName());
		strcpy(data.phoneNum,pNew->getPhoneNum());

		AVL_Node *pCurrent=getRoot<k>(); //current node with bf=1 or br=-1
		AVL_Node *pParrent=NULL; //parrent of pCurrent
		AVL_Node *pWalker=getRoot<k>(); //pointer for moving through the tree
		AVL_Node *pWalParrent=NULL; //parrent of pWalker

		while(pWalker){ //while pWalker is not NULL
			if(pWalker->getFactor<k>()){ //if bf of pWalker is not 0
				pCurrent=pWalker;
				pParrent=pWalParrent;
			}
			if(pWalker->compare<k>(data)>0){ //if new data is smaller than data of pWalker
				pWalParrent=pWalker;
				pWalker=pWalker->getChild<k>(0); //go to 0 child
			}
			else if(pWalker->compare<k>(data)<0){ //if new data is bigger than data of pWalker
				pWalParrent=pWalker;
				pWalker=pWalker->getChild<k>(1); //go to 1 child
			}
			else{ //if new data is already in tree
				return false; //return false
			}
		} //End of while

		if(pWalParrent->compare<k>(data)>0){ //set 0 child
			pWalParrent->setChild<k>(0, pNew);
		}
		else{ //set 1 child
			pWalParrent->setChild<k>(1, pNew);
		}

		//rebalance
		int bfDef=0; //balance factor definition
		AVL_Node *pCurChild=NULL; //child of pCurrent
		AVL_Node *pGrdChild=NULL; //child of pCurChild

		if(pCurrent->compare<k>(data)>0){
			pCurChild=pWalker=pCurrent->getChild<k>(0);
			bfDef=1;
		}
		else{
			pCurChild=pWalker=pCurrent->getChild<k>(1);
			bfDef=-1;
		}

		while(pWalker!=pNew){
			if(pWalker->compare<k>(data)>0){ //height of 0 added
				pWalker->setFactor<k>(1);
				pWalker=pWalker->getChild<k>(0);
			}
			else{ //height of 1 added
				pWalker->setFactor<k>(-1);
				pWalker=pWalker->getChild<k>(1);
			}
		} //End of while

		if(!(pCurrent->getFactor<k>())||!(pCurrent->getFactor<k>()+bfDef)){ //tree is balanced
			pCurrent->setFactor<k>(pCurrent->getFactor<k>()+bfDef);
			return true;
		}
		if(bfDef==1){ //left imbalance
			if(pCurChild->getFactor<k>()==1){ //LL
				pCurrent->setChild<k>(0, pCurChild->getChild<k>(1));
				pCurChild->setChild<k>(1, pCurrent);
				pCurrent->setFactor<k>(0);
				pCurChild->setFactor<k>(0);
			} //End of LL
			else { //LR
				pGrdChild=pCurChild->getChild<k>(1);
				pCurChild->setChild<k>(1, pGrdChild->getChild<k>(0)); //RR
				pCurrent->setChild<k>(0, pGrdChild->getChild<k>(1));
				pGrdChild->setChild<k>(0, pCurChild); //LL
				pGrdChild->setChild<k>(1, pCurrent);

				switch(pGrdChild->getFactor<k>()){
				case 1:
					{
						pCurrent->setFactor<k>(-1);
						pCurChild->setFactor<k>(0);
						break;
					}
				case -1:
					{
						pCurrent->setFactor<k>(0);
						pCurChild->setFactor<k>(1);
						break;
					}
				case 0:
					{
						pCurrent->setFactor<k>(0);
						pCurChild->setFactor<k>(0);
						break;
					}
				}
				pGrdChild->setFactor<k>(0);
				pCurChild=pGrdChild;
			} //End of LR
		}
		else{ //right imbalance
			if(pCurChild->getFactor<k>()==-1){ //RR
				pCurrent->setChild<k>(1, pCurChild->getChild<k>(0));
				pCurChild->setChild<k>(0, pCurrent);
				pCurrent->setFactor<k>(0);
				pCurChild->setFactor<k>(0);
			} //End of RR
			else { //RL
				pGrdChild=pCurChild->getChild<k>(0);
				pCurChild->setChild<k>(0, pGrdChild->getChild<k>(1)); //LL
				pCurrent->setChild<k>(1, pGrdChild->getChild<k>(0));
				pGrdChild->setChild<k>(1, pCurChild); //RR
				pGrdChild->setChild<k>(0, pCurrent);

				switch(pGrdChild->getFactor<k>()){
				case 1:
					{
						pCurrent->setFactor<k>(1);
						pCurChild->setFactor<k>(0);
						break;
					}
				case -1:
					{
						pCurrent->setFactor<k>(0);
						pCurChild->setFactor<k>(-1);
						break;
					}
				case 0:
					{
						pCurrent->setFactor<k>(0);
						pCurChild->setFactor<k>(0);
						break;
					}
				}
				pGrdChild->setFactor<k>(0);
				pCurChild=pGrdChild;
			} //End of RL
		}

		if(!pParrent){ //Change root
			setRoot<k>(pCurChild);
		}
		else if(pCurrent==pParrent->getChild<k>(0)){
			pParrent->setChild<k>(0, pCurChild);
		}
		else{
			pParrent->setChild<k>(1, pCurChild);
		}

		return true;
	}

	bool Delete(char* phoneNum){ //delete phone
		AVL_Node* pDelete=Delete<Phone>(NULL, NULL, phoneNum); //cut from phone tree

		if(!pDelete){
			return false;
		}
		Delete<Name>(pDelete->getFirstName(), pDelete->getLastName(), phoneNum); //cut from name tree

		delete pDelete;

		return true;
	}

	bool Delete(char* firstName, char* lastName, char* subKey){ //delete name
		if(!subKey&&!SearchOverlap<Name>(firstName, lastName)){
			return false;
		}

		AVL_Node* pDelete=Delete<Name>(firstName, lastName, subKey); //cut from name tree

		if(!pDelete){
			return false;
		}
		Delete<Phone>(NULL, NULL, pDelete->getPhoneNum()); //cut from phone tree

		delete pDelete; //delete pDelete

		return true;
	}

	template<class k>
	AVL_Node* Delete(char* firstName, char* lastName, char* subKey){ //Delete Node with name and sub key
		if(!getRoot<k>()){ //no data
			return false;
		}

		Data data; //data for find
		memset(data.firstName, NULL, 10);
		memset(data.lastName, NULL, 10);
		memset(data.phoneNum, NULL, 10);
		if(firstName){
			strcpy(data.firstName,firstName);
		}
		if(lastName){
			strcpy(data.lastName,lastName);
		}
		if(subKey){
			strcpy(data.phoneNum,subKey);
		}

		AVL_Node *pDelete=NULL; //delete node
		AVL_Node *pDelParrent=NULL; //parrent of delete node
		AVL_Node *pCurrent=getRoot<k>(); //current node with bf=0
		AVL_Node *pWalker=getRoot<k>(); //pointer for moving through the tree
		AVL_Node *pWalParrent=NULL; //parrent of pWalker

		while(pWalker){ //while pWalker is not NULL
			if(!pWalker->getFactor<k>()){ //if bf of pWalker is not 0
				pCurrent=pWalker;
			}
			if(pWalker->compare<k>(data)>0){ //if find data is smaller than data of pWalker
				pWalParrent=pWalker;
				pWalker=pWalker->getChild<k>(0); //go to 0 child
			}
			else if(pWalker->compare<k>(data)<0){ //if find data is bigger than data of pWalker
				pWalParrent=pWalker;
				pWalker=pWalker->getChild<k>(1); //go to 1 child
			}
			else{ //find node
				pDelete=pWalker;
				pDelParrent=pWalParrent;
				break;
			}
		} //End of while

		if(!pDelete){ //no matching data
			return NULL;
		}

		if(!(pDelete->getChild<k>(0))&&!(pDelete->getChild<k>(1))){ //if pDelete has no child
			if(pDelete==getRoot<k>()){
				setRoot<k>(NULL);
				return pDelete;
			}
			else if(pDelete==pDelParrent->getChild<k>(1)){
				pDelParrent->setChild<k>(1, NULL);
			}
			else{
				pDelParrent->setChild<k>(0, NULL);
			}
		}
		else{ //pDelete has child
			if(pDelete->getChild<k>(0)){ //pDelete has left child
				pWalker=pDelete->getChild<k>(0); //replace node
				pWalParrent=pDelete; //parrent of pWalker

				while(pWalker->getChild<k>(1)){ //while right child of pWalker is not NULL
					pWalParrent=pWalker;
					pWalker=pWalker->getChild<k>(1);
				}

				if(pWalker==pDelete->getChild<k>(0)){ //if left node of pDelete has not right node
					pDelete->setChild<k>(0, pWalker->getChild<k>(0));
				}
				else{ //if left node of pDelete has right node
					pWalParrent->setChild<k>(1, NULL);
				}
				pWalker->setChild<k>(0, pDelete->getChild<k>(0));
				pWalker->setChild<k>(1, pDelete->getChild<k>(1));
			}
			else{ //pDelete has only right child
				pWalker=pDelete->getChild<k>(1); //replace node
				pWalParrent=pDelete; //parrent of pWalker
			}

			pDelete->setChild<k>(0, NULL);
			pDelete->setChild<k>(1, NULL);

			if(pDelete==getRoot<k>()){ //change root
				setRoot<k>(pWalker);
			}
			else if(pDelete==pDelParrent->getChild<k>(1)){ //pDelete is not root, 
				pDelParrent->setChild<k>(1, pWalker);
			}
			else{
				pDelParrent->setChild<k>(0, pWalker);
			}
		}

	Rebalance<k>(getRoot<k>()); //rebalance

	return pDelete;
	}

	template<class k>
	int Rebalance(AVL_Node* pWalker){ //Rebalance
		int leftHeight=0;
		int rightHeight=0;
		
		if(!pWalker->getChild<k>(0)){
			leftHeight=0;
		}
		else{
			leftHeight=Rebalance<k>(pWalker->getChild<k>(0));
		}
		if(!pWalker->getChild<k>(1)){
			rightHeight=0;
		}
		else{
			rightHeight=Rebalance<k>(pWalker->getChild<k>(1));
		}

		pWalker->setFactor<k>(leftHeight-rightHeight);

		return leftHeight>rightHeight ? leftHeight:rightHeight;
	}


	bool Update(char* phoneNum, char* newAddress){ //Udpate phone
		if(!Update<Phone>(NULL, NULL, phoneNum, NULL, newAddress)){
			return false;
		}
		return true;
	}

	bool Update(char* firstName, char* lastName, char* subKey, char* newPhoneNum, char* newAddress){ //Udpate name
		if(!subKey&&!SearchOverlap<Name>(firstName, lastName)){
			return false;
		}
		
		AVL_Node* pUpdate=Update<Name>(firstName, lastName, subKey, newPhoneNum, newAddress);

		if(!pUpdate){
			return false;
		}
		
		Delete<Phone>(NULL, NULL, pUpdate->getPhoneNum()); //update phone tree
		Insert<Phone>(pUpdate);

		return true;
	}

	template<class k>
	AVL_Node* Update(char* firstName, char* lastName, char* subKey, char* newPhoneNum, char* newAddress){ //Udpate Node
		if(!getRoot<k>()){ //no data
			return NULL;
		}

		Data data; //data for find
		memset(data.firstName, NULL, 10);
		memset(data.lastName, NULL, 10);
		memset(data.phoneNum, NULL, 10);
		if(firstName){
			strcpy(data.firstName,firstName);
		}
		if(lastName){
			strcpy(data.lastName,lastName);
		}
		if(subKey){
			strcpy(data.phoneNum,subKey);
		}

		AVL_Node *pWalker=getRoot<k>(); //pointer for moving through the tree

		while(pWalker){ //while pWalker is not NULL
			if(pWalker->compare<k>(data)>0){ //if find data is smaller than data of pWalker
				pWalker=pWalker->getChild<k>(0); //go to 0 child
			}
			else if(pWalker->compare<k>(data)<0){ //if find data is bigger than data of pWalker
				pWalker=pWalker->getChild<k>(1); //go to 1 child
			}
			else{ //find node
				if(newPhoneNum){
					pWalker->setPhoneNum(newPhoneNum);
				}
				pWalker->setAddress(newAddress);

				return pWalker;
			}
		} //End of while

		return NULL;
	}

	bool Print(char* arg, FILE_IO& file){ //Print control
		if(*arg>=48&&*arg<=57){
			if(!Print<Phone>(NULL, NULL, arg, file)){
				return false;
			}
		}
		else{
			if(!PrintAll<Name>(NULL, arg, NULL, file)){
				return false;
			}
		}
		return true;
	}

	template<class k>
	bool Print(char* firstName, char* lastName, char* subKey, FILE_IO& file){ //Print one node
		if(!getRoot<k>()){ //no data
			return false;
		}

		if(!subKey&&!SearchOverlap<Name>(firstName, lastName)){
			return false;
		}

		Data data; //data for find
		memset(data.firstName, NULL, 10);
		memset(data.lastName, NULL, 10);
		memset(data.phoneNum, NULL, 10);
		if(firstName){
			strcpy(data.firstName,firstName);
		}
		if(lastName){
			strcpy(data.lastName,lastName);
		}
		if(subKey){
			strcpy(data.phoneNum,subKey);
		}

		AVL_Node *pWalker=getRoot<k>(); //pointer for moving through the tree

		while(pWalker){ //while pWalker is not NULL
			if(pWalker->compare<k>(data)>0){ //if find data is smaller than data of pWalker
				pWalker=pWalker->getChild<k>(0); //go to 0 child
			}
			else if(pWalker->compare<k>(data)<0){ //if find data is bigger than data of pWalker
				pWalker=pWalker->getChild<k>(1); //go to 1 child
			}
			else{ //find tree
				file.OutputFileOpen("result.out"); //output result
				file.WriteIndex();
				file.WriteData(0, pWalker->getFirstName(), pWalker->getLastName(), pWalker->getPhoneNum(), pWalker->getAddress());
				file.WriteEnd();

				return true;
			}
		} //End of while

		return false;
	}

	bool PrintAll(FILE_IO& file){ //Print data of all node
		PrintAll<Name>(NULL, NULL, NULL, file);
		PrintAll<Phone>(NULL, NULL, NULL, file);

		return true;
	}

	template<class k>
	bool PrintAll(char* firstName, char* lastName, char* subKey, FILE_IO& file){ //Print nodes
		if(!getRoot<k>()){ //no data
			return false;
		}

		stack<AVL_Node*> avlStack;
		AVL_Node *pWalker=getRoot<k>();

		file.OutputFileOpen("result.out"); //output result
		file.WriteIndex();

		while(true){
			while(pWalker){
				avlStack.push(pWalker);
				pWalker=pWalker->getChild<k>(0); 
			}

			if(avlStack.empty()){
				file.WriteEnd();
				return true;
			}
			pWalker=avlStack.top();
			avlStack.pop();

			if(lastName){ //print last name
				if(!(strcmp(pWalker->getLastName(),lastName))){
					file.WriteData(0, pWalker->getFirstName(), pWalker->getLastName(), pWalker->getPhoneNum(), pWalker->getAddress());
				}
			}
			else{ //print all
				if(pWalker==getRoot<k>()){
					file.WriteData(1, pWalker->getFirstName(), pWalker->getLastName(), pWalker->getPhoneNum(), pWalker->getAddress());
				}
				else{
					file.WriteData(0, pWalker->getFirstName(), pWalker->getLastName(), pWalker->getPhoneNum(), pWalker->getAddress());
				}
			}

			pWalker=pWalker->getChild<k>(1);
		}
	}


	template<class k>
	bool SearchOverlap(char* firstName, char* lastName){ //Search overlapped node
		int checkOverlap=0;
		stack<AVL_Node*> avlStack;
		AVL_Node *pWalker=getRoot<k>();

		while(true){
			while(pWalker){
				avlStack.push(pWalker);
				pWalker=pWalker->getChild<k>(0); 
			}

			if(avlStack.empty()){ //no overlapped node
				return true;
			}
			pWalker=avlStack.top();
			avlStack.pop();

			if(!strcmp(pWalker->getLastName(),lastName)&&!strcmp(pWalker->getFirstName(),firstName)){
				if(checkOverlap==0){ //find node but not overlapped
					checkOverlap++;
				}
				else{
					while(!avlStack.empty()){ //if there is overlapped node, return false
						avlStack.pop();
					}
					return false;
				}
			}
			pWalker=pWalker->getChild<k>(1);
		}
	}

};

template<>
void AVL::setRoot<Name>(AVL_Node *pNew){ //set name root
	root_name=pNew;
}

template<>
void AVL::setRoot<Phone>(AVL_Node *pNew){ //set phone root
	root_phone=pNew;
}

template<>
AVL_Node* AVL::getRoot<Name>(){ //return name root
	return root_name;
}

template<>
AVL_Node* AVL::getRoot<Phone>(){ //return phone root
	return root_phone;
}