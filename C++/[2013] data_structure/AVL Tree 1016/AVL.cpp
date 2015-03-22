#include "AVL.h"
#include <stack>
#include <string.h>
#include <iostream>
#include <iomanip>
using namespace std;

typedef enum {NAME_LEFT, NAME_RIGHT, PHONE_LEFT, PHONE_RIGHT};
int deleteCall=0; //order of delete function

AVL::AVL(){
	root_name=NULL;
	root_phone=NULL;
}

AVL::~AVL(){
	while(root_phone){
		Delete(root_phone->getPhoneNum());
	}
}

bool AVL::Insert(char* firstName, char* lastName, char* newPhoneNum, char* newAddress){
	AVL_Node *pNew=new AVL_Node(firstName, lastName, newPhoneNum, newAddress); //new node

	if(!root_name){ //insert root
		root_name=root_phone=pNew;
		return true;
	}

	if(!InsertName(pNew)){
		delete pNew;
		return false;
	}
	InsertPhone(pNew);

	return true;
}

bool AVL::InsertName(AVL_Node *pNew){
	AVL_Node *pCurrent=root_name; //current node with bf=1 or br=-1
	AVL_Node *pParrent=NULL; //parrent of pCurrent
	AVL_Node *pWalker=root_name; //pointer for moving through the tree
	AVL_Node *pWalParrent=NULL; //parrent of pWalker

	while(pWalker){ //while pWalker is not NULL
		if(pWalker->getNameFactor()){ //if bf of pWalker is not 0
			pCurrent=pWalker;
			pParrent=pWalParrent;
		}
		if(strcmp(pWalker->getLastName(),pNew->getLastName())>0){ //if new data is smaller than data of pWalker
			pWalParrent=pWalker;
			pWalker=pWalker->getChild(NAME_LEFT); //go to LEFT child
		}
		else if(strcmp(pWalker->getLastName(),pNew->getLastName())<0){ //if new data is bigger than data of pWalker
			pWalParrent=pWalker;
			pWalker=pWalker->getChild(NAME_RIGHT); //go to RIGHT child
		}
		else{
			if(strcmp(pWalker->getFirstName(),pNew->getFirstName())>0){ //if new data is smaller than data of pWalker
				pWalParrent=pWalker;
				pWalker=pWalker->getChild(NAME_LEFT); //go to LEFT child
			}
			else if(strcmp(pWalker->getFirstName(),pNew->getFirstName())<0){ //if new data is bigger than data of pWalker
				pWalParrent=pWalker;
				pWalker=pWalker->getChild(NAME_RIGHT); //go to RIGHT child
			}
			else{
				if(strcmp(pWalker->getPhoneNum(),pNew->getPhoneNum())>0){ //if new data is smaller than data of pWalker
					pWalParrent=pWalker;
					pWalker=pWalker->getChild(NAME_LEFT); //go to LEFT child
				}
				else if(strcmp(pWalker->getPhoneNum(),pNew->getPhoneNum())<0){ //if new data is bigger than data of pWalker
					pWalParrent=pWalker;
					pWalker=pWalker->getChild(NAME_RIGHT); //go to RIGHT child
				}
				else{ //if new data is already in tree
					return false; //return false
				}
			}
		}
	} //End of while

	if(strcmp(pWalParrent->getLastName(),pNew->getLastName())>0){ //set LEFT child
		pWalParrent->setChild(NAME_LEFT, pNew);
	}
	else if(strcmp(pWalParrent->getLastName(),pNew->getLastName())<0){ //set RIGHT child
		pWalParrent->setChild(NAME_RIGHT, pNew);
	}
	else{
		if(strcmp(pWalParrent->getFirstName(),pNew->getFirstName())>0){ //set LEFT child
			pWalParrent->setChild(NAME_LEFT, pNew);
		}
		else if(strcmp(pWalParrent->getFirstName(),pNew->getFirstName())<0){ //set RIGHT child
			pWalParrent->setChild(NAME_RIGHT, pNew);
		}
		else{
			if(strcmp(pWalParrent->getPhoneNum(),pNew->getPhoneNum())>0){ //set LEFT child
				pWalParrent->setChild(NAME_LEFT, pNew);
			}
			else{ //set RIGHT child
				pWalParrent->setChild(NAME_RIGHT, pNew);
			}
		}
	}

	//rebalance
	int bfDef=0; //balance factor definition
	AVL_Node *pCurChild=NULL; //child of pCurrent
	AVL_Node *pGrdChild=NULL; //child of pCurChild

	if(strcmp(pCurrent->getLastName(),pNew->getLastName())>0){
		pCurChild=pWalker=pCurrent->getChild(NAME_LEFT);
		bfDef=1;
	}
	else if(strcmp(pCurrent->getLastName(),pNew->getLastName())<0){
		pCurChild=pWalker=pCurrent->getChild(NAME_RIGHT);
		bfDef=-1;
	}
	else{
		if(strcmp(pCurrent->getFirstName(),pNew->getFirstName())>0){
			pCurChild=pWalker=pCurrent->getChild(NAME_LEFT);
			bfDef=1;
		}
		else if(strcmp(pCurrent->getFirstName(),pNew->getFirstName())<0){
			pCurChild=pWalker=pCurrent->getChild(NAME_RIGHT);
			bfDef=-1;
		}
		else{
			if(strcmp(pCurrent->getPhoneNum(),pNew->getPhoneNum())>0){
				pCurChild=pWalker=pCurrent->getChild(NAME_LEFT);
				bfDef=1;
			}
			else{
				pCurChild=pWalker=pCurrent->getChild(NAME_RIGHT);
				bfDef=-1;
			}
		}
	}

	while(pWalker!=pNew){
		if(strcmp(pWalker->getLastName(),pNew->getLastName())>0){ //height of LEFT added
			pWalker->setNameFactor(1);
			pWalker=pWalker->getChild(NAME_LEFT);
		}
		else if(strcmp(pWalker->getLastName(),pNew->getLastName())<0){ //height of RIGHT added
			pWalker->setNameFactor(-1);
			pWalker=pWalker->getChild(NAME_RIGHT);
		}
		else{
			if(strcmp(pWalker->getFirstName(),pNew->getFirstName())>0){ //height of LEFT added
				pWalker->setNameFactor(1);
				pWalker=pWalker->getChild(NAME_LEFT);
			}
			else if(strcmp(pWalker->getFirstName(),pNew->getFirstName())<0){ //height of RIGHT added
				pWalker->setNameFactor(-1);
				pWalker=pWalker->getChild(NAME_RIGHT);
			}
			else{
				if(strcmp(pWalker->getPhoneNum(),pNew->getPhoneNum())>0){ //height of LEFT added
					pWalker->setNameFactor(1);
					pWalker=pWalker->getChild(NAME_LEFT);
				}
				else{ //height of RIGHT added
					pWalker->setNameFactor(-1);
					pWalker=pWalker->getChild(NAME_RIGHT);
				}
			}
		}
	}

	if(!(pCurrent->getNameFactor())||!(pCurrent->getNameFactor()+bfDef)){ //tree is balanced
		pCurrent->setNameFactor(pCurrent->getNameFactor()+bfDef);
		return true;
	}
	if(bfDef==1){ //LEFT imbalance
		if(pCurChild->getNameFactor()==1){ //LL
			pCurrent->setChild(NAME_LEFT, pCurChild->getChild(NAME_RIGHT));
			pCurChild->setChild(NAME_RIGHT, pCurrent);
			pCurrent->setNameFactor(0);
			pCurChild->setNameFactor(0);
		} //End of LL
		else { //LR
			pGrdChild=pCurChild->getChild(NAME_RIGHT);
			pCurChild->setChild(NAME_RIGHT, pGrdChild->getChild(NAME_LEFT));
			pCurrent->setChild(NAME_LEFT, pGrdChild->getChild(NAME_RIGHT));
			pGrdChild->setChild(NAME_LEFT, pCurChild);
			pGrdChild->setChild(NAME_RIGHT, pCurrent);

			switch(pGrdChild->getNameFactor()){
				case 1:
					{
						pCurrent->setNameFactor(-1);
						pCurChild->setNameFactor(0);
						break;
					}
				case -1:
					{
						pCurrent->setNameFactor(0);
						pCurChild->setNameFactor(1);
						break;
					}
				case 0:
					{
						pCurrent->setNameFactor(0);
						pCurChild->setNameFactor(0);
						break;
					}
			}
			pGrdChild->setNameFactor(0);
			pCurChild=pGrdChild;
		} //End of LR
	}
	else{ //RIGHT imbalance
		if(pCurChild->getNameFactor()==-1){ //RR
			pCurrent->setChild(NAME_RIGHT, pCurChild->getChild(NAME_LEFT));
			pCurChild->setChild(NAME_LEFT, pCurrent);
			pCurrent->setNameFactor(0);
			pCurChild->setNameFactor(0);
		} //End of RR
		else { //RL
			pGrdChild=pCurChild->getChild(NAME_LEFT);
			pCurChild->setChild(NAME_LEFT, pGrdChild->getChild(NAME_RIGHT));
			pCurrent->setChild(NAME_RIGHT, pGrdChild->getChild(NAME_LEFT));
			pGrdChild->setChild(NAME_RIGHT, pCurChild);
			pGrdChild->setChild(NAME_LEFT, pCurrent);

			switch(pGrdChild->getNameFactor()){
				case 1:
					{
						pCurrent->setNameFactor(1);
						pCurChild->setNameFactor(0);
						break;
					}
				case -1:
					{
						pCurrent->setNameFactor(0);
						pCurChild->setNameFactor(-1);
						break;
					}
				case 0:
					{
						pCurrent->setNameFactor(0);
						pCurChild->setNameFactor(0);
						break;
					}
			}
			pGrdChild->setNameFactor(0);
			pCurChild=pGrdChild;
		} //End of RL
	}

	if(!pParrent){
		root_name=pCurChild;
	}
	else if(pCurrent==pParrent->getChild(NAME_LEFT)){
		pParrent->setChild(NAME_LEFT, pCurChild);
	}
	else{
		pParrent->setChild(NAME_RIGHT, pCurChild);
	}

	return true;
}

