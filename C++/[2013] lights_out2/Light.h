#pragma once

class Light{
  Light* m_pRight; //�������� light�� �����ϱ� ���� ������
  Light* m_pLeft; //������ light�� �����ϱ� ���� ������
  Light* m_pAbove; //���� light�� �����ϱ� ���� ������
  Light* m_pBottom; //�Ʒ��� light�� �����ϱ� ���� ������
  int m_state; //���� light�� ���¸� ��Ÿ���� ���� ����

public:
  Light(void); //Constructor
  ~Light(void); //Destructor

  void SetState(int state); //m_state�� ����
  int GetState(); //m_state�� ��ȯ
  void SetRight(Light* pRight); //Right light�� ����
  void SetLeft(Light* pLeft); //Left light�� ����
  void SetAbove(Light* pAbove); //Above light�� ����
  void SetBottom(Light* pBottom); //Bottom light�� ����
  Light* GetRight(); //Right light�� �����͸� ��ȯ
  Light* GetLeft(); //Left light�� �����͸� ��ȯ
  Light* GetAbove(); //Above light�� �����͸� ��ȯ
  Light* GetBottom(); //Bottom light�� �����͸� ��ȯ
};