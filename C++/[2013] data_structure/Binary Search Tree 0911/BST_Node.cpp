#include "BST_Node.h"
#include <iostream>

BST_Node::BST_Node()
{
	ch_element='0';
	for(int current=0;current<2;current++)
		pChild[current]=NULL;
}

BST_Node::BST_Node(char c)
{
	ch_element=c;
	for(int current=0;current<2;current++)
		pChild[current]=NULL;
}
BST_Node::~BST_Node()
{
	ch_element='0';
}