bool AVL::InsertPhone(AVL_Node *pNew){
	AVL_Node *pCurrent=root_phone; //current node with bf=1 or br=-1
	AVL_Node *pParrent=NULL; //parrent of pCurrent
	AVL_Node *pWalker=root_phone; //pointer for moving through the tree
	AVL_Node *pWalParrent=NULL; //parrent of pWalker

	while(pWalker){ //while pWalker is not NULL
		if(pWalker->getPhoneFactor()){ //if bf of pWalker is not 0
			pCurrent=pWalker;
			pParrent=pWalParrent;
		}
		if(strcmp(pWalker->getPhoneNum(),pNew->getPhoneNum())>0){ //if new data is smaller than data of pWalker
			pWalParrent=pWalker;
			pWalker=pWalker->getChild(PHONE_LEFT); //go to LEFT child
		}
		else{ //if new data is bigger than data of pWalker
			pWalParrent=pWalker;
			pWalker=pWalker->getChild(PHONE_RIGHT); //go to RIGHT child
		}
	} //End of while

	if(strcmp(pWalParrent->getPhoneNum(),pNew->getPhoneNum())>0){ //set LEFT child
		pWalParrent->setChild(PHONE_LEFT, pNew);
	}
	else{ //set RIGHT child
		pWalParrent->setChild(PHONE_RIGHT, pNew);
	}

	//rebalance
	int bfDef=0; //balance factor definition
	AVL_Node *pCurChild=NULL; //child of pCurrent
	AVL_Node *pGrdChild=NULL; //child of pCurChild

	if(strcmp(pCurrent->getPhoneNum(),pNew->getPhoneNum())<0){
		pCurChild=pWalker=pCurrent->getChild(PHONE_RIGHT);
		bfDef=-1;
	}
	else{
		pCurChild=pWalker=pCurrent->getChild(PHONE_LEFT);
		bfDef=1;
	}

	while(pWalker!=pNew){
		if(strcmp(pWalker->getPhoneNum(),pNew->getPhoneNum())<0){ //height of RIGHT added
			pWalker->setPhoneFactor(-1);
			pWalker=pWalker->getChild(PHONE_RIGHT);
		}
		else{ //height of LEFT added
			pWalker->setPhoneFactor(1);
			pWalker=pWalker->getChild(PHONE_LEFT);
		}
	}

	if(!(pCurrent->getPhoneFactor())||!(pCurrent->getPhoneFactor()+bfDef)){ //tree is balanced
		pCurrent->setPhoneFactor(pCurrent->getPhoneFactor()+bfDef);
		return true;
	}
	if(bfDef==1){ //LEFT imbalance
		if(pCurChild->getPhoneFactor()==1){ //LL
			pCurrent->setChild(PHONE_LEFT, pCurChild->getChild(PHONE_RIGHT));
			pCurChild->setChild(PHONE_RIGHT, pCurrent);
			pCurrent->setPhoneFactor(0);
			pCurChild->setPhoneFactor(0);
		} //End of LL
		else { //LR
			pGrdChild=pCurChild->getChild(PHONE_LEFT);
			pCurChild->setChild(PHONE_RIGHT, pGrdChild->getChild(PHONE_LEFT));
			pCurrent->setChild(PHONE_LEFT, pGrdChild->getChild(PHONE_RIGHT));
			pGrdChild->setChild(PHONE_LEFT, pCurChild);
			pGrdChild->setChild(PHONE_RIGHT, pCurrent);

			switch(pGrdChild->getPhoneFactor()){
				case 1:
					{
						pCurrent->setPhoneFactor(-1);
						pCurChild->setPhoneFactor(0);
						break;
					}
				case -1:
					{
						pCurrent->setPhoneFactor(0);
						pCurChild->setPhoneFactor(1);
						break;
					}
				case 0:
					{
						pCurrent->setPhoneFactor(0);
						pCurChild->setPhoneFactor(0);
						break;
					}
			}
			pGrdChild->setPhoneFactor(0);
			pCurChild=pGrdChild;
		} //End of LR
	}
	else{ //RIGHT imbalance
		if(pCurChild->getPhoneFactor()==-1){ //RR
			pCurrent->setChild(PHONE_RIGHT, pCurChild->getChild(PHONE_LEFT));
			pCurChild->setChild(PHONE_LEFT, pCurrent);
			pCurrent->setPhoneFactor(0);
			pCurChild->setPhoneFactor(0);
		} //End of RR
		else { //RL
			pGrdChild=pCurChild->getChild(PHONE_RIGHT);
			pCurChild->setChild(PHONE_LEFT, pGrdChild->getChild(PHONE_RIGHT));
			pCurrent->setChild(PHONE_RIGHT, pGrdChild->getChild(PHONE_LEFT));
			pGrdChild->setChild(PHONE_RIGHT, pCurChild);
			pGrdChild->setChild(PHONE_LEFT, pCurrent);

			switch(pGrdChild->getPhoneFactor()){
				case 1:
					{
						pCurrent->setPhoneFactor(1);
						pCurChild->setPhoneFactor(0);
						break;
					}
				case -1:
					{
						pCurrent->setPhoneFactor(0);
						pCurChild->setPhoneFactor(-1);
						break;
					}
				case 0:
					{
						pCurrent->setPhoneFactor(0);
						pCurChild->setPhoneFactor(0);
						break;
					}
			}
			pGrdChild->setPhoneFactor(0);
			pCurChild=pGrdChild;
		} //End of RL
	}

	if(!pParrent){
		root_phone=pCurChild;
	}
	else if(pCurrent==pParrent->getChild(PHONE_LEFT)){
		pParrent->setChild(PHONE_LEFT, pCurChild);
	}
	else{
		pParrent->setChild(PHONE_RIGHT, pCurChild);
	}

	return true;
}

