class BST_Node
{
public:
	char ch_element;
	BST_Node *pChild[2];

public:
	BST_Node();
	BST_Node(char c);
	virtual ~BST_Node();
};
