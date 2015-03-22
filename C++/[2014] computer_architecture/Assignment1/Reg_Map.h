#pragma once
#include<string>
#include<map>
using namespace std;

class Reg_Map{
private:
	map<string,int> reg;
	map<string,int>::iterator it;

public:
	Reg_Map(void);
	~Reg_Map(void);

	int getRegValue(char* key);
};
