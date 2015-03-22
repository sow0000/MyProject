#pragma once
#include "Vertex.h"

class Edge{
private:
	int m_iWeight;
	int m_iChannel;
	int m_iUsedChannel;
	Edge* m_pAdjList;
	Vertex* m_pVertex;

public:
	Edge();
	Edge(int iWeight, int iChannel, Vertex* pVertex);
	~Edge();

	void setWeight(int iWeight);
	void setUsed(int channel);
	void setNext(Edge* pEdge);
	void setVertex(Vertex* pVertex);
	bool isUsed();
	int getWeight();
	Edge* getNext();
	Vertex* getVertex();
};
