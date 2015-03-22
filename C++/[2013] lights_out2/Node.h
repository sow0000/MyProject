#pragma once

class Node{
  int m_posX; //����ڰ� �Է��� x��ǥ�� ����
  int m_posY; //����ڰ� �Է��� y��ǥ�� ����
  Node* m_pNext; //������ Node�� ����Ű�� ������
  Node* m_pPrev; //������ Node�� ����Ű�� ������

public:
  Node(void); //Constructor
  ~Node(void); //Destructor

  void SetPos(int x, int y); //��ǥ m_posX, m_posY ���� ����
  int GetPosX(); //��ǥ m_posX�� ���� ��ȯ
  int GetPosY(); //��ǥ m_posY�� ���� ��ȯ
  void SetNext(Node* pNext); //m_pNext �����͸� ����
  void SetPrev(Node* pPrev); //m_pPrev �����͸� ����
  Node* GetNext(); //m_pNext �����͸� ��ȯ
  Node* GetPrev(); //m_pPrev �����͸� ��ȯ
};