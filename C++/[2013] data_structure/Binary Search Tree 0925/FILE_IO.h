#pragma once
#include<fstream>
using namespace std;

class FILE_IO
{
private:
	ifstream m_fin; //input file stream
	ofstream m_fout; //output file steam

public:
	FILE_IO(void);
	virtual~FILE_IO(void);

	bool InputFileOpen(char* fname); //input file open
	bool OutputFileOpen(char* fname); //output file open
	bool ReadCommand(char* cmd, char& arg1, char& arg2); //Read command from file
	bool Write(char* str); //write str to output file
	ifstream& getFile();
};
