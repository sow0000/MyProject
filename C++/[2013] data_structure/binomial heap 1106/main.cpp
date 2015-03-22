#include "Bin_Heap.h"
#include <iostream>
#include <fstream>
#include <string.h>
using namespace std;

int main(void){
	Bin_Heap bh;
	ifstream file;
	char getLine[10];
	char *command=NULL;
	char *ch_value=NULL;

	file.open("input_data.in");
	cout<<"-------------------------"<<endl;
	while(!file.eof()){
		memset(getLine, NULL, 10);

		file.getline(getLine, 10);
		if(!getLine){
			continue;
		}

		command=strtok(getLine, " ");
		ch_value=strtok(NULL, " ");

		if(!strcmp(command,"INSERT")){
			struct Bnode *pNew=new Bnode();
			pNew->degree=0;
			pNew->value=0;
			pNew->pNext=NULL;
			pNew->pChild=NULL;

			bh.Insert(pNew);
		}
		/*else if(!strcmp(command,"Search")){
			cout<<"Search : "<<ch_value<<endl;
			if(bsTree.Search(ch_value))
				cout<<"Search success!"<<endl;
			else
				cout<<"Search fail!"<<endl;
		}*/
	}
	cout<<"-------------------------"<<endl;
	/*bsTree.Print();
	cout<<endl<<"-------------------------"<<endl;*/

	file.close();
}