bool AVL::Delete(char* firstName, char* lastName){
	if(!SearchOverlap(firstName, lastName)){
		return false;
	}
	if(!Delete(firstName, lastName, NULL)){
		return false;
	}
	return true;
}

bool AVL::Delete(char* firstName, char* lastName, char* subKey){
	AVL_Node *pDelete=NULL; //delete node
	AVL_Node *pDelParrent=NULL; //parrent of delete node
	AVL_Node *pCurrent=root_name; //current node with bf=0
	AVL_Node *pWalker=root_name; //pointer for moving through the tree
	AVL_Node *pWalParrent=NULL; //parrent of pWalker

	while(pWalker){ //while pWalker is not NULL
		if(pWalker->getNameFactor()){ //if bf of pWalker is not 0
			pCurrent=pWalker;
		}
		if(strcmp(pWalker->getLastName(),lastName)>0){ //if find data is smaller than data of pWalker
			pWalParrent=pWalker;
			pWalker=pWalker->getChild(NAME_LEFT); //go to LEFT child
		}
		else if(strcmp(pWalker->getLastName(),lastName)<0){ //if find data is bigger than data of pWalker
			pWalParrent=pWalker;
			pWalker=pWalker->getChild(NAME_RIGHT); //go to RIGHT child
		}
		else{
			if(strcmp(pWalker->getFirstName(),firstName)>0){ //if find data is smaller than data of pWalker
				pWalParrent=pWalker;
				pWalker=pWalker->getChild(NAME_LEFT); //go to LEFT child
			}
			else if(strcmp(pWalker->getFirstName(),firstName)<0){ //if find data is bigger than data of pWalker
				pWalParrent=pWalker;
				pWalker=pWalker->getChild(NAME_RIGHT); //go to RIGHT child
			}
			else{
				if(strcmp(pWalker->getPhoneNum(),subKey)>0){ //if find data is smaller than data of pWalker
					pWalParrent=pWalker;
					pWalker=pWalker->getChild(NAME_LEFT); //go to LEFT child
				}
				else if(strcmp(pWalker->getPhoneNum(),subKey)<0){ //if find data is bigger than data of pWalker
					pWalParrent=pWalker;
					pWalker=pWalker->getChild(NAME_RIGHT); //go to RIGHT child
				}
				else{ //find node
					pDelete=pWalker;
					pDelParrent=pWalParrent;
					break;
				}
			}
		}
	} //End of while

	if(!(pDelete->getChild(NAME_LEFT))&&!(pDelete->getChild(NAME_RIGHT))){ //if pDelete has no child
		if(pDelete==root_name){
			root_name=NULL;
			if(deleteCall==0){
				deleteCall=1;
				Delete(pDelete->getPhoneNum());
			}
			else{
				deleteCall=0;
				delete pDelete;
			}

			return true;
		}
		else if(pDelete==pDelParrent->getChild(NAME_RIGHT)){
			pDelParrent->setChild(NAME_RIGHT, NULL);
		}
		else{
			pDelParrent->setChild(NAME_LEFT, NULL);
		}

		if(pWalParrent->getNameFactor()==0){
			pCurrent=pWalParrent;
		}
		if(strcmp(pWalParrent->getLastName(),pDelete->getLastName())>0){
			pWalParrent->setNameFactor(pWalParrent->getNameFactor()-1);
		}
		else if(strcmp(pWalParrent->getLastName(),pDelete->getLastName())<0){
			pWalParrent->setNameFactor(pWalParrent->getNameFactor()+1);
		}
		else{
			if(strcmp(pWalParrent->getFirstName(),pDelete->getFirstName())>0){
				pWalParrent->setNameFactor(pWalParrent->getNameFactor()-1);
			}
			else if(strcmp(pWalParrent->getFirstName(),pDelete->getFirstName())<0){
				pWalParrent->setNameFactor(pWalParrent->getNameFactor()+1);
			}
			else{
				if(strcmp(pWalParrent->getPhoneNum(),pDelete->getPhoneNum())>0){
					pWalParrent->setNameFactor(pWalParrent->getNameFactor()-1);
				}
				else{
					pWalParrent->setNameFactor(pWalParrent->getNameFactor()+1);
				}
			}
		}

		while(pCurrent!=pWalParrent){
			if(strcmp(pCurrent->getLastName(),pDelete->getLastName())>0){
				pCurrent->setNameFactor(pCurrent->getNameFactor()-1);
				pCurrent=pCurrent->getChild(NAME_LEFT);
			}
			else if(strcmp(pCurrent->getLastName(),pDelete->getLastName())<0){
				pCurrent->setNameFactor(pCurrent->getNameFactor()+1);
				pCurrent=pCurrent->getChild(NAME_RIGHT);
			}
			else{
				if(strcmp(pCurrent->getFirstName(),pDelete->getFirstName())>0){
					pCurrent->setNameFactor(pCurrent->getNameFactor()-1);
					pCurrent=pCurrent->getChild(NAME_LEFT);
				}
				else if(strcmp(pCurrent->getFirstName(),pDelete->getFirstName())<0){
					pCurrent->setNameFactor(pCurrent->getNameFactor()+1);
					pCurrent=pCurrent->getChild(NAME_RIGHT);
				}
				else{
					if(strcmp(pCurrent->getPhoneNum(),pDelete->getPhoneNum())>0){
						pCurrent->setNameFactor(pCurrent->getNameFactor()-1);
						pCurrent=pCurrent->getChild(NAME_LEFT);
					}
					else{
						pCurrent->setNameFactor(pCurrent->getNameFactor()+1);
						pCurrent=pCurrent->getChild(NAME_RIGHT);
					}
				}
			}
		} //End of while
	}
	else{ //pDelete has child
		if(pDelete->getChild(NAME_LEFT)){ //pDelete has left child
			pWalker=pDelete->getChild(NAME_LEFT); //replace node
			pWalParrent=pDelete; //parrent of pWalker

			while(pWalker->getChild(NAME_RIGHT)){ //while right child of pWalker is not NULL
				pWalParrent=pWalker;
				pWalker=pWalker->getChild(NAME_RIGHT);
			}

			if(pWalker==pDelete->getChild(NAME_LEFT)){ //if left node of pDelete has not right node
				pDelete->setChild(NAME_LEFT, pWalker->getChild(NAME_LEFT));
			}
			else{ //if left node of pDelete has right node
				pWalParrent->setChild(NAME_RIGHT, NULL);
			}
			pWalker->setChild(NAME_LEFT, pDelete->getChild(NAME_LEFT));
			pWalker->setChild(NAME_RIGHT, pDelete->getChild(NAME_RIGHT));
		}
		else{ //pDelete has only right child
			pWalker=pDelete->getChild(NAME_RIGHT); //replace node
			pWalParrent=pDelete; //parrent of pWalker
		}

		pDelete->setChild(NAME_LEFT, NULL);
		pDelete->setChild(NAME_RIGHT, NULL);

		if(pDelete==root_name){ //change root
			root_name=pWalker;
		}
		else if(pDelete==pDelParrent->getChild(NAME_RIGHT)){
			pDelParrent->setChild(NAME_RIGHT, pWalker);
		}
		else{
			pDelParrent->setChild(NAME_LEFT, pWalker);
		}
		
		pWalker->setNameFactor(pDelete->getNameFactor());

		if(pWalParrent->getNameFactor()==0){
			pCurrent=pWalParrent;
		}
		if(pWalParrent==pDelete){ //if pWalParrent is pDelete
			if(strcmp(pDelete->getLastName(),pWalker->getLastName())>0){
				pWalker->setNameFactor(pWalker->getNameFactor()-1);
			}
			else if(strcmp(pDelete->getLastName(),pWalker->getLastName())<0){
				pWalker->setNameFactor(pWalker->getNameFactor()+1);
			}
			else{
				if(strcmp(pDelete->getFirstName(),pWalker->getFirstName())>0){
					pWalker->setNameFactor(pWalker->getNameFactor()-1);
				}
				else if(strcmp(pDelete->getFirstName(),pWalker->getFirstName())<0){
					pWalker->setNameFactor(pWalker->getNameFactor()+1);
				}
				else{
					if(strcmp(pDelete->getPhoneNum(),pWalker->getPhoneNum())>0){
						pWalker->setNameFactor(pWalker->getNameFactor()-1);
					}
					else{
						pWalker->setNameFactor(pWalker->getNameFactor()+1);
					}
				}
			}
			if(pWalParrent==pCurrent){
				pCurrent=pWalker;
			}
			pWalParrent=pWalker;
		}
		else if(strcmp(pWalParrent->getLastName(),pWalker->getLastName())>0){
			pWalParrent->setNameFactor(pWalker->getNameFactor()-1);
		}
		else if(strcmp(pWalParrent->getLastName(),pWalker->getLastName())<0){
			pWalParrent->setNameFactor(pWalker->getNameFactor()+1);
		}
		else{
			if(strcmp(pWalParrent->getFirstName(),pWalker->getFirstName())>0){
				pWalParrent->setNameFactor(pWalker->getNameFactor()-1);
			}
			else if(strcmp(pWalParrent->getFirstName(),pWalker->getFirstName())<0){
				pWalParrent->setNameFactor(pWalker->getNameFactor()+1);
			}
			else{
				if(strcmp(pWalParrent->getPhoneNum(),pWalker->getPhoneNum())>0){
					pWalParrent->setNameFactor(pWalker->getNameFactor()-1);
				}
				else{
					pWalParrent->setNameFactor(pWalker->getNameFactor()+1);
				}
			}
		}

		while(pCurrent!=pWalParrent){
			if(strcmp(pCurrent->getLastName(),pWalParrent->getLastName())>0){
				pCurrent->setNameFactor(pCurrent->getNameFactor()-1);
				pCurrent=pCurrent->getChild(NAME_LEFT);
			}
			else if(strcmp(pCurrent->getLastName(),pWalParrent->getLastName())<0){
				pCurrent->setNameFactor(pCurrent->getNameFactor()+1);
				pCurrent=pCurrent->getChild(NAME_RIGHT);
			}
			else{
				if(strcmp(pCurrent->getFirstName(),pWalParrent->getFirstName())>0){
					pCurrent->setNameFactor(pCurrent->getNameFactor()-1);
					pCurrent=pCurrent->getChild(NAME_LEFT);
				}
				else if(strcmp(pCurrent->getFirstName(),pWalParrent->getFirstName())<0){
					pCurrent->setNameFactor(pCurrent->getNameFactor()+1);
					pCurrent=pCurrent->getChild(NAME_RIGHT);
				}
				else{
					if(strcmp(pCurrent->getPhoneNum(),pWalParrent->getPhoneNum())>0){
						pCurrent->setNameFactor(pCurrent->getNameFactor()-1);
						pCurrent=pCurrent->getChild(NAME_LEFT);
					}
					else{
						pCurrent->setNameFactor(pCurrent->getNameFactor()+1);
						pCurrent=pCurrent->getChild(NAME_RIGHT);
					}
				}
			}
		} //End of while
	}

	if(deleteCall==0){
		deleteCall=1;
		Delete(pDelete->getPhoneNum());
	}
	else{
		deleteCall=0;
		delete pDelete;
	}

	return true;
}

