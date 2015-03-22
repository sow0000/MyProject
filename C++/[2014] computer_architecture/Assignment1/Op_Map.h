#pragma once
#include<string>
#include<map>
using namespace std;

class Op_Map{
private:
	map<string,pair<char*,int>> op;
	map<string,pair<char*,int>>::iterator it;

public:
	Op_Map(void);
	~Op_Map(void);
	
	void getOpValue(char* key, char*& opCode, int& type);
};
