#pragma once
#include<fstream>
using namespace std;

class FILE_IO{
private:
	ifstream m_fin; //input file stream
	ofstream m_fout; //output file steam

public:
	FILE_IO(void); //Constructor
	virtual~FILE_IO(void); //Destructor

	bool InputFileOpen(char* fname); //input file open
	bool OutputFileOpen(char* fname); //output file open
	bool ReadCommand(char* getLine, char* command, char* firstName, char* lastName, char* phoneNum, char* subKey, char* address); //Read command from file
	bool CheckName(char* arg); //Check name
	bool CheckPhoneNumber(char* arg); //Check phone number
	bool CheckAddress(char* arg); //Check address number
	bool CheckDong(char* arg); //Check dong-address
	bool WriteEnd(); //Write list remarks or new line
	bool WriteIndex(); //Write list remarks or new line
	bool WriteData(int num, char* firstName, char* lastName, char* phoneNum, char* address); //Write data of Tree
	bool WriteError(char* str, char* arg[]); //Write error
	ifstream& getFile(); //get output file
};
