#pragma once
#include "Reg_Map.h"
#include "Op_Map.h"
#include "File_IO.h"
#include<iostream>
using namespace std;

class M_Assembler{
private:
	File_IO fin; //input file
	File_IO fout; //output file
	Reg_Map rMap; //register map
	Op_Map oMap; //operation map

public:
	M_Assembler(void);
	~M_Assembler(void);

	void start(); //Mini assembler start
	char* dtob(int dec, int bit); //decimal to binary
};
