#pragma once
#include"Light.h"
#include"QueueStack.h"

class LightsOut{
private:
  Light* m_pHead; //5x5 Lights Out ���� (0, 0) light�� ����Ű�� ������
  QueueStack m_qsPosLog; //����ڰ� �Է��� ��ǥ�� ��� ����
  int m_undoCnt; //���ӿ��� undo�� Ƚ���� ���
  int m_mapID; //�� ID�� ���� (1~9)
  int m_minCnt; //������ �ذ��ϱ� ���� �ʿ��� �ּ� Ƚ��
  int m_userCnt; //����ڰ� ������ �ذ��ϱ� ���� �Է��� �� Ƚ��

public:
  LightsOut(void); //Constructor
  ~LightsOut(void); //Destructor

  void ping(int x, int y, int c); //������ light �����̱�
  bool LoadMap(char* fname); //���Ϸκ��� �� ������ �о�� ���� ����
  bool LightOnOff(int x, int y); //����ڰ� �Է��� x, y��ǥ�� ���� light�� on/off
  bool Push(int x, int y); //����ڰ� �Է��� ��ǥ x, y�� QueueStack�� ����
  bool Undo(); //QueueStack�� �̿��Ͽ� ������� �Է��� �� �ܰ� undo
  void Reset(); //QueueStack�� �̿��Ͽ� ���� ó���� ���·� �ʱ�ȭ
  bool IsSolved(); //������ �ذ�Ǿ����� Ȯ��
  void PrintLights(); //���� ���� ���¸� ���
  void RecordSolution(char* fname); //������ ������, ����ڰ� �Է��� ��ǥ, Ƚ�� �� ������ ���Ϸ� ���
};