bool AVL::Delete(char* phoneNum){
	AVL_Node *pDelete=NULL; //delete node
	AVL_Node *pDelParrent=NULL; //parrent of delete node
	AVL_Node *pCurrent=root_phone; //current node with bf=0
	AVL_Node *pWalker=root_phone; //pointer for moving through the tree
	AVL_Node *pWalParrent=NULL; //parrent of pWalker

	while(pWalker){ //while pWalker is not NULL
		if(!pWalker->getPhoneFactor()){ //if bf of pWalker is 0
			pCurrent=pWalker;
		}
		if(strcmp(pWalker->getPhoneNum(),phoneNum)>0){ //if new data is smaller than data of pWalker
			pWalParrent=pWalker;
			pWalker=pWalker->getChild(PHONE_LEFT); //go to LEFT child
		}
		else if(strcmp(pWalker->getPhoneNum(),phoneNum)<0){ //if new data is bigger than data of pWalker
			pWalParrent=pWalker;
			pWalker=pWalker->getChild(PHONE_RIGHT); //go to RIGHT child
		}
		else{
			pDelete=pWalker;
			pDelParrent=pWalParrent;
			break;
		}
	} //End of while

	if(!(pDelete->getChild(PHONE_LEFT))&&!(pDelete->getChild(PHONE_RIGHT))){
		if(pDelete==root_phone){
			root_phone=NULL;
			if(deleteCall==0){
				deleteCall=1;
				Delete(pDelete->getFirstName(), pDelete->getLastName(), pDelete->getPhoneNum());
			}
			else{
				deleteCall=0;
				delete pDelete;
			}

			return true;
		}
		else if(pDelete==pDelParrent->getChild(PHONE_RIGHT)){
			pDelParrent->setChild(PHONE_RIGHT, NULL);
		}
		else{
			pDelParrent->setChild(PHONE_LEFT, NULL);
		}

		if(pWalParrent->getPhoneFactor()==0){
			pCurrent=pWalParrent;
		}
		if(strcmp(pWalParrent->getPhoneNum(),pDelete->getPhoneNum())>0){
			pWalParrent->setPhoneFactor(pWalParrent->getPhoneFactor()-1);
		}
		else{
			pWalParrent->setPhoneFactor(pWalParrent->getPhoneFactor()+1);
		}

		while(pCurrent!=pWalParrent){
			if(strcmp(pCurrent->getPhoneNum(),pDelete->getPhoneNum())>0){
				pCurrent->setPhoneFactor(pCurrent->getPhoneFactor()-1);
				pCurrent=pCurrent->getChild(PHONE_LEFT);
			}
			else{
				pCurrent->setPhoneFactor(pCurrent->getPhoneFactor()+1);
				pCurrent=pCurrent->getChild(PHONE_RIGHT);
			}
		} //End of while
	}
	else{ //pDelete has child
		if(pDelete->getChild(PHONE_LEFT)){ //pDelete has left child
			pWalker=pDelete->getChild(PHONE_LEFT); //replace node
			pWalParrent=pDelete; //parrent of pWalker

			while(pWalker->getChild(PHONE_RIGHT)){ //while right child of pWalker is not NULL
				pWalParrent=pWalker;
				pWalker=pWalker->getChild(PHONE_RIGHT);
			}

			if(pWalker==pDelete->getChild(PHONE_LEFT)){ //if left node of pDelete has not right node
				pDelete->setChild(PHONE_LEFT, pWalker->getChild(PHONE_LEFT));
			}
			else{ //if left node of pDelete has right node
				pWalParrent->setChild(PHONE_RIGHT, NULL);
			}
			pWalker->setChild(PHONE_LEFT, pDelete->getChild(PHONE_LEFT));
			pWalker->setChild(PHONE_RIGHT, pDelete->getChild(PHONE_RIGHT));
		}
		else{ //pDelete has only right child
			pWalker=pDelete->getChild(PHONE_RIGHT); //replace node
			pWalParrent=pDelete; //parrent of pWalker
		}

		pDelete->setChild(PHONE_LEFT, NULL);
		pDelete->setChild(PHONE_RIGHT, NULL);

		if(pDelete==root_phone){ //change root
			root_phone=pWalker;
		}
		else if(pDelete==pDelParrent->getChild(PHONE_RIGHT)){
			pDelParrent->setChild(PHONE_RIGHT, pWalker);
		}
		else{
			pDelParrent->setChild(PHONE_LEFT, pWalker);
		}
		
		pWalker->setPhoneFactor(pDelete->getPhoneFactor());

		if(pWalParrent->getPhoneFactor()==0){
			pCurrent=pWalParrent;
		}
		if(pWalParrent==pDelete){ //if pWalParrent is pDelete
			if(strcmp(pDelete->getPhoneNum(),pWalker->getPhoneNum())>0){
				pWalker->setPhoneFactor(pWalker->getPhoneFactor()-1);
			}
			else{
				pWalker->setPhoneFactor(pWalker->getPhoneFactor()+1);
			}
			if(pWalParrent==pCurrent){
				pCurrent=pWalker;
			}
			pWalParrent=pWalker;
		}
		else if(strcmp(pWalParrent->getPhoneNum(),pWalker->getPhoneNum())>0){
			pWalParrent->setPhoneFactor(pWalParrent->getPhoneFactor()-1);
		}
		else{
			pWalParrent->setPhoneFactor(pWalParrent->getPhoneFactor()+1);
		}

		while(pCurrent!=pWalParrent){
			if(strcmp(pCurrent->getPhoneNum(),pWalParrent->getPhoneNum())>0){
				pCurrent->setPhoneFactor(pCurrent->getPhoneFactor()-1);
				pCurrent=pCurrent->getChild(PHONE_LEFT);
			}
			else{
				pCurrent->setPhoneFactor(pCurrent->getPhoneFactor()+1);
				pCurrent=pCurrent->getChild(PHONE_RIGHT);
			}
		} //End of while
	}

	if(deleteCall==0){
		deleteCall=1;
		Delete(pDelete->getFirstName(), pDelete->getLastName(), pDelete->getPhoneNum());
	}
	else{
		deleteCall=0;
		delete pDelete;
	}

	return true;
}

