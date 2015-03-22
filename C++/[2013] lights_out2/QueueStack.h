#pragma once
#include"Node.h"

class QueueStack{
  Node* m_pHead; //리스트의 첫 번째 Node를 가리키는 포인터

public:
  QueueStack(void); //Constructor
  ~QueueStack(void); //Destructor

  void Insert(Node* pNew); //리스트에 새로운 Node를 Head에 추가
  Node* PopFront(); //가장 나중에 추가된 Node를 리스트에서 꺼냄
  Node* PopBack(); //가장 먼저 추가된 Node를 리스트에서 꺼냄
};