#include "FILE_IO.h"

FILE_IO::FILE_IO(void){
}

FILE_IO::~FILE_IO(void){
	m_fin.close();
	m_fout.close();
}

bool FILE_IO::InputFileOpen(char* fname){
	m_fin.open(fname);

	if(!m_fin.is_open()){ //If there is no file, stop the program
		return false;
	}
	else{
		return true;
	}
}

bool FILE_IO::OutputFileOpen(char* fname){
	m_fout.open(fname, ios::app);

	return true;
}

bool FILE_IO::ReadCommand(char* cmd, char& arg1, char& arg2){
	if(!strcmp(cmd,"INSERT")){
		if(arg1&&(arg1>='a'&&arg1<='z')||(arg1>='A'&&arg1<='Z')) {	
			if(arg2&&(arg2>='0'&&arg2<='9')){
				return true;
			}
		}
	}

	if(!strcmp(cmd,"DELETE")){
		if(arg1&&(arg1>='a'&&arg1<='z')||(arg1>='A'&&arg1<='Z')) {	
			if(arg2&&(arg2>='0'&&arg2<='9')){
				return true;
			}
		}
	}

	if(!strcmp(cmd,"PRINT")){
		if(!arg1&&!arg2){
			return true;
		}
	}

	return false;
}

bool FILE_IO::Write(char* str){
	if(!m_fout.is_open()){
		return false;
	}
	else{
		m_fout<<str<<endl;

		return true;
	}
}

ifstream& FILE_IO::getFile(){
	return m_fin;
}