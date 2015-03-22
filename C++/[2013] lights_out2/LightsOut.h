#pragma once
#include"Light.h"
#include"QueueStack.h"

class LightsOut{
private:
  Light* m_pHead; //5x5 Lights Out 맵의 (0, 0) light를 가리키는 포인터
  QueueStack m_qsPosLog; //사용자가 입력한 좌표를 모두 저장
  int m_undoCnt; //게임에서 undo된 횟수를 기록
  int m_mapID; //맵 ID를 저장 (1~9)
  int m_minCnt; //문제를 해결하기 위해 필요한 최소 횟수
  int m_userCnt; //사용자가 문제를 해결하기 위해 입력한 총 횟수

public:
  LightsOut(void); //Constructor
  ~LightsOut(void); //Destructor

  void ping(int x, int y, int c); //선택한 light 깜빡이기
  bool LoadMap(char* fname); //파일로부터 맵 정보를 읽어와 맵을 구성
  bool LightOnOff(int x, int y); //사용자가 입력한 x, y좌표에 대해 light를 on/off
  bool Push(int x, int y); //사용자가 입력한 좌표 x, y를 QueueStack에 저장
  bool Undo(); //QueueStack을 이용하여 사용자의 입력을 한 단계 undo
  void Reset(); //QueueStack을 이용하여 맵을 처음의 상태로 초기화
  bool IsSolved(); //문제가 해결되었는지 확인
  void PrintLights(); //현재 맵의 상태를 출력
  void RecordSolution(char* fname); //게임이 끝나면, 사용자가 입력한 좌표, 횟수 및 점수를 파일로 기록
};