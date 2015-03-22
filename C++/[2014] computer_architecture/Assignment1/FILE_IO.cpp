#include "File_IO.h"

///////////////////////////////////////////////////////////////////////////////
// File Name	: Op_Mapp.cpp
// Date			: 2014/03/17
// Os			: Windows 7 64-bit
// Author		: Lee Hyun Jae
// Student ID	: 2010720092
// --------------------------------------------------------------------------
// Title		: Computer Architecture Assignment #1
// Description	: Class for input/output
///////////////////////////////////////////////////////////////////////////////

File_IO::File_IO(){
}

File_IO::~File_IO(){
}

bool File_IO::InputFileOpen(char *fileName){
	fin.open(fileName);

	if(!fin.is_open()){ //If there is no file, stop the program
		return false;
	}
	else{
		return true;
	}
}

bool File_IO::OutputFileOpen(char *fileName){
	fout.open(fileName);

	if(!fout.is_open()){ //open file fail
		return false;
	}
	else{
		return true;
	}
}

void File_IO::Close(){
	if(fin.is_open()){ //close input file
		fin.close();
	}
	if(fout.is_open()){ //close output file
		fout.close();
	}
}

char* File_IO::GetLine(){
	memset(getLine, 0, sizeof(getLine));
	fin.getline(getLine, sizeof(getLine)); //read line
	
	if(strlen(getLine)==0) //no line
		return 0;
	else
		return getLine;
}

void File_IO::Write(char* str){
	for(int i=0;i<4;i++){
		for(int j=0+i*8;j<8+i*8;j++){
			fout<<str[j]; //print out str
		}
		fout<<" ";
	}
	fout<<endl;
}

void File_IO::Write(int n){
	fout<<n; //print out n
}
