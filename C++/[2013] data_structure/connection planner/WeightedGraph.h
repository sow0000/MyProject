#pragma once
#include "Edge.h"
#include<string.h>

class WeightedGraph{
private:
	int m_iNumOfVertices; //vertex number
	int m_iNumOfEdges; //edge number
	Vertex* m_pRoot; //root

public:
	WeightedGraph(); //constructor
	~WeightedGraph(); //destrutcor

	bool IsEmpty(); //no vertices
	int NumberOfVertices(); //number of vertices in graph
	int NumberOfEdges(); //number of edges in graph
	int Degree(Vertex* pVertex); //number of edges incident to vertex
	bool ExistsEdge(Vertex* pV1, Vertex* pV2); //graph has egde
	void InsertVertex(Vertex* pVertex); //insert vertex
	void InsertEdge(Vertex* pV1, Vertex* pV2, int iWeight, int iChannel); //insert edge
	void DeleteVertex(Vertex* pVertex); //delete vertex and all edges
	void DeleteEdge(Vertex* pV1, Vertex* pV2); //delete edge
	Vertex* getVertex(char* cityName); //get vertex
	Vertex* getRoot(); //get root
};
