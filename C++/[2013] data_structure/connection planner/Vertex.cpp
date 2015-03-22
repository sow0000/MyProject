#include "Vertex.h"

Vertex::Vertex(){
	memset(m_cityName, 0, 20);
	m_range=0;
	m_base=0;
	m_iVertexID=-1;
	m_pEdge=0;
	m_pNext=0;
}

Vertex::Vertex(char* cityName, int range){
	memset(m_cityName, 0, 20);
	strcpy(m_cityName, cityName);
	m_range=range;
	m_base=0;
	m_iVertexID=-1;
	m_pEdge=0;
	m_pNext=0;
}

Vertex::~Vertex(){
	m_pEdge=0;
	m_pNext=0;
}

void Vertex::setCityName(char* cityName){
	strcpy(m_cityName, cityName);
}

void Vertex::setRange(int range){
	m_range=range;
}

void Vertex::setBase(int base){
	m_base=base;
}

void Vertex::setID(int iVertexID){
	m_iVertexID=iVertexID;
}

void Vertex::setEdge(Edge* pEdge){
	m_pEdge=pEdge;
}

void Vertex::setNext(Vertex* pNext){
	m_pNext=pNext;
}

char* Vertex::getCityName(){
	return m_cityName;
}

int Vertex::getRange(){
	return m_range;
}

int Vertex::getBase(){
	return m_base;
}

int Vertex::getID(){
	return m_iVertexID;
}

Edge* Vertex::getEdge(){
	return m_pEdge;
}

Vertex* Vertex::getNext(){
	return m_pNext;
}