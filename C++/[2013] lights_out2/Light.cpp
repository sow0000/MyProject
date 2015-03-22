#include "Light.h"
#include<iostream>
using namespace std;

Light::Light(void){
  m_pRight=NULL; 
  m_pLeft=NULL;
  m_pAbove=NULL; 
  m_pBottom=NULL;
  m_state=0;
}

Light::~Light(void){
  m_pRight=NULL; 
  m_pLeft=NULL;
  m_pAbove=NULL; 
  m_pBottom=NULL;
  m_state=0;
}
void Light::SetState(int state){
  m_state=state; //Input state into m_state
}
int Light::GetState(){
  return m_state; //Return m_state
}
void Light::SetRight(Light* pRight){
  m_pRight=pRight; //Input pRight into m_pRight
}
void Light::SetLeft(Light* pLeft){
  m_pLeft=pLeft; //Input pLeft into m_pLeft
}
void Light::SetAbove(Light* pAbove){
  m_pAbove=pAbove; //Input pAbove into m_pAbove
}
void Light::SetBottom(Light* pBottom){
  m_pBottom=pBottom; //Input pBottom into m_pBottom
}
Light* Light::GetRight(){
  return m_pRight; //Return m_pRight
}
Light* Light::GetLeft(){
  return m_pLeft; //Return m_pLeft
}
Light* Light::GetAbove(){
  return m_pAbove; //Return m_pAbove
}
Light* Light::GetBottom(){
  return m_pBottom; //Return m_pBottom
}