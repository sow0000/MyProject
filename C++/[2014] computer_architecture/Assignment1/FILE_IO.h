#pragma once
#include <fstream>
#include <string.h>
#include <iomanip>
using namespace std;

class File_IO{
private:
	ifstream fin;  //input file object
	ofstream fout; //output file object
	char getLine[100]; //for get line
	
public:
	File_IO(); //constructor
	~File_IO(); //destructor

	bool InputFileOpen(char *fileName); //input file open
	bool OutputFileOpen(char *fileName); //output file open
	void Close(); //close file
	char* GetLine(); //read line
	void Write(char* str); //write string
	void Write(int n); //write integer
};
