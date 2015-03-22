#include "Node.h"
#include<iostream>
using namespace std;

Node::Node(void){
  m_posX=0;
  m_posY=0;
  m_pNext=NULL;
  m_pPrev=NULL;
}

Node::~Node(void){
  m_posX=0;
  m_posY=0;
  m_pNext=NULL;
  m_pPrev=NULL;
}

void Node::SetPos(int x, int y){
  m_posX=x; //Input pPrev into m_pPrev
  m_posY=y; //Input pPrev into m_pPrev
}
int Node::GetPosX(){
  return m_posX; //Return m_posX
}
int Node::GetPosY(){
  return m_posY; //Return m_posY
}
void Node::SetNext(Node* pNext){
  m_pNext=pNext; //Input pNext into m_pNext
}
void Node::SetPrev(Node* pPrev){
  m_pPrev=pPrev; //Input pPrev into m_pPrev
}
Node* Node::GetNext(){
  return m_pNext; //Return m_pNext
}
Node* Node::GetPrev(){
  return m_pPrev; //Return m_pPrev
}