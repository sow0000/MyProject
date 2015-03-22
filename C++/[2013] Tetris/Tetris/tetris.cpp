#include<iostream>
#include<windows.h> //Ŀ���� ���� ���
#include<time.h> //�����Լ�
#include<conio.h> //kbhit�� ���� ���
using namespace std;

void gotoxy(int x, int y){  //Ŀ�� �̵��� �Լ�...÷�ô� ������
  COORD XY={x,y};
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),XY);
}

void HideCursor(){ //Ŀ�� ����� �Լ�...DC�� ������ ����
  CONSOLE_CURSOR_INFO CurInfo;
  CurInfo.dwSize=1;
  CurInfo.bVisible=FALSE;
  SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE),&CurInfo);
}

struct Point { //�� ǥ���ε�...������ ����...Ŭ������ �� �����ϰ���;;
  int x,y;
};

Point Shape[][4][4]={ //���� Ŭ������ �̷��� �迭 �����ϴ� ����� �𸣰���;;;
  { {0,0,1,0,2,0,-1,0}, {0,0,0,1,0,-1,0,-2}, {0,0,1,0,2,0,-1,0}, {0,0,0,1,0,-1,0,-2} }, //����, ����-����-����-����
  { {0,0,1,0,0,1,1,1}, {0,0,1,0,0,1,1,1}, {0,0,1,0,0,1,1,1}, {0,0,1,0,0,1,1,1} }, //�׸�, �ȵ��ư�
  { {0,0,-1,0,0,-1,1,-1}, {0,0,0,1,-1,0,-1,-1}, {0,0,-1,0,0,-1,1,-1}, {0,0,0,1,-1,0,-1,-1} }, //N��, ��-N-��-N
  { {0,0,-1,-1,0,-1,1,0}, {0,0,-1,0,-1,1,0,-1}, {0,0,-1,-1,0,-1,1,0}, {0,0,-1,0,-1,1,0,-1} }, //N�� �ݴ�, ��-N-��-N
  { {0,0,-1,0,1,0,-1,-1}, {0,0,0,-1,0,1,-1,1}, {0,0,-1,0,1,0,1,1}, {0,0,0,-1,0,1,1,-1} }, //���� �ݴ�, ����-��-����-��
  { {0,0,1,0,-1,0,1,-1}, {0,0,0,1,0,-1,-1,-1}, {0,0,1,0,-1,0,-1,1}, {0,0,0,-1,0,1,1,1} }, //����, ��-����-��-����
  { {0,0,-1,0,1,0,0,1}, {0,0,0,-1,0,1,1,0}, {0,0,-1,0,1,0,0,-1}, {0,0,-1,0,0,-1,0,1} } //��, ��-��-��-��
};

class xNode{
  xNode* m_pNext;
  xNode* m_pTail;
  int x; //x ��ǥ
  int s; //����

public:
  xNode();
  ~xNode();

  void setxNode(int m_x);
  void setStatus(int ts);
  xNode* getNext();
  int getx();
  int getStatus();
};

xNode::xNode(){
  m_pNext=NULL;
  m_pTail=NULL;
  x=0;
  s=0;
}

xNode::~xNode(){
  delete m_pNext;
  m_pTail=NULL;
}

void xNode::setxNode(int m_x){
  xNode* temp=new xNode;

  temp->x=m_x;

  if(m_x==0||m_x==11)
    temp->setStatus(2);
  else
    temp->setStatus(0);

  if(m_pNext==NULL){
    m_pNext=temp;
    m_pTail=temp;
  }
  else{
    m_pTail->m_pNext=temp;
    m_pTail=temp;
  }
}

void xNode::setStatus(int ts){
  s=ts;
}

xNode* xNode::getNext(){
  return m_pNext;
}

int xNode::getx(){
  return x;
}

int xNode::getStatus(){
  return s;
}

class yNode{
  xNode* m_pNext;
  yNode* m_pyNext;
  yNode* m_pyPrev;
  yNode* m_pTail;
  int y;

public:
  yNode();
  ~yNode();

  void makeyNode(int m_y);
  void setyNext(yNode* pNext);
  void setyPrev(yNode* pPrev);
  xNode* getNext();
  yNode* getyNext();
  yNode* getyLast();
  int gety();
};

yNode::yNode(){
  m_pNext=NULL;
  m_pyNext=NULL;
  m_pyPrev=NULL;
  m_pTail=NULL;
  y=0;
}

yNode::~yNode(){
  delete m_pNext;
  delete m_pyNext;
  m_pyPrev=NULL;
  m_pTail=NULL;
}

