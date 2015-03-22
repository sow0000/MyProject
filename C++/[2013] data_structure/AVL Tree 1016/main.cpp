#pragma warning(disable:4996)
#include <iostream>
#include <string.h>
#include <fstream>
#include "AVL.h"
using namespace std;

int main(void){
	AVL avlTree; //AVL Tree
	ifstream file; //input file
	char getLine[100]; //array to read line by line
	char *arg[7]={NULL,}; //store argument

	file.open("input_data.in"); //open input file
	if(!file.is_open()){ //open error
		cout<<"File is not exist"<<endl;
		return 0;
	}
	else{ //open success
		cout<<"Open \"input_data.in\" success."<<endl;
	}

	while(!file.eof()){
		memset(getLine, NULL, 100); //reset getLine

		file.getline(getLine, 100); //read line
		if(!*getLine){ //skip blank line
			continue;
		}
		arg[0]=strtok(getLine, " "); //seperate command
		for(int loop=1;loop<7;loop++){
			arg[loop]=strtok(NULL, " ");
		}

		if(!strcmp(arg[0],"INSERT")){ //insert
			arg[5]--;
			*arg[5]=' ';
			if(avlTree.Insert(arg[1], arg[2], arg[3], arg[4])){
				cout<<"Insert Success."<<endl;
			}
			else{
				cout<<"Insert Error."<<endl;
			}
		}
		else if(!strcmp(arg[0],"DELETENAME")){ //delete
			if(arg[3]&&avlTree.Delete(arg[1], arg[2], arg[3])){
				cout<<"Delete Success."<<endl;
			}
			else if(!arg[3]&&avlTree.Delete(arg[1], arg[2])){
				cout<<"Delete Success."<<endl;
			}
			else{
				cout<<"Delete Error."<<endl;
			}
		}
		else if(!strcmp(arg[0],"DELETEPHONE")){ //delete
			if(avlTree.Delete(arg[1])){
				cout<<"Delete Success."<<endl;
			}
			else{
				cout<<"Delete Error."<<endl;
			}
		}
		else if(!strcmp(arg[0],"UPDATENAME")){ //update
			if(arg[6]){
				arg[6]--;
				*arg[6]=' ';
				if(avlTree.UpdateName(arg[1], arg[2], arg[3], arg[4], arg[5])){ //update with sub key
					cout<<"Update Success."<<endl;
				}
				else{
					cout<<"Update Error."<<endl;
				}
			}
			else{
				arg[5]--;
				*arg[5]=' ';
				if(avlTree.UpdateName(arg[1], arg[2], NULL, arg[3], arg[4])){ //update without sub key
					cout<<"Update Success."<<endl;
				}
				else{
					cout<<"Update Error."<<endl;
				}
			}
		}
		else if(!strcmp(arg[0],"UPDATEPHONE")){ //update
			if(avlTree.UpdatePhone(arg[1], arg[2])){
				cout<<"Update Success."<<endl;
			}
			else{
				cout<<"Update Error."<<endl;
			}
		}
		else if(!strcmp(arg[0],"PRINTNAME")){ //print
			if(arg[3]&&avlTree.PrintName(arg[1],arg[2],arg[3])){
				cout<<"Print Success."<<endl;
			}
			else if(!arg[3]&&avlTree.PrintName(arg[1],arg[2])){
				cout<<"Print Success."<<endl;
			}
			else{
				cout<<"Print Error."<<endl;
			}
		}
		else if(!strcmp(arg[0],"PRINTLASTNAME")){ //print name
			if(avlTree.PrintName(arg[1])){
				cout<<"Print Success."<<endl;
			}
			else{
				cout<<"Print Error."<<endl;
			}
		}
		else if(!strcmp(arg[0],"PRINTPHONE")){ //print phone number
			if(avlTree.PrintPhone(arg[1])){
				cout<<"Print Success."<<endl;
			}
			else{
				cout<<"Print Error."<<endl;
			}
		}
		else if(!strcmp(arg[0],"PRINTALL")){ //print all
			if(avlTree.PrintAll()){
				cout<<"Print Success."<<endl;
			}
			else{
				cout<<"Print Error."<<endl;
			}
		}
	}

	file.close();

	return 0;
}