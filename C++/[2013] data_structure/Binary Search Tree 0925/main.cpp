#include <iostream>
#include <string.h>
#include "BST.h"
#include "FILE_IO.h"
using namespace std;

int main(void){
	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF|_CRTDBG_LEAK_CHECK_DF);

	BST bsTree;
	FILE_IO file;
	char command[10], arg[2];

	if(!file.InputFileOpen("input_data.in")){
		cout<<"File is not exist"<<endl;
		return 0;
	}

	while(file.getFile()>>command>>arg[0]>>arg[1]){
		if(!file.ReadCommand(command, arg[0], arg[1])){
			cout<<"Command Error"<<endl;
			return 0;
		}

		if(!strcmp(command,"INSERT")){
			bsTree.Insert(arg[0], (int)arg[1]-48);
			cout<<"Success!"<<endl;
		}
		else if(!strcmp(command,"DELETE")){
			bsTree.Delete(arg[0], (int)arg[1]-48);
			cout<<"Success!"<<endl;
		}
		else if(!strcmp(command,"PRINT")){
			cout<<"-------------------------"<<endl;
			cout<<"Data"<<endl;
			cout<<"-------------------------"<<endl;
			bsTree.Print();
			cout<<endl<<"-------------------------"<<endl;
		}
	}

	return 0;
}
