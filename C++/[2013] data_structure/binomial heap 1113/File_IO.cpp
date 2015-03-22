#include "File_IO.h"

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
	fout.open(fileName, ios::app);

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
	fout<<str; //print out str
}

void File_IO::Write(int n){
	fout<<n; //print out n
}
