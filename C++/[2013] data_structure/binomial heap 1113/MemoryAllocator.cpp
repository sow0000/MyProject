#include "MemoryAllocator.h"

MemoryAllocator::MemoryAllocator(){
	f_in=new File_IO(); //input file
	f_out=new File_IO(); //output file
	t_out=new File_IO(); //trace file
	AvailableList=new BinomialHeap(); //not allocated memory list
	AllocatedList=new AllocationList(); //allocated memory list
	coalCount=0;
	failureCount=0;
}

MemoryAllocator::~MemoryAllocator(){
	delete f_in; //delete f_in
	delete f_out; //delete f_out
	delete t_out; //delete t_out
	delete AvailableList; //delete not allocated memory list
	delete AllocatedList; //delete allocated memory list
}

bool MemoryAllocator::Start(){
	char* getLine=0; //read line
	char* command=0; //command
	char* charIndex=0; //index of command
	char* charSize=0; //size of command

	int newIndex, newSize; //integer type of index and size

	if(!f_in->InputFileOpen("scenario.in")){ //input file open
		cout<<"There is no file"<<endl;
		return false;
	}

	while(getLine=f_in->GetLine()){
		if(!AllocatedList->getTotalSize()){ //set allocator
			charSize=strtok(getLine, " ");
			newIndex=atoi(charSize);

			getLine=f_in->GetLine();
			charSize=strtok(getLine, " ");
			newSize=atoi(charSize);

			AllocatedList->setTotalSize(newIndex, newSize); //set total size and partition

			int parSize=0; //partition size

			for(int current=0;current<newSize;current++){ //set segment head
				parSize=newIndex/newSize;
				BinTreeNode *pNew=new BinTreeNode(current+1, 0, parSize*current, parSize);
				AllocatedList->setPartition(pNew);
				AvailableList->Insert(pNew);
			}

			cout<<"Set Memory Success"<<endl;

			continue;
		}

		command=strtok(getLine, " ");

		if(!strcmp(command, "A")||!strcmp(command, "a")){ //allocate memory
			charIndex=strtok(NULL, " ");
			newIndex=atoi(charIndex);
			charSize=strtok(NULL, " ");
			newSize=atoi(charSize);

			if(Allocate(newIndex, newSize)){
				cout<<"Allocate Success"<<endl;
			}
			else{
				cout<<"Allocate Fail"<<endl;
			}
		}
		else if(!strcmp(command, "F")||!strcmp(command, "f")){ //free memory
			charIndex=strtok(NULL, " ");
			newIndex=atoi(charIndex);

			if(Free(newIndex)){
				cout<<"Free Success"<<endl;
			}
			else{
				cout<<"Free Fail"<<endl;
			}
		}
		else if(strcmp(command, "S") == 0 || strcmp(command, "s") == 0){ //print out
			Write();
		}
	}

	f_in->Close(); //close file

	return true;
}

bool MemoryAllocator::Allocate(int newIndex, int newSize){
	BinTreeNode *pMax=AvailableList->getMax(); //max node
	BinTreeNode *pTemp=0; //new allocate node

	if(!AllocatedList->Check(pMax,newSize)){ //new size > max size
		Coalescing(); //coalescing available nodes
		pMax=AvailableList->getMax(); //max node

		if(!AllocatedList->Check(pMax,newSize)){ //new size > max size after coalescing
			failureCount++; //add failure count
			return false;
		}
	}

	pMax=AvailableList->Delete(); //pop max node from 
	pTemp=AllocatedList->Insert(pMax, newIndex, newSize); //allocate node

	if(!pTemp){
		AvailableList->DeleteAll(); //pop all node of AvailableList
		while(pTemp=AllocatedList->getNode(pTemp)){ //reinsert not allocated node
			AvailableList->Insert(pTemp);
		}
	}
	else if(pTemp!=pMax){
		AvailableList->Insert(pTemp);
	}

	return true;
}

bool MemoryAllocator::Free(int index){
	BinTreeNode *pNode=AllocatedList->Delete(index); //find node

	if(!pNode){
		return false;
	}

	pNode->setIndex(0); //reset index
	if(pNode->getFlag()){ //if linked node exist
		BinTreeNode *pNext=pNode->getNext(); //next node of pNode
		if(pNode->getSeg()!=pNext->getSeg()){ //different segment, cut link
			pNode->setNext(0);
		}
		pNext->setIndex(0); //reset index
		AvailableList->Insert(pNext); //insert AvailableList
	}
	AvailableList->Insert(pNode); //insert AvailableList

	return true;
}

