#pragma warning(disable:4996)
#include <iostream>
#include <string.h>
#include <fstream>
#include "AVL.h"
using namespace std;

int main(void){
	AVL avlTree;
	ifstream file;
	char command[10];
	char ch_value[3];

	file.open("input_data.in");
	while(file>>command>>ch_value){
		if(!strcmp(command,"Insert")){
			avlTree.Insert(atoi(ch_value));
		}
	}
	cout<<"-------------------------"<<endl;
	cout<<"          Result         "<<endl;
	cout<<"-------------------------"<<endl;
	avlTree.Print();
	cout<<endl<<"-------------------------"<<endl;

	file.close();

	return 0;
}