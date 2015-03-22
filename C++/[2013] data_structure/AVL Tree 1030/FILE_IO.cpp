#pragma warning(disable:4996)
#include "FILE_IO.h"
#include <string.h>
#include<iostream>
#include<iomanip>
using namespace std;

FILE_IO::FILE_IO(void){
}

FILE_IO::~FILE_IO(void){
	if(m_fin.is_open()){
		m_fin.close();
	}
	if(m_fout.is_open()){
		m_fout.close();
	}
}

bool FILE_IO::InputFileOpen(char* fname){ //input file open
	m_fin.open(fname);

	if(!m_fin.is_open()){ //If there is no file, stop the program
		return false;
	}
	else{
		return true;
	}
}

bool FILE_IO::OutputFileOpen(char* fname){ //output file open
	m_fout.open(fname, ios::app);
	return true;
}

bool FILE_IO::ReadCommand(char* arg[]){ //Read command from file
	if(!strcmp(arg[0],"INSERT")){ //Check Insert
		if(!CheckName(arg[1])){
			WriteError("First name", arg);
			return false;
		}
		if(!CheckName(arg[2])){
			WriteError("Last name", arg);
			return false;
		}
		if(!CheckPhoneNumber(arg[3])){
			WriteError("Phone-number", arg);
			return false;
		}
		if(!CheckAddress(arg[4])){
			WriteError("Street address", arg);
			return false;
		}
		if(!CheckDong(arg[5])){
			WriteError("Dong address", arg);
			return false;
		}
		return true;
	}

	if(!strcmp(arg[0], "UPDATENAME")){ //Check Update
		if(!CheckName(arg[1])){
			WriteError("First name", arg);
			return false;
		}
		if(!CheckName(arg[2])){
			WriteError("Last name", arg);
			return false;
		}
		if(!CheckPhoneNumber(arg[3])){
			WriteError("Phone-number", arg);
			return false;
		}
		if(arg[6]){
			if(!CheckPhoneNumber(arg[4])){
				WriteError("Phone-number", arg);
				return false;
			}
			if(!CheckAddress(arg[5])){
				WriteError("Street address", arg);
				return false;
			}
			if(!CheckDong(arg[6])){
				WriteError("Dong address", arg);
				return false;
			}
		}
		else if(!CheckAddress(arg[4])){
			WriteError("Street address", arg);
			return false;
		}
		else if(!CheckDong(arg[5])){
			WriteError("Dong address", arg);
			return false;
		}
		return true;
	}

	if(!strcmp(arg[0], "UPDATEPHONE")){ //Check Update
		if(!CheckPhoneNumber(arg[1])){
				WriteError("Phone-number", arg);
			return false;
		}
		if(!CheckAddress(arg[2])){
			WriteError("Street address", arg);
			return false;
		}
		if(!CheckDong(arg[3])){
			WriteError("Dong address", arg);
			return false;
		}
		return true;
	}

	if(!strcmp(arg[0],"DELETENAME")){ //Check Delete
		if(!CheckName(arg[1])){
			WriteError("First name", arg);
			return false;
		}
		if(!CheckName(arg[2])){
			WriteError("Last name", arg);
			return false;
		}
		if(arg[3]&&!CheckPhoneNumber(arg[3])){
				WriteError("Phone-number", arg);
			return false;
		}
		return true;
	}

	if(!strcmp(arg[0],"DELETEPHONE")){ //Check Delete
		if(!CheckPhoneNumber(arg[1])){
				WriteError("Phone-number", arg);
			return false;
		}
		return true;
	}

	if(!strcmp(arg[0],"PRINTNAME")){ //Check Print
		if(!CheckName(arg[1])){
			WriteError("First name", arg);
			return false;
		}
		if(!CheckName(arg[2])){
			WriteError("Last name", arg);
			return false;
		}
		if(arg[3]&&!CheckPhoneNumber(arg[3])){
				WriteError("Phone-number", arg);
			return false;
		}
		return true;
	}

	if(!strcmp(arg[0],"PRINTPHONE")){ //Check Print
		if(!CheckPhoneNumber(arg[1])){
				WriteError("Phone-number", arg);
			return false;
		}
		return true;
	}

	if(!strcmp(arg[0], "PRINTLASTNAME")){
		if(!CheckName(arg[1])){
			WriteError("Last name", arg);
			return false;
		}
		return true;
	}

	if(!strcmp(arg[0], "PRINTALL")){
		for(int loop=1;loop<7;loop++){
			if(arg[loop]!=NULL){
				return false;
			}
		}
		return true;
	}

	WriteError("Command", arg);
	return false;
}
bool FILE_IO::CheckName(char* arg){ //Check name
	if(!arg||*arg<'A'||*arg>'Z'){
		return false;
	}
	return true;
}

