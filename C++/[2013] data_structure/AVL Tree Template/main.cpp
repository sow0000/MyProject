#pragma warning(disable:4996)
#include <iostream>
#include <string.h>
#include <fstream>
#include "AVL.hpp"
using namespace std;

int main(void){
	AVL avlTree; //AVL Tree
	FILE_IO file; //input file
	char getLine[100]; //array to read line by line
	char command[20],
		firstName[10],
		lastName[10],
		phoneNum[10],
		subKey[10],
		address[50];

	if(!file.InputFileOpen("input_data.in")){ //input file open
		cout<<"File is not exist"<<endl; //open error
		return 0;
	}
	else{ //open success
		cout<<"Open \"input_data.in\" success."<<endl;
	}

	while(!file.getFile().eof()){
		memset(getLine, NULL, 100);
		memset(command, NULL, 20);
		memset(firstName, NULL, 10);
		memset(lastName, NULL, 10);
		memset(phoneNum, NULL, 10);
		memset(subKey, NULL, 10);
		memset(address, NULL, 50);

		file.getFile().getline(getLine, 100); //read line
		if(!*getLine){
			continue;
		}

		file.ReadCommand(getLine, command, firstName, lastName, phoneNum, subKey, address);

		if(!strcmp(command,"INSERT")){ //insert
			if(avlTree.Insert(firstName, lastName, phoneNum, address)){
				cout<<"Insert Success."<<endl;
			}
			else{
				cout<<"Insert Error."<<endl;
			}
		}
		else if(!strcmp(command,"DELETENAME")){ //delete
			if(avlTree.Delete(firstName, lastName, subKey)){
				cout<<"Delete Success."<<endl;
			}
			else{
				cout<<"Delete Error."<<endl;
			}
		}
		else if(!strcmp(command,"DELETEPHONE")){ //delete
			if(avlTree.Delete(phoneNum)){
				cout<<"Delete Success."<<endl;
			}
			else{
				cout<<"Delete Error."<<endl;
			}
		}
		else if(!strcmp(command,"UPDATENAME")){ //update
			if(avlTree.Update(firstName, lastName, subKey, phoneNum, address)){ //update with sub key
				cout<<"Update Success."<<endl;
			}
			else{
				cout<<"Update Error."<<endl;
			}
		}
		else if(!strcmp(command,"UPDATEPHONE")){ //update
			if(avlTree.Update(phoneNum, address)){
				cout<<"Update Success."<<endl;
			}
			else{
				cout<<"Update Error."<<endl;
			}
		}
		else if(!strcmp(command,"PRINTNAME")){ //print
			if(avlTree.Print<Name>(firstName,lastName, subKey, file)){
				cout<<"Print Success."<<endl;
			}
			else{
				cout<<"Print Error."<<endl;
			}
		}
		else if(!strcmp(command,"PRINTLASTNAME")){ //print name
			if(avlTree.Print(lastName, file)){
				cout<<"Print Success."<<endl;
			}
			else{
				cout<<"Print Error."<<endl;
			}
		}
		else if(!strcmp(command,"PRINTPHONE")){ //print phone number
			if(avlTree.Print(phoneNum, file)){
				cout<<"Print Success."<<endl;
			}
			else{
				cout<<"Print Error."<<endl;
			}
		}
		else if(!strcmp(command,"PRINTALL")){ //print all
			if(avlTree.PrintAll(file)){
				cout<<"Print Success."<<endl;
			}
			else{
				cout<<"Print Error."<<endl;
			}
		}
	}

	return 0;
}