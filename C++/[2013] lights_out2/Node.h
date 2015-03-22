#pragma once

class Node{
  int m_posX; //사용자가 입력한 x좌표를 저장
  int m_posY; //사용자가 입력한 y좌표를 저장
  Node* m_pNext; //다음의 Node를 가리키는 포인터
  Node* m_pPrev; //이전의 Node를 가리키는 포인터

public:
  Node(void); //Constructor
  ~Node(void); //Destructor

  void SetPos(int x, int y); //좌표 m_posX, m_posY 값을 설정
  int GetPosX(); //좌표 m_posX의 값을 반환
  int GetPosY(); //좌표 m_posY의 값을 반환
  void SetNext(Node* pNext); //m_pNext 포인터를 설정
  void SetPrev(Node* pPrev); //m_pPrev 포인터를 설정
  Node* GetNext(); //m_pNext 포인터를 반환
  Node* GetPrev(); //m_pPrev 포인터를 반환
};