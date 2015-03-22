#include "QueueStack.h"
#include<iostream>
using namespace std;

QueueStack::QueueStack(void){
  m_pHead=NULL;
}

QueueStack::~QueueStack(void){
  Node* temp=NULL;

  while(m_pHead!=NULL){
    temp=m_pHead;
    m_pHead=m_pHead->GetNext();
    delete temp;
  }
}

void QueueStack::Insert(Node* pNew){
  if(m_pHead!=NULL){ //If there is node in m_pHead, push m_pHead and insert new node of coordinate
    pNew->SetNext(m_pHead);
    m_pHead->SetPrev(pNew);
  }
  m_pHead=pNew; //Change m_pHead
}
Node* QueueStack::PopFront(){
  if(m_pHead==NULL)
    return m_pHead;
  else{
    Node* temp=m_pHead; //Temporary node for pop

    m_pHead=m_pHead->GetNext(); //Move head to next node
    temp->SetNext(NULL); //Cut list from temp

    if(m_pHead!=NULL)
      m_pHead->SetPrev(NULL); //Cut temp from list

    return temp; //Retuen temp
  }
}
Node* QueueStack::PopBack(){
  if(m_pHead==NULL) //If there are any nodes, retuen NULL
    return m_pHead;
  else{
    Node* temp=m_pHead; //Temporary node for pop

    while(temp->GetNext()!=NULL) //Move to last node
      temp=temp->GetNext();

    if(temp!=m_pHead){
      temp->GetPrev()->SetNext(NULL); //Cut temp from list
      temp->SetPrev(NULL); //Cut list from temp
    }
    else
      m_pHead=NULL; //Change m_pHead

    return temp; //Retuen temp
  }
}