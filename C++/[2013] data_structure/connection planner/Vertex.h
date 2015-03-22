#pragma warning(disable:4996)
#pragma once
#include<string.h>

class Edge;

class Vertex{
private:
	char m_cityName[20];
	int m_range;
	int m_base;
	int m_iVertexID;
	Edge* m_pEdge;
	Vertex* m_pNext;

public:
	Vertex();
	Vertex(char* cityName, int range);
	~Vertex();

	void setCityName(char* cityName);
	void setRange(int range);
	void setBase(int base);
	void setID(int iVertexID);
	void setEdge(Edge* pEdge);
	void setNext(Vertex* pNext);
	char* getCityName();
	int getRange();
	int getBase();
	int getID();
	Edge* getEdge();
	Vertex* getNext();
};