bool AVL::UpdateName(char* firstName, char* lastName, char* newPhoneNum, char* newAddress){ //Udpate Node without subkey
	if(!SearchOverlap(firstName, lastName)){
		return false;
	}
	if(!UpdateName(firstName, lastName, NULL, newPhoneNum, newAddress)){
		return false;
	}
	return true;
}
bool AVL::UpdateName(char* firstName, char* lastName, char* subKey, char* newPhoneNum, char* newAddress){ //Udpate Node
	AVL_Node *pWalker=root_name; //pointer for moving through the tree

	while(pWalker){ //while pWalker is not NULL
		if(strcmp(pWalker->getLastName(),lastName)>0){ //if find data is smaller than data of pWalker
			pWalker=pWalker->getChild(NAME_LEFT); //go to LEFT child
		}
		else if(strcmp(pWalker->getLastName(),lastName)<0){ //if find data is bigger than data of pWalker
			pWalker=pWalker->getChild(NAME_RIGHT); //go to RIGHT child
		}
		else{
			if(strcmp(pWalker->getFirstName(),firstName)>0){ //if find data is smaller than data of pWalker
				pWalker=pWalker->getChild(NAME_LEFT); //go to LEFT child
			}
			else if(strcmp(pWalker->getFirstName(),firstName)<0){ //if find data is bigger than data of pWalker
				pWalker=pWalker->getChild(NAME_RIGHT); //go to RIGHT child
			}
			else{
				if(subKey&&strcmp(pWalker->getPhoneNum(),subKey)>0){ //if find data is smaller than data of pWalker
					pWalker=pWalker->getChild(NAME_LEFT); //go to LEFT child
				}
				else if(subKey&&strcmp(pWalker->getPhoneNum(),subKey)<0){ //if find data is bigger than data of pWalker
					pWalker=pWalker->getChild(NAME_RIGHT); //go to RIGHT child
				}
				else{ //find node
					pWalker->setPhoneNum(newPhoneNum);
					pWalker->setAddress(newAddress);

					return true;
				}
			}
		}
	} //End of while

	return false;
}
bool AVL::UpdatePhone(char* phoneNum, char* newAddress){ //Udpate phone
	AVL_Node *pWalker=root_phone; //pointer for moving through the tree

	while(pWalker){ //while pWalker is not NULL
		if(strcmp(pWalker->getPhoneNum(),phoneNum)>0){ //if new data is smaller than data of pWalker
			pWalker=pWalker->getChild(PHONE_LEFT); //go to LEFT child
		}
		else if(strcmp(pWalker->getPhoneNum(),phoneNum)<0){ //if new data is bigger than data of pWalker
			pWalker=pWalker->getChild(PHONE_RIGHT); //go to RIGHT child
		}
		else{ //find node
			pWalker->setAddress(newAddress);

			return true;
		}
	} //End of while

}

