#include "BST.h"
#include <string.h>
#include <iostream>
using namespace std;

BST::BST()
{
	root=NULL;
}

BST::~BST()
{
	delete root;
}

bool BST::Insert(char ch){
	BST_Node *p=root;
	BST_Node *q=0;

	while(p){
		q=p;
		if(p->ch_element==ch) return false;
		if(p->ch_element<ch)
			p=p->pChild[1];
		else
			p=p->pChild[0];
	}
	BST_Node *pNode=new BST_Node(ch);
	p=pNode;

	if(!root) root=p;
	else if(ch<q->ch_element) q->pChild[0]=p;
	else q->pChild[1]=p;

	return true;
}

void BST::Print(){
	PrintChar(root);
}

void BST::PrintChar(BST_Node *CurrentNode){
	if(CurrentNode){
		PrintChar(CurrentNode->pChild[0]);
		cout<<CurrentNode->ch_element;
		PrintChar(CurrentNode->pChild[1]);
	}
}

bool BST::Search(char ch){
	BST_Node *p=root;
	BST_Node *q=0;

	while(p){
		q=p;
		if(p->ch_element==ch) return true;
		if(p->ch_element<ch)
			p=p->pChild[1];
		else
			p=p->pChild[0];
	}
}
