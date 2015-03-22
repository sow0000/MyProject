#include "Op_Map.h"

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
// Operation type mapping
// I-type(Iui)   0
// I-type(basic) 1
// I-type(base)  2
// J-type(basic) 3
// R-type(jr)    4
// R-type(shift) 5~6
// R-type(basic) 7~18
///////////////////////////////////////////////////////////////////////////////

Op_Map::Op_Map(void){
	op.insert(pair<string,pair<char*,int>>("add", pair<char*,int>("000000", 7))); //mapping operation
	op.insert(pair<string,pair<char*,int>>("addi", pair<char*,int>("001000", 1)));
	op.insert(pair<string,pair<char*,int>>("addiu", pair<char*,int>("001001", 1)));
	op.insert(pair<string,pair<char*,int>>("addu", pair<char*,int>("000000", 8)));
	op.insert(pair<string,pair<char*,int>>("lui", pair<char*,int>("001111", 0)));
	op.insert(pair<string,pair<char*,int>>("sub", pair<char*,int>("000000", 9)));
	op.insert(pair<string,pair<char*,int>>("subu", pair<char*,int>("000000", 10)));
	op.insert(pair<string,pair<char*,int>>("sll", pair<char*,int>("000000", 5)));
	op.insert(pair<string,pair<char*,int>>("srl", pair<char*,int>("000000", 6)));
	op.insert(pair<string,pair<char*,int>>("and", pair<char*,int>("000000", 11)));
	op.insert(pair<string,pair<char*,int>>("andi", pair<char*,int>("001100", 1)));
	op.insert(pair<string,pair<char*,int>>("or", pair<char*,int>("000000", 12)));
	op.insert(pair<string,pair<char*,int>>("ori", pair<char*,int>("001101", 1)));
	op.insert(pair<string,pair<char*,int>>("nor", pair<char*,int>("000000", 13)));
	op.insert(pair<string,pair<char*,int>>("slt", pair<char*,int>("000000", 17)));
	op.insert(pair<string,pair<char*,int>>("slti", pair<char*,int>("001010", 1)));
	op.insert(pair<string,pair<char*,int>>("sltiu", pair<char*,int>("001011", 1)));
	op.insert(pair<string,pair<char*,int>>("sltu", pair<char*,int>("000000", 18)));
	op.insert(pair<string,pair<char*,int>>("beq", pair<char*,int>("000100", 1)));
	op.insert(pair<string,pair<char*,int>>("bne", pair<char*,int>("000101", 1)));
	op.insert(pair<string,pair<char*,int>>("j", pair<char*,int>("000010", 3)));
	op.insert(pair<string,pair<char*,int>>("jal", pair<char*,int>("000011", 3)));
	op.insert(pair<string,pair<char*,int>>("jr", pair<char*,int>("000000", 4)));
	op.insert(pair<string,pair<char*,int>>("lb", pair<char*,int>("100000", 2)));
	op.insert(pair<string,pair<char*,int>>("lbu", pair<char*,int>("100100", 2)));
	op.insert(pair<string,pair<char*,int>>("lh", pair<char*,int>("100001", 2)));
	op.insert(pair<string,pair<char*,int>>("lhu", pair<char*,int>("100101", 2)));
	op.insert(pair<string,pair<char*,int>>("lw", pair<char*,int>("100011", 2)));
	op.insert(pair<string,pair<char*,int>>("sb", pair<char*,int>("101000", 2)));
	op.insert(pair<string,pair<char*,int>>("sh", pair<char*,int>("101001", 2)));
	op.insert(pair<string,pair<char*,int>>("sw", pair<char*,int>("101011", 2)));
}

///////////////////////////////////////////////////////////////////////////////
// Destruction
// ==========================================================================
// Map clear
///////////////////////////////////////////////////////////////////////////////

Op_Map::~Op_Map(void){
	op.clear();
}

///////////////////////////////////////////////////////////////////////////////
// getOpValue
// ==========================================================================
// Input : key, opCode, type
// Purpose : Get opcode and operation format
///////////////////////////////////////////////////////////////////////////////

void Op_Map::getOpValue(char* key, char*& opCode, int& type){
	it=op.find(key);

	opCode=it->second.first;
	type=it->second.second;
}