bool MemoryAllocator::Coalescing(){
	coalCount++; //add coalescing count

	if(!AllocatedList->CanCoalescing()){ //can not coalescing
		return false;
	}

	AvailableList->DeleteAll(); //pop all node of AvailableList

	AllocatedList->Coalescing();

	BinTreeNode *pTemp=0;
	
	while(pTemp=AllocatedList->getNode(pTemp)){ //reinsert all node
		AvailableList->Insert(pTemp);
	}
	
	return true;
}

void MemoryAllocator::Write(){
	BinTreeNode* pTemp=0;
	int num=0;

//print out result
	f_out->OutputFileOpen("result.out");

	f_out->Write("Curent Memory Allocation State\n");
	f_out->Write("=================================\n");
	
	//print available memory
	f_out->Write("Available memory space : ");
	f_out->Write(AvailableList->getTotalSize());
	f_out->Write("\n");

	while(pTemp=AllocatedList->getNode(pTemp)){
		if(!pTemp->getIndex()){
			num++;
			f_out->Write(num);
			f_out->Write(" : ");
			f_out->Write(pTemp->getAddress());
			f_out->Write(" - ");
			f_out->Write(pTemp->getAddress()+pTemp->getSize()-1);
			f_out->Write("\n");
		}
	}

	//print allocated memory
	f_out->Write("\nAllocated memory space : ");
	f_out->Write(AllocatedList->getTotalSize()-AvailableList->getTotalSize());
	f_out->Write("\n");
	num=0;
	
	while(pTemp=AllocatedList->getNode(pTemp)){
		if(pTemp->getIndex()){
			num++;
			f_out->Write(num);
			f_out->Write(" : ");
			f_out->Write(pTemp->getAddress());
			f_out->Write(" - ");
			f_out->Write(pTemp->getAddress()+pTemp->getSize()-1);
			f_out->Write("\n");
		}
	}

	f_out->Write("\ncoalescing count : ");
	f_out->Write(coalCount);
	
	f_out->Write("\nmemory alloction failure count : ");
	f_out->Write(failureCount);
	f_out->Write("\n\n\n");

	f_out->Close(); //close file

//print out trace
	BinTreeNode *pMax=AvailableList->getMax();
	pTemp=pMax;
	num=0;

	t_out->OutputFileOpen("trace.out");
	
	t_out->Write("Curent Binomial Heap State\n");
	t_out->Write("=================================\n");
	t_out->Write("Maximum memory space : ");
	t_out->Write(pMax->getSize());
	t_out->Write("\n");
	t_out->Write("Degree of Max node : ");
	t_out->Write(pMax->getDegree());
	t_out->Write("\n");

	t_out->Write("Sibling of Max node\n");
	while(pTemp){
		num++;
		t_out->Write(num);
		t_out->Write(" : ");
		t_out->Write(pTemp->getSize());
		t_out->Write(" / ");
		t_out->Write(pTemp->getAddress());
		t_out->Write(" / ");
		t_out->Write(pTemp->getDegree());
		t_out->Write("\n");

		pTemp=pTemp->getBNext();
		if(pTemp==pMax){
			break;
		}
	}

	t_out->Write("\nAll node in Binomial Heap\n");
	Trace(pMax, 0);
	t_out->Write("\n\n");

	t_out->Close(); //close trace file
}

void MemoryAllocator::Trace(BinTreeNode *pNode, BinTreeNode *pHead){
	BinTreeNode *pWalker=pNode->getChild();

	t_out->Write("Current : ");
	t_out->Write(pNode->getSize());
	t_out->Write(" / ");
	t_out->Write(pNode->getAddress());
	t_out->Write("\t");

	t_out->Write("Child : ");
	if(pWalker){
		t_out->Write(pWalker->getSize());
		t_out->Write(" / ");
		t_out->Write(pWalker->getAddress());
	}
	else{
		t_out->Write("\t");
	}
	t_out->Write("\t");

	pWalker=pNode->getBNext();

	t_out->Write("Sibling : ");
	if(pWalker){
		t_out->Write(pWalker->getSize());
		t_out->Write(" / ");
		t_out->Write(pWalker->getAddress());
	}
	t_out->Write("\n");
	
	if(pNode->getChild()){ //visit child node
		Trace(pNode->getChild(), 0);
	}

	if(pNode->getBNext()!=pNode){ //visit sibling node
		pWalker=!(pHead) ? pNode:pHead;

		if(pNode->getBNext()!=pHead){
			Trace(pNode->getBNext(), pWalker);
		}
	}
}