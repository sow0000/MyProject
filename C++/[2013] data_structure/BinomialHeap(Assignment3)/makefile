CC = g++
OBJ = main.o binnode.o bintree.o file.o linkedlist.o memoryallocator.o
NAME = Assignment3
$(NAME): $(OBJ)
	$(CC) -o $(NAME) $(OBJ)
main.o:main.cpp
	$(CC) -c main.cpp
binnode.o:binnode.cpp binnode.h
	$(CC) -c binnode.cpp
bintree.o:bintree.cpp bintree.h
	$(CC) -c bintree.cpp
file.o:file.cpp file.h
	$(CC) -c file.cpp
linkedlist.o:linkedlist.cpp linkedlist.h
	$(CC) -c linkedlist.cpp
memoryallocator.o:memoryallocator.cpp memoryallocator.h
	$(CC) -c memoryallocator.cpp

clean:
	rm -rf $(OBJ)
