#pragma warning(disable:4996)
#include <iostream>
#include <string.h>
#include "BST.h"
using namespace std;

int main(void){
	BST bsTree; //Tree
	int errNum=0;
	char getLine[100];
	char *arg[7]={NULL,};

	if(!bsTree.InputFileOpen("input_data.in")){ //open input file
		cout<<"File is not exist"<<endl;
		return 0;
	}
	else{
		cout<<"Open \"input_data.in\" success."<<endl;
	}
	bsTree.OutputFileOpen("result.out"); //open output file

	while(!bsTree.getFile().eof()){
		memset(getLine, NULL, 100);

		bsTree.getFile().getline(getLine, 100); //read line
		if(!*getLine){
			continue;
		}
		arg[0]=strtok(getLine, " "); //seperate command
		for(int loop=1;loop<7;loop++){
			arg[loop]=strtok(NULL, " ");
		}


		if(bsTree.ReadCommand(arg)){ //check command
			if(!strcmp(arg[0],"INSERT")){ //insert
				arg[5]--;
				*arg[5]=' ';
				if(bsTree.Insert(arg[1], arg[2], arg[3], arg[4])){
					cout<<"Insert Success."<<endl;
				}
				else{
					cout<<"Insert Error. Save error report into \"result.out\"."<<endl;
				}
			}
			else if(!strcmp(arg[0],"DELETE")){ //delete
				if(bsTree.Delete(arg[1], arg[2], arg[3])){
					cout<<"Delete Success."<<endl;
				}
				else{
					cout<<"Delete Error. Save error report into \"result.out\"."<<endl;
				}
			}
			else if(!strcmp(arg[0],"UPDATE")){ //update
				if(arg[6]){
					arg[6]--;
					*arg[6]=' ';
					if(bsTree.Update(arg[1], arg[2], arg[3], arg[4], arg[5])){ //update with sub key
					cout<<"Update Success."<<endl;
					}
					else{
						cout<<"Update Error. Save error report into \"result.out\"."<<endl;
					}
				}
				else{
					arg[5]--;
					*arg[5]=' ';
					if(bsTree.Update(arg[1], arg[2], NULL, arg[3], arg[4])){ //update without sub key
						cout<<"Update Success."<<endl;
					}
					else{
						cout<<"Update Error. Save error report into \"result.out\"."<<endl;
					}
				}
			}
			else if(!strcmp(arg[0],"PRINT")){ //print
				if(bsTree.Print(arg[1], arg[2], arg[3])){
					cout<<"Print Success."<<endl;
				}
				else{
					cout<<"Print Error. Save error report into \"result.out\"."<<endl;
				}
			}
			else if(!strcmp(arg[0],"PRINTNAME")){ //print name
				if(bsTree.Print(arg[1])){
					cout<<"Print Success."<<endl;
				}
				else{
					cout<<"Print Error. Save error report into \"result.out\"."<<endl;
				}
			}
			else if(!strcmp(arg[0],"PRINTALL")){ //print all
				if(bsTree.Print()){
					cout<<"Print Success."<<endl;
				}
				else{
					cout<<"Print Error. Save error report into \"result.out\"."<<endl;
				}
			}
		}
		else{ //command error
			cout<<"Command Error. Save error report into \"result.out\"."<<endl;
		}
	}

	return 0;
}