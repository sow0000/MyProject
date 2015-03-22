#include "ConnectionPlanner.h"

ConnectionPlanner::ConnectionPlanner(){ //constructor
	lp=new File_IO();
	con=new File_IO();
	cities=new File_IO();
	fout=new File_IO();
	graph=new WeightedGraph();
	MaxQueue=new BinomialMax();
	currentBase=1;
}

ConnectionPlanner::~ConnectionPlanner(){ //destrutcor
	delete lp;
	delete con;
	delete cities;
	delete fout;
	delete graph;
	delete MaxQueue;
}

bool ConnectionPlanner::Start(){
	if(!Graph()){ //make weighted graph
		cout<<"Build Graph Fail"<<endl;
		return false;
	}

	SpanningTree* sTree=new SpanningTree[currentBase-2];
	for(int current=0;current<currentBase-2;current++){
		Span(&sTree[current], current+1);
	}

	if(!lp->InputFileOpen("Mp4.lp")){ //input file open
		cout<<"There is no file"<<endl;
		return false;
	}

	char* getLine=0; //read line
	char* cityName=0; //city name
	char* charNum1=0;
	char* charNum2=0;
	int num1=0;
	int num2=0;

	while(getLine=lp->GetLine()){
		cityName=strtok(getLine, " ");
		charNum1=strtok(NULL, " ");
		charNum2=strtok(NULL, " ");
		num1=atoi(charNum1);
		num2=atoi(charNum2);


	}
	
	lp->Close();

	return true;
}

bool ConnectionPlanner::Graph(){
	if(!con->InputFileOpen("Mp4.con")){
		cout<<"There is no file"<<endl;
		return false;
	}
	if(!cities->InputFileOpen("Mp4.cities")){
		cout<<"There is no file"<<endl;
		return false;
	}

	char* getLine=0; //read line
	char* cityName1=0; //city name
	char* cityName2=0;
	char* charNum1=0;
	char* charNum2=0;
	int num1=0;
	int num2=0;
	
	while(getLine=cities->GetLine()){
		cityName1=strtok(getLine, " ");
		charNum1=strtok(NULL, " ");
		num1=atoi(charNum1);

		Vertex* pNew=new Vertex(cityName1, num1);
		if(num1==currentBase){
			pNew->setBase(1);
			currentBase++;
		}
		graph->InsertVertex(pNew);
	}

	Vertex* pV1=0;
	Vertex* pV2=0;

	while(getLine=con->GetLine()){
		cityName1=strtok(getLine, " ");
		cityName2=strtok(NULL, " ");
		charNum1=strtok(NULL, " ");
		charNum2=strtok(NULL, " ");
		num1=atoi(charNum1);
		num2=atoi(charNum2);

		pV1=graph->getVertex(cityName1);
		pV2=graph->getVertex(cityName2);

		graph->InsertEdge(pV1, pV2, num1, num2);
	}

	con->Close();
	cities->Close();

	return true;
}

bool ConnectionPlanner::Span(SpanningTree *sTree, int range){
	if(sTree->isUsable()){
		return false;
	}

	Vertex* iter=graph->getRoot();
	Vertex* dest=0;
	Edge* eiter=0;
	int ID=0;

	while(iter){ //set ID & input into queue
		if(iter->getRange()==range||iter->getBase()==1){
			iter->setID(ID); //set ID
			ID++;

			eiter=iter->getEdge();

			while(eiter){ //input edges in range into queue
				dest=eiter->getVertex();

				if(dest->getRange()==range||dest->getBase()==1){
					if(dest->getID()==-1){
						sTree->insertQueue(eiter);
					}
				}

				eiter=eiter->getNext();
			}
		}

		iter=iter->getNext();
	}

	if(!sTree->span(ID)){
		return false;
	}

	return true;
}
