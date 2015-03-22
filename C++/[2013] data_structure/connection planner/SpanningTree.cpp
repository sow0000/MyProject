#include "SpanningTree.h"

SpanningTree::SpanningTree(){
	state=0;
	m_iParent=0;
	edgeNum=0;
	vertexNum=0;
	cost=0;
	MinQueue=new BinomialMin();
	m_pRoot=0;
}

SpanningTree::~SpanningTree(){
	delete m_iParent;
	delete MinQueue;
	delete m_pRoot;
}

bool SpanningTree::span(int num){
	vertexNum=num;
	m_iParent=new int[vertexNum];
	for(int current=0;current<num;current++){
		m_iParent[current]=current;
	}

	int v=0, w=0;
	BinMinNode *iter=0;
	Edge *eiter1=0;
	Edge *eiter2=0;
	Vertex *viter1=0;
	Vertex *viter2=0;

	while(iter=MinQueue->Delete()){
		eiter1=iter->getEdge();
		viter1=eiter1->getVertex();
		eiter2=viter1->getEdge();
		while(eiter2->getWeight()!=eiter1->getWeight()){
			eiter2=eiter2->getNext();
		}
		viter2=eiter2->getVertex();

		v=viter1->getID();
		w=viter2->getID();

		if(find(v)!=find(w)){
			unionVertex(v,w);

			if(!m_pRoot){
				m_pRoot=iter;
			}
			else{
				iter->setBNext(m_pRoot);
				m_pRoot=iter;
			}
			cost+=iter->getWeight();
			edgeNum++;
		}
		else{
			delete iter;
		}
	}

	delete[] m_iParent;

	if(edgeNum!=vertexNum-1){
		state=1;
		return false;
	}

	return true;
}

int SpanningTree::isUsable(){
	return state;
}

int SpanningTree::find(int v){
	return (v==m_iParent[v]) ? v:(m_iParent[v]=find(m_iParent[v]));
}

void SpanningTree::unionVertex(int v, int w){
	if(v>w){
		m_iParent[find(v)]=w;
	}
	else{
		m_iParent[find(w)]=v;
	}
}

void SpanningTree::insertQueue(Edge *pEdge){
	BinMinNode *pWalker=m_pRoot;

	while(pWalker){
		if(pWalker->getWeight()==pEdge->getWeight()){
			return;
		}
		pWalker=pWalker->getBNext();
	}

	pWalker=new BinMinNode(pEdge);
	MinQueue->Insert(pWalker);
}