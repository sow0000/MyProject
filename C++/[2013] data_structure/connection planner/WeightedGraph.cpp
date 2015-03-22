#include "WeightedGraph.h"

WeightedGraph::WeightedGraph(){ //constructor
	m_iNumOfVertices=0;
	m_iNumOfEdges=0;
	m_pRoot=0;
}

WeightedGraph::~WeightedGraph(){ //destrutcor
}

bool WeightedGraph::IsEmpty(){ //no vertices
	return !m_pRoot ? true:false;
}

int WeightedGraph::NumberOfVertices(){ //number of vertices in graph
	return m_iNumOfVertices;
}

int WeightedGraph::NumberOfEdges(){ //number of edges in graph
	return m_iNumOfEdges;
}

int WeightedGraph::Degree(Vertex* pVertex){ //number of edges incident to vertex
	Edge* iter=pVertex->getEdge();
	int degree;
	
	for(degree=0;iter;degree++){
		iter=iter->getNext();
	}

	return degree;
}

bool WeightedGraph::ExistsEdge(Vertex* pV1, Vertex* pV2){ //graph has egde
	Edge* iter=pV1->getEdge();
	
	while(iter){
		if(iter->getVertex()==pV2){
			return true;
		}
		iter=iter->getNext();
	}

	return false;
}

void WeightedGraph::InsertVertex(Vertex* pVertex){ //insert vertex
	if(IsEmpty()){
		m_pRoot=pVertex;
		return;
	}
	
	Vertex* iter=m_pRoot;
	Vertex* pLast=0;

	while(iter){
		pLast=iter;
		iter=iter->getNext();
	}

	pLast->setNext(pVertex);

	m_iNumOfVertices++;
}

void WeightedGraph::InsertEdge(Vertex* pV1, Vertex* pV2, int iWeight, int iChannel){ //insert edge
	if(ExistsEdge(pV1, pV2)){
		return;
	}

	Edge* iter=pV1->getEdge();
	Edge* pNew=new Edge(iWeight, iChannel, pV2);
	Edge* pLast=0;

//pV1->pV2
	if(!iter){
		pV1->setEdge(pNew);
	}
	else{
		while(iter){
			pLast=iter;
			iter=iter->getNext();
		}
		pLast->setNext(pNew);
	}

//pV2->pV1
	pNew=new Edge(iWeight, iChannel, pV1);
	iter=pV2->getEdge();

	if(!iter){
		pV2->setEdge(pNew);
	}
	else{
		while(iter){
			pLast=iter;
			iter=iter->getNext();
		}
		pLast->setNext(pNew);
	}

	m_iNumOfEdges++;
}

void WeightedGraph::DeleteVertex(Vertex* pVertex){ //delete vertex and all edges
	if(IsEmpty()){
		return;
	}
	
	Vertex* iter=m_pRoot;
	Vertex* pLast=0;

	while(iter==pVertex){
		pLast=iter;
		iter=iter->getNext();
		if(!iter){
			return;
		}
	}

	Edge* eiter=pVertex->getEdge();
	Vertex* pV2=0;

	while(eiter){
		pV2=eiter->getVertex();
		eiter=eiter->getNext();

		DeleteEdge(iter, pV2);
	}

	delete pVertex;

	m_iNumOfVertices--;
}

void WeightedGraph::DeleteEdge(Vertex* pV1, Vertex* pV2){ //delete edge
	Edge* iter=pV1->getEdge();
	Edge* pLast=0;

	//pV1->pV2
	while(iter){
		if(iter->getVertex()==pV2){
			break;
		}
		pLast=iter;
		iter=iter->getNext();
	}

	if(!iter){
		return;
	}
	else if(!pLast){
		pV1->setEdge(iter->getNext());
	}
	else{
		pLast->setNext(iter->getNext());
	}

	delete iter;

	//pV2->pV1
	iter=pV2->getEdge();

	while(iter){
		if(iter->getVertex()==pV1){
			break;
		}
		pLast=iter;
		iter=iter->getNext();
	}

	if(!iter){
		return;
	}
	else if(!pLast){
		pV2->setEdge(iter->getNext());
	}
	else{
		pLast->setNext(iter->getNext());
	}

	delete iter;


	m_iNumOfEdges--;
}

Vertex* WeightedGraph::getVertex(char* cityName){ //get vertex
	Vertex* iter=m_pRoot;

	while(iter){
		if(!strcmp(iter->getCityName(),cityName)){
			return iter;
		}
		iter=iter->getNext();
	}

	return 0;
}

Vertex* WeightedGraph::getRoot(){ //get root
	return m_pRoot;
}