bool AVL::PrintAll(){
	if(!root_name){
		return false;
	}

	PrintName(NULL, NULL, NULL);
	PrintPhone(NULL);

	return true;
}

bool AVL::PrintName(char* lastName){
	if(!PrintName(NULL, lastName, NULL)){
		return false;
	}
	return true;
}

bool AVL::PrintName(char* firstName, char* lastName){
	if(!SearchOverlap(firstName, lastName)){
		return false;
	}
	if(!PrintName(firstName, lastName, NULL)){
		return false;
	}
	return true;
}

bool AVL::PrintName(char* firstName, char* lastName, char* subKey){
	stack<AVL_Node*> avlStack;
	AVL_Node *pWalker=root_name;

	if(!root_name){
		return false;
	}
	if(firstName&&!subKey&&!SearchOverlap(firstName, lastName)){
		return false;
	}

	cout.setf(ios::left);
	cout<<"================================================================"<<endl<<endl;
	cout<<setw(4)<<"   "<<setw(20)<<"Name"<<setw(15)<<"Phone-number"<<setw(25)<<"Address"<<endl<<endl;
	cout<<"================================================================"<<endl<<endl;

	while(true){
		while(pWalker){
			avlStack.push(pWalker);
			pWalker=pWalker->getChild(NAME_LEFT); 
		}

		if(avlStack.empty()){
			cout<<endl;
			return true;
		}
		pWalker=avlStack.top();
		avlStack.pop();

		if(firstName){
			if(!(strcmp(pWalker->getLastName(),lastName))&&!(strcmp(pWalker->getFirstName(),firstName))){
				if(!subKey){
					cout.setf(ios::left);
					cout<<setw(4)<<"   "<<setw(10)<<pWalker->getFirstName()<<setw(10)<<pWalker->getLastName()<<setw(15)<<pWalker->getPhoneNum()<<setw(25)<<pWalker->getAddress()<<endl;
				}
				else if(!(strcmp(pWalker->getPhoneNum(),subKey))){
					cout.setf(ios::left);
					cout<<setw(4)<<"   "<<setw(10)<<pWalker->getFirstName()<<setw(10)<<pWalker->getLastName()<<setw(15)<<pWalker->getPhoneNum()<<setw(25)<<pWalker->getAddress()<<endl;
				}
			}
		}
		else if(lastName){
			if(!(strcmp(pWalker->getLastName(),lastName))){
				cout.setf(ios::left);
				cout<<setw(4)<<"   "<<setw(10)<<pWalker->getFirstName()<<setw(10)<<pWalker->getLastName()<<setw(15)<<pWalker->getPhoneNum()<<setw(25)<<pWalker->getAddress()<<endl;
			}
		}
		else{
			cout.setf(ios::left);
			cout<<setw(4);
			if(pWalker==root_name){
				cout<<"(*)";
			}
			else{
				cout<<"   ";
			}
			cout<<setw(10)<<pWalker->getFirstName()<<setw(10)<<pWalker->getLastName()<<setw(15)<<pWalker->getPhoneNum()<<setw(25)<<pWalker->getAddress()<<endl;
		}

		pWalker=pWalker->getChild(NAME_RIGHT);
	}
}

