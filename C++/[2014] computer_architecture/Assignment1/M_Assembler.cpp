#include "M_Assembler.h"

///////////////////////////////////////////////////////////////////////////////
// File Name	: M_Assembler.cpp
// Date			: 2014/03/17
// Os			: Windows 7 64-bit
// Author		: Lee Hyun Jae
// Student ID	: 2010720092
// --------------------------------------------------------------------------
// Title		: Computer Architecture Assignment #1
// Description	: Class for mini assembler
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Construction
// ==========================================================================
// File open
///////////////////////////////////////////////////////////////////////////////

M_Assembler::M_Assembler(void){
	fin.InputFileOpen("assemblycode.txt");
	fout.OutputFileOpen("mashincode.txt");
}

///////////////////////////////////////////////////////////////////////////////
// Destruction
// ==========================================================================
// File close
///////////////////////////////////////////////////////////////////////////////

M_Assembler::~M_Assembler(void){
	fin.Close();
	fout.Close();
}

///////////////////////////////////////////////////////////////////////////////
// start
// ==========================================================================
// Purpose : Translate assembly language to machine language
///////////////////////////////////////////////////////////////////////////////

void M_Assembler::start(){
	char* zero="00000"; //const character zero
	char* readLine; //line read
	char* cOp; //character operation
	char* cReg[3]; //character values
	char* bOp; //binary operation
	char mCode[33]={0,}; //output machine code
	int type; //operation type

	for(int num=0;num<32;num++){ //initialize
		mCode[num]='0';
	}
	fout.Write(mCode); //print out

	while(readLine=fin.GetLine()){
		memset(mCode, 0, 33); //reallocate machine code

		cOp=strtok(readLine, " ,("); //read operation

		for(int num=0;num<3;num++){ //read operands
			cReg[num]=strtok(0, " ,(");
		}
			
		oMap.getOpValue(cOp, bOp, type); //translate operation
		strcpy(mCode, bOp); //copy operation to machine code
		
		if(type==0){ //I-type lui
			strcat(mCode, zero); //rs
			strcat(mCode, dtob(rMap.getRegValue(cReg[0]), 5)); //rt
			strcat(mCode, dtob(atoi(cReg[1]), 16)); //imm
		}else if(type==1){ //I-type basic
			strcat(mCode, dtob(rMap.getRegValue(cReg[1]), 5)); //rs
			strcat(mCode, dtob(rMap.getRegValue(cReg[0]), 5)); //rt
			strcat(mCode, dtob(atoi(cReg[2]), 16)); //imm
		}else if(type==2){ //I-type base
			cReg[2][3]=0; //delete ')'
			strcat(mCode, dtob(rMap.getRegValue(cReg[2]), 5)); //base
			strcat(mCode, dtob(atoi(cReg[1]), 5)); //rt
			strcat(mCode, dtob(rMap.getRegValue(cReg[0]), 16)); //offset
		}else if(type==3){ //J-type basic
			strcat(mCode, dtob(atoi(cReg[0]), 26)); //instr_index
		}
		else if(type==4){ //R-type jr
			strcat(mCode, dtob(rMap.getRegValue(cReg[0]), 5)); //rs
			strcat(mCode, zero); //rt
			strcat(mCode, zero); //rd
			strcat(mCode, zero); //shamt
			strcat(mCode, dtob(8, 6)); //funct
		}
		else if(type>=5&&type<=6){ //R-type shift
			strcat(mCode, zero); //rs
			strcat(mCode, dtob(rMap.getRegValue(cReg[1]), 5)); //rt
			strcat(mCode, dtob(rMap.getRegValue(cReg[0]), 5)); //rd
			strcat(mCode, dtob(atoi(cReg[2]), 5)); //shamt
			strcat(mCode, dtob(type, 6)); //funct
		}
		else if(type>=7&&type<=18){ //R-type basic
			strcat(mCode, dtob(rMap.getRegValue(cReg[1]), 5)); //rs
			strcat(mCode, dtob(rMap.getRegValue(cReg[2]), 5)); //rt
			strcat(mCode, dtob(rMap.getRegValue(cReg[0]), 5)); //rd
			strcat(mCode, zero); //shamt
			strcat(mCode, dtob(25+type, 6)); //funct
		}
		fout.Write(mCode); //printout
	}
}

///////////////////////////////////////////////////////////////////////////////
// dtob
// ==========================================================================
// Input : dec, bit
// output : binary
// Purpose : Decimal to Binary
///////////////////////////////////////////////////////////////////////////////

char* M_Assembler::dtob(int dec, int bit){
	int pn=0; //positive or negative
	char binary[27]={0,}; //return value
	char* tBinary=new char[bit+1]; //temporary value
	memset(tBinary, 0, sizeof(char)*(bit+1)); //initialize

	if(dec<0){ //negative number
		dec=0-dec;
		pn=1;
	}

	for(int num=bit-1;num>=0;num--){ //decimal to binary
		tBinary[num]=dec%2+48;
		dec/=2;
	}

	if(pn==1){
		int num=bit-2;
		
		while(tBinary[num+1]==48){ //find first 1
			num--;
		}
		
		for(num;num>=0;num--){ //two's complement
			if(tBinary[num]==48){
				tBinary[num]+=1;
			}else{
				tBinary[num]-=1;
			}
		}
	}
	
	strcpy(binary, tBinary); //copy value
	delete[] tBinary; //delete allocation

	return binary; //return binary
}