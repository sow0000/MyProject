#include "LightsOut.h"
#include<windows.h>
#include<iostream>
#include<fstream>
using namespace std;

void Lgotoxy(int x, int y){  //커서 이동용 함수
  COORD XY={x,y};
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),XY);
}

LightsOut::LightsOut(void){
  m_pHead=NULL;
  m_undoCnt=0;
  m_mapID=0;
  m_minCnt=0;
  m_userCnt=0;
}

LightsOut::~LightsOut(void){
  Light *temp=m_pHead, *tHead=m_pHead;

  while(tHead!=NULL){
    tHead=tHead->GetBottom();
    while(m_pHead!=NULL){
      temp=m_pHead;
      m_pHead=m_pHead->GetRight();
      delete temp;
    }
    m_pHead=tHead;
  }
  m_undoCnt=0;
  m_mapID=0;
  m_minCnt=0;
  m_userCnt=0;
}

void LightsOut::ping(int x ,int y, int c){
  Light* temp=m_pHead; //Temporary node for find coordination

  for(int i=0;i<x;i++)
    temp=temp->GetRight(); //Move right
  for(int i=0;i<y;i++)
    temp=temp->GetBottom(); //Move bottom

  if(c==0){
    Lgotoxy(23+x*4,y+1);
    cout<<"  ";
  }
  else if(c==1){
    Lgotoxy(23+x*4,y+1);
    if(temp->GetState()==0)
      cout<<"□";
    else
      cout<<"■";
  }
}

