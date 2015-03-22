#include <iostream>
#include <string.h>
#include <fstream>
#include "BST.h"
using namespace std;

int main(void){
	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF|_CRTDBG_LEAK_CHECK_DF);

	BST bsTree;
	ifstream file;
	char command[10];
	char ch_value;

	file.open("input.txt");
	cout<<"-------------------------"<<endl;
	while(file>>command>>ch_value){
		if(!strcmp(command,"Insert"))
			bsTree.Insert(ch_value);
		else if(!strcmp(command,"Search")){
			cout<<"Search : "<<ch_value<<endl;
			if(bsTree.Search(ch_value))
				cout<<"Search success!"<<endl;
			else
				cout<<"Search fail!"<<endl;
		}
	}
	cout<<"-------------------------"<<endl;
	bsTree.Print();
	cout<<endl<<"-------------------------"<<endl;

	file.close();
}
