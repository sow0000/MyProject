#include "Edge.h"

Edge::Edge(){
	m_iWeight=0;
	m_iChannel=0;
	m_iUsedChannel=0;
	m_pAdjList=0;
	m_pVertex=0;
}

Edge::Edge(int iWeight, int iChannel, Vertex* pVertex){
	m_iWeight=iWeight;
	m_iChannel=iChannel;
	m_iUsedChannel=0;
	m_pAdjList=0;
	m_pVertex=pVertex;
}

Edge::~Edge(){
	m_pAdjList=0;
	m_pVertex=0;
}

void Edge::setWeight(int iWeight){
	m_iWeight=iWeight;
}

void Edge::setNext(Edge* pEdge){
	m_pAdjList=pEdge;
}

void Edge::setVertex(Vertex* pVertex){
	m_pVertex=pVertex;
}

int Edge::getWeight(){
	return m_iWeight;
}

Edge* Edge::getNext(){
	return m_pAdjList;
}

Vertex* Edge::getVertex(){
	return m_pVertex;
}