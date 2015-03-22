#include "Reg_Map.h"

///////////////////////////////////////////////////////////////////////////////
// File Name	: Op_Mapp.cpp
// Date			: 2014/03/17
// Os			: Windows 7 64-bit
// Author		: Lee Hyun Jae
// Student ID	: 2010720092
// --------------------------------------------------------------------------
// Title		: Computer Architecture Assignment #1
// Description	: Class for opcode mapping
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Construction
// ==========================================================================
// Register mapping
///////////////////////////////////////////////////////////////////////////////

Reg_Map::Reg_Map(void){
	reg.insert(pair<string,int>("$zero", 0)); //mapping register
	reg.insert(pair<string,int>("$v0", 2));
	reg.insert(pair<string,int>("$v1", 3));
	reg.insert(pair<string,int>("$a0", 4));
	reg.insert(pair<string,int>("$a1", 5));
	reg.insert(pair<string,int>("$a2", 6));
	reg.insert(pair<string,int>("$a3", 7));
	reg.insert(pair<string,int>("$t0", 8));
	reg.insert(pair<string,int>("$t1", 9));
	reg.insert(pair<string,int>("$t2", 10));
	reg.insert(pair<string,int>("$t3", 11));
	reg.insert(pair<string,int>("$t4", 12));
	reg.insert(pair<string,int>("$t5", 13));
	reg.insert(pair<string,int>("$t6", 14));
	reg.insert(pair<string,int>("$t7", 15));
	reg.insert(pair<string,int>("$s0", 16));
	reg.insert(pair<string,int>("$s1", 17));
	reg.insert(pair<string,int>("$s2", 18));
	reg.insert(pair<string,int>("$s3", 19));
	reg.insert(pair<string,int>("$s4", 20));
	reg.insert(pair<string,int>("$s5", 21));
	reg.insert(pair<string,int>("$s6", 22));
	reg.insert(pair<string,int>("$s7", 23));
	reg.insert(pair<string,int>("$t8", 24));
	reg.insert(pair<string,int>("$t9", 25));
	reg.insert(pair<string,int>("$gp", 28));
	reg.insert(pair<string,int>("$sp", 29));
	reg.insert(pair<string,int>("$fp", 30));
	reg.insert(pair<string,int>("$ra", 31));
}

///////////////////////////////////////////////////////////////////////////////
// Destruction
// ==========================================================================
// Map clear
///////////////////////////////////////////////////////////////////////////////

Reg_Map::~Reg_Map(void){
	reg.clear();
}

///////////////////////////////////////////////////////////////////////////////
// getRegValue
// ==========================================================================
// Input : key
// output : it->second
// Purpose : Get register number
///////////////////////////////////////////////////////////////////////////////

int Reg_Map::getRegValue(char* key){
	it=reg.find(key); //find register

	return it->second; //return integer
}