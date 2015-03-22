#pragma once

class Light{
  Light* m_pRight; //오른쪽의 light와 연결하기 위한 포인터
  Light* m_pLeft; //왼쪽의 light와 연결하기 위한 포인터
  Light* m_pAbove; //위의 light와 연결하기 위한 포인터
  Light* m_pBottom; //아래의 light와 연결하기 위한 포인터
  int m_state; //현재 light의 상태를 나타내기 위한 변수

public:
  Light(void); //Constructor
  ~Light(void); //Destructor

  void SetState(int state); //m_state를 설정
  int GetState(); //m_state를 반환
  void SetRight(Light* pRight); //Right light를 설정
  void SetLeft(Light* pLeft); //Left light를 설정
  void SetAbove(Light* pAbove); //Above light를 설정
  void SetBottom(Light* pBottom); //Bottom light를 설정
  Light* GetRight(); //Right light의 포인터를 반환
  Light* GetLeft(); //Left light의 포인터를 반환
  Light* GetAbove(); //Above light의 포인터를 반환
  Light* GetBottom(); //Bottom light의 포인터를 반환
};