bool FILE_IO::CheckPhoneNumber(char* arg){ //Check phone number
	if(!arg||*arg<'0'||*arg>'9'){
		return false;
	}
	else{
		int length=0;
		char* temp=arg;

		while(*temp){
			if(length>7||(length==3&&*temp!='-')){
				return false;
			}
			else if(length!=3&&(*temp<'0'||*temp>'9')){
				return false;
			}
			temp++;
			length++;
		}
	}
	return true;
}

bool FILE_IO::CheckAddress(char* arg){ //Check address number
	if(!arg||*arg<'0'||*arg>'9'){
		return false;
	}
	else{
		char* temp=arg;

		while(*temp){
			if(*temp<'0'||*temp>'9'){
				return false;
			}
			temp++;
		}
	}
	return true;
}

bool FILE_IO::CheckDong(char* arg){ //Check dong-address
	if(!arg||*arg<'a'||*arg>'z'){
		return false;
	}
	else{
		char* temp=arg;

		while(*temp){
			if(*temp<'a'||*temp>'z'){
				break;
			}
			temp++;
		}

		if(strcmp(temp,"-dong")!=0){
			return false;
		}
	}
	return true;
}

bool FILE_IO::WriteEnd(){ //Write list remarks or new line
	if(!m_fout.is_open()){
		return false;
	}

	m_fout<<endl;
	m_fout.close();

	return true;
}

bool FILE_IO::WriteIndex(){ //Write list remarks or new line
	if(!m_fout.is_open()){
		return false;
	}

	m_fout.setf(ios::left);
	m_fout<<"==================================================================================="<<endl;
	m_fout<<setw(5)<<"   "<<setw(25)<<"Name"<<setw(25)<<"Phone-number"<<setw(25)<<"Address"<<endl;
	m_fout<<"==================================================================================="<<endl<<endl;

	return true;
}

bool FILE_IO::WriteData(int num, char* firstName, char* lastName, char* phoneNum, char* address){ //Write data of Tree
	if(!m_fout.is_open()){
		return false;
	}

	char name[20];
	memset(name, NULL, 20);
	strcpy(name, firstName);
	strcat(name, " ");
	strcat(name, lastName);

	m_fout.setf(ios::left);
	if(num==1){
		m_fout<<setw(5)<<"(*)  ";
	}
	else{
		m_fout<<setw(5)<<"    ";
	}
	m_fout<<setw(25)<<name<<setw(25)<<phoneNum<<address<<endl;


	return true;
}

bool FILE_IO::WriteError(char* str, char* arg[]){ //Write input or command error
/*
	if(!m_fout.is_open()){
		return false;
	}

	int loop=0;

	if(!strcmp(str, "Command")){
		m_fout<<"Command error - "<<str<<endl;
	}
	else{
		m_fout<<"Input error - "<<str<<endl;
	}

	while(arg[loop]&&loop<7){
		m_fout<<arg[loop]<<" ";
		loop++;
	}
	m_fout<<endl<<endl;
*/
	return true;
}

ifstream& FILE_IO::getFile(){ //Return input file
	return m_fin;
}