bool LightsOut::LoadMap(char* fname){
  if(m_pHead!=NULL){ //If there is loaded map, replace map
    Reset(); //Reset m_qsPosLog

    Light *temp=m_pHead, *tHead=m_pHead;

    while(tHead!=NULL){ //Reset all nodes in list
      tHead=tHead->GetBottom();
      while(m_pHead!=NULL){
        temp=m_pHead;
        m_pHead=m_pHead->GetRight();
        delete temp;
      }
      m_pHead=tHead;
    }
    m_mapID=0; //Reset map ID
    m_minCnt=0; //Reset minimum count
  }

  int l=0; //l=>Variable for line number
  char ln[64], *ch=NULL; //ln=>Array for read line; ch=>pointer for compare
  ifstream f; //Object for open file
  f.open(fname); //Open file

  if(!f.is_open()) //If there is no file, stop the program
    return false;

  Light *tHead=NULL, *temp=NULL, *ltemp=NULL; //tHead->Head of final line; temp->Node for temporary pointer; ltemp->Node for above line

  while(!f.eof()){
    memset(ln,NULL,64); //Reset memory of ln
    f.getline(ln, 64); //Read line
    ch=ln; //Point first character of the line
    l++; //Add up line number

    if(l<3){ //Line 1 and 2 have map ID and minimum count
      int num=0; //Variable for change character type to integer type
      while(*ch){
        ch++;
        if(*ch>=48&&*ch<=57) //If there is number, change to integer type
          num=num*10+static_cast<int>(*ch)-48;
      }
      if(l==1) //Save map ID
        m_mapID=num;
      else if(l==2) //Save minimum count
        m_minCnt=num;
    }
    else if(l>3){
      while(*ch){ //Link first line to head
        if(*ch>=48&&*ch<=57){
          Light* New=new Light; //New->New node
          New->SetState(static_cast<int>(*ch)-48); //Set satate to node

          if(m_pHead==NULL){ //If head has no data, input first line
            m_pHead=New; //Link head
            temp=tHead=m_pHead; //Save head to temp and tHead
          }
          else if(tHead==ltemp){ //If this ndoe is start of next line, create new head
            tHead->SetBottom(New); //Link new node to bottom of tHead
            New->SetAbove(tHead); //Link tHead to above of new node
            temp=tHead=New; //Save head to temp and tHead
          }
          else{
            if(ltemp!=NULL){ //If this line is not first line, link last line to above
              ltemp=ltemp->GetRight(); //Move next node of last line
              ltemp->SetBottom(New); //Link new node to bottom of ltemp
              New->SetAbove(ltemp); //Link ltemp to above of new node
            }
            temp->SetRight(New); //Link new node to right of temp
            New->SetLeft(temp); //Link temp to left of new node
            temp=New; //Move next right node of temp
          }
        }
        ch++; //Move next character
      }
      ltemp=tHead; //Change last line
    }
  }
  return true;
}
bool LightsOut::LightOnOff(int x, int y){
  Light* temp=m_pHead; //Temporary node for find coordination

  for(int i=0;i<x;i++)
    temp=temp->GetRight(); //Move right
  for(int i=0;i<y;i++)
    temp=temp->GetBottom(); //Move bottom

  temp->SetState(temp->GetState()^1); //Changing the m_state using logical exclusive sum
  if(temp->GetAbove()!=NULL)
    temp->GetAbove()->SetState(temp->GetAbove()->GetState()^1); //Changing the m_state using logical exclusive sum
  if(temp->GetBottom()!=NULL)
    temp->GetBottom()->SetState(temp->GetBottom()->GetState()^1); //Changing the m_state using logical exclusive sum
  if(temp->GetLeft()!=NULL)
    temp->GetLeft()->SetState(temp->GetLeft()->GetState()^1); //Changing the m_state using logical exclusive sum
  if(temp->GetRight()!=NULL)
    temp->GetRight()->SetState(temp->GetRight()->GetState()^1); //Changing the m_state using logical exclusive sum

  m_userCnt++; //Add up user count

  return true;
}
bool LightsOut::Push(int x, int y){
  Node* pNew=new Node; //Create new node

  pNew->SetPos(x, y); //Save coordinate
  m_qsPosLog.Insert(pNew); //link into log

  return true;
}
bool LightsOut::Undo(){
  if(m_undoCnt==3) //If undo count is 3, user can not any more undo
    return false;
  else{
    Node* Pop=m_qsPosLog.PopFront(); //Pop last order

    if(Pop==NULL) //If there is no history, return false
      return false;
    else
      LightOnOff(Pop->GetPosX(), Pop->GetPosY());

    m_userCnt-=2; //Subtract user count
    m_undoCnt++; //Add up undo count

    Lgotoxy(20,13);
    cout<<"Undo : ("<<Pop->GetPosX()<<","<<Pop->GetPosY()<<"), undo count : "<<m_undoCnt<<endl;
    Sleep(1000);
    Lgotoxy(20,13);
    cout<<"                            ";

    delete Pop; //Free memory of temp

    return true;
  }
}
void LightsOut::Reset(){
  while(1){
    Node* Pop=m_qsPosLog.PopFront(); //Pop last order

    if(Pop==NULL)
      break;
    else
      LightOnOff(Pop->GetPosX(), Pop->GetPosY());

    delete Pop;
  }

  m_undoCnt=0; //Reset undo count
  m_userCnt=0; //Reset user count
}
bool LightsOut::IsSolved(){
  Light *temp=m_pHead, *tHead=m_pHead;

  while(tHead!=NULL){
    while(temp!=NULL){
      if(temp->GetState()!=0) //If state of temp has 1, return false
        return false;
      temp=temp->GetRight(); //Move right node
    }
    temp=tHead=tHead->GetBottom(); //Move next line
  }
  return true;
}
void LightsOut::PrintLights(){
  Light *temp=m_pHead, *tHead=m_pHead; //temp->Temporary pointer for node; tHead->Temporary pointer for line
  int y=0;

  Lgotoxy(20,y);
  cout<<"========================";
  y++;

  while(tHead!=NULL){
    Lgotoxy(20,y);
    cout<<"| ";
    while(temp!=NULL){
      cout<<" ";
      if(temp->GetState()==0)
        cout<<"□";
      else
        cout<<"■";
      cout<<" ";
      temp=temp->GetRight(); //Move right node
    }
    cout<<" |";
    temp=tHead=tHead->GetBottom(); //Move next line
    y++;
  }
  Lgotoxy(20,y);
  cout<<"========================";
}
void LightsOut::RecordSolution(char* fname){
  Lgotoxy(20,14);
  cout<<"Your Score is "<<100-10*(m_userCnt-m_minCnt)-5*m_undoCnt<<"!!"<<endl;

  ofstream ResultFile;
  ResultFile.open(fname, ios::app);

  ResultFile<<"===================="<<endl;
  ResultFile<<"MapID : "<<m_mapID<<endl;
  ResultFile<<"MinimumCount : "<<m_minCnt<<endl;
  ResultFile<<"UserCount : "<<m_userCnt<<endl;
  ResultFile<<"UndoCount : "<<m_undoCnt<<endl;
  ResultFile<<"Score : "<<100-10*(m_userCnt-m_minCnt)-5*m_undoCnt<<endl;
  ResultFile<<"Solution : ";

  Node* temp=m_qsPosLog.PopBack();
  ResultFile<<"("<<temp->GetPosX()<<","<<temp->GetPosY()<<")";
  delete temp;

  while(1){
    Node* temp=m_qsPosLog.PopBack();

    if(temp==NULL)
      break;
    else
      ResultFile<<" -> ("<<temp->GetPosX()<<","<<temp->GetPosY()<<")";

    delete temp;
  }

  ResultFile<<endl<<"===================="<<endl;
}