bool AVL::PrintPhone(char* phoneNum){
	stack<AVL_Node*> avlStack;
	AVL_Node *pWalker=root_phone;

	if(!root_phone){
		return false;
	}

	cout.setf(ios::left);
	cout<<"================================================================"<<endl<<endl;
	cout<<setw(4)<<"   "<<setw(20)<<"Name"<<setw(15)<<"Phone-number"<<setw(25)<<"Address"<<endl<<endl;
	cout<<"================================================================"<<endl<<endl;

	while(true){
		while(pWalker){
			avlStack.push(pWalker);
			pWalker=pWalker->getChild(PHONE_LEFT); 
		}

		if(avlStack.empty()){
			return true;
		}
		pWalker=avlStack.top();
		avlStack.pop();

		if(!phoneNum){
			cout.setf(ios::left);
			cout<<setw(4);
			if(pWalker==root_phone){
				cout<<"(*)";
			}
			else{
				cout<<"   ";
			}
			cout<<setw(10)<<pWalker->getFirstName()<<setw(10)<<pWalker->getLastName()<<setw(15)<<pWalker->getPhoneNum()<<setw(25)<<pWalker->getAddress()<<endl;
		}
		else if(!strcmp(pWalker->getPhoneNum(),phoneNum)){
			cout.setf(ios::left);
			cout<<setw(4)<<"   "<<setw(10)<<pWalker->getFirstName()<<setw(10)<<pWalker->getLastName()<<setw(15)<<pWalker->getPhoneNum()<<setw(25)<<pWalker->getAddress()<<endl;
		}

		pWalker=pWalker->getChild(PHONE_RIGHT);
	}
}

bool AVL::SearchOverlap(char* firstName, char* lastName){ //Search overlapped node
	int checkOverlap=0;
	stack<AVL_Node*> avlStack;
	AVL_Node *pWalker=root_name;

	while(true){
		while(pWalker){
			avlStack.push(pWalker);
			pWalker=pWalker->getChild(NAME_LEFT); 
		}

		if(avlStack.empty()){
			return true;
		}
		pWalker=avlStack.top();
		avlStack.pop();

		if(!strcmp(pWalker->getLastName(),lastName)&&!strcmp(pWalker->getFirstName(),firstName)){
			if(checkOverlap==0){
				checkOverlap++;
			}
			else{
				while(!avlStack.empty()){
					avlStack.pop();
				}
				return false;
			}
		}
		pWalker=pWalker->getChild(NAME_RIGHT);
	}
}