void yNode::makeyNode(int m_y){
  yNode* ytemp=new yNode;
  xNode* xtemp=new xNode;

  ytemp->y=m_y;

  if(m_y==0||m_y==21){
    for(int j=0;j<12;j++)
      xtemp->setxNode(j);
    ytemp->m_pNext=xtemp->getNext();
    while(xtemp->getNext()!=NULL){
      xtemp->setStatus(2);
      xtemp=xtemp->getNext();
    }
  }
  else{
    for(int j=0;j<12;j++)
      xtemp->setxNode(j);
    ytemp->m_pNext=xtemp->getNext();
  }


  if(m_pyNext==NULL){
    m_pyNext=ytemp;
    m_pTail=ytemp;
  }
  else{
    m_pTail->setyNext(ytemp);
    m_pTail=ytemp;
  }
}

void yNode::setyNext(yNode* pNext){
  if(pNext==NULL) 
    m_pyNext=pNext;
  else
  {
    m_pyNext=pNext;
    pNext->m_pyPrev=this;
  }
}

void yNode::setyPrev(yNode* pPrev){
  if(pPrev==NULL) 
    m_pyPrev=pPrev;
  else
  {
    m_pyPrev=pPrev;
    pPrev->m_pyNext=this;
  }
}
xNode* yNode::getNext(){
  return m_pNext;
}

yNode* yNode::getyNext(){
  return m_pyNext;
}

yNode* yNode::getyLast(){
  return m_pTail->m_pyPrev;
}

int yNode::gety(){
  return y;
}

char* block[]={"��","��","��"}; //�� ǥ���� ����
int x, y, r, Bshape, cnt; //x,y=>��ǥ; r=>��ȸ��; Bshape=>�� ���; cnt=>�ð�������...?
yNode* a=new yNode; //��ü �ʿ� ���� ���

void printMap(){
  yNode* ytemp=a->getyNext();

  for(int ty=0;ty<22;ty++){
    xNode* xtemp=ytemp->getNext();
    for(int tx=0;tx<12;tx++){
      cout<<block[xtemp->getStatus()];
      xtemp=xtemp->getNext();
    }
    ytemp=ytemp->getyNext();
    cout<<endl;
  }
}

xNode* moveNode(int tx, int ty){
  yNode* ytemp=a->getyNext();

  while(ytemp->gety()!=ty)
    ytemp=ytemp->getyNext();

  xNode* xtemp=ytemp->getNext();

  while(xtemp->getx()!=tx)
    xtemp=xtemp->getNext();

  return xtemp;
}

void printBshape(bool show){
  for(int i=0;i<4;i++){
    gotoxy((x+Shape[Bshape][r][i].x)* 2, (y+Shape[Bshape][r][i].y));
    if(show==true)
      puts(block[1]);
    else
      puts(block[0]);
  }
}

bool colCheck(int tx, int ty, int b, int r){
	for(int i=0;i<4;i++)
		if(moveNode((tx+Shape[Bshape][r][i].x), (ty+Shape[Bshape][r][i].y))->getStatus()!=0)
			return true;
	return false;
}

bool moveDown(){
  if(colCheck(x,y+1,Bshape,r)){
    for(int i=0;i<4;i++)
      moveNode((x+Shape[Bshape][r][i].x), (y+Shape[Bshape][r][i].y))->setStatus(1);
    return true;
  }

  printBshape(false);
  y++;
  printBshape(true);

  return false;
}

bool processKey(){
	if(kbhit()){
		int c=getch();
		if(c==32){
			while(true){
				if(!colCheck(x,y+1,Bshape,r))
					moveDown();
				else break;
			}
		}
		if(c==75&& !colCheck(x-1,y,Bshape,r)){
			printBshape(false);
			x--;
			printBshape(true);
			
		}
		if(c==77&& !colCheck(x+1,y,Bshape,r)){
			printBshape(false);
			x++;
			printBshape(true);
		}
		if(c==80){
			if(moveDown()){
				cnt=0;
				return moveDown();
			}
		}
		if(c==72&& !colCheck(x,y,Bshape,(r+1)%4)){
			printBshape(false);
			r++;
			r%=4;
			printBshape(true);
		}
	}
	return false;
}

bool rowFull(xNode* xtemp){
  while(xtemp!=NULL){
    if(xtemp->getStatus()==1)
      return false;
    xtemp=xtemp->getNext();
  }
  return true;
}
/*
void eraseBlock(){ //�� ����� �Լ�
  yNode* ytemp=a->getyLast();

  while(ytemp->gety()>=y-1){
    if(rowFull(ytemp->getNext())){
      



}
*/
int main(){
  HideCursor();

  for(int i=0;i<22;i++)
    a->makeyNode(i);
  printMap();

  srand(unsigned int(GetTickCount()));

  while(1){
    x=5;
    y=2;
    r=0;
    Bshape=rand()%7;
    cnt =0 ;
    while(1){
      cnt++;

      if(cnt==20){

        if(moveDown())
          break;
        cnt =0 ;
      }
      if(processKey())
      break;
      Sleep(30);
    }
    //eraseBlock();
  }
  return 0;
}