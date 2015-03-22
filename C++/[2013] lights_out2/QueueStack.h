#pragma once
#include"Node.h"

class QueueStack{
  Node* m_pHead; //����Ʈ�� ù ��° Node�� ����Ű�� ������

public:
  QueueStack(void); //Constructor
  ~QueueStack(void); //Destructor

  void Insert(Node* pNew); //����Ʈ�� ���ο� Node�� Head�� �߰�
  Node* PopFront(); //���� ���߿� �߰��� Node�� ����Ʈ���� ����
  Node* PopBack(); //���� ���� �߰��� Node�� ����Ʈ���� ����
};