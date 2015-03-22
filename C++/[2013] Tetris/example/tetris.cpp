#include <stdio.h>
#include <windows.h>
#include <time.h>
#include <conio.h>
#define BW 10
#define BH 20
#define LEFT 75
#define RIGHT 77
#define UP 72
#define DOWN 80
#define SPACE 32

void gotoxy(int x, int y)
{ 
	COORD Cur;
	Cur.X=x;
	Cur.Y=y;
	SetConsoleCursorPosition
		(GetStdHandle(STD_OUTPUT_HANDLE),Cur);
}

typedef enum{NOCURSOR, SOLIDCURSOR, NORMALCURSOR} CURSOR_TYPE;
typedef enum{EMPTY,BRICK,WALL} BTYPE;
BTYPE map[BH+2][BW+2];
int score=0;
char* tile[]={".","бс","бр"};
void drawScreen();
bool moveDown();
bool colCheck(int x, int y, int b, int r);
bool processKey();
bool eraseBrick();
void printScore();


void setcursortype(CURSOR_TYPE c){
	CONSOLE_CURSOR_INFO CurInfo;

	switch (c) {
case NOCURSOR:
	CurInfo.dwSize=1;
	CurInfo.bVisible=FALSE;
	break;

case SOLIDCURSOR:
	CurInfo.dwSize=100;
	CurInfo.bVisible=TRUE;
	break;

case NORMALCURSOR:
	CurInfo.dwSize=20;
	CurInfo.bVisible=TRUE;
	break;
	}
	SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE),&CurInfo);
}

int x;
int y;
int r;
int Brick;
int cnt = 0;
void printBrick(bool show);

struct Point {
	int x,y;
};
Point Shape[][4][4]={
	{ {0,0,1,0,2,0,-1,0}, {0,0,0,1,0,-1,0,-2}, {0,0,1,0,2,0,-1,0}, {0,0,0,1,0,-1,0,-2} },

	{ {0,0,1,0,0,1,1,1}, {0,0,1,0,0,1,1,1}, {0,0,1,0,0,1,1,1}, {0,0,1,0,0,1,1,1} },

	{ {0,0,-1,0,0,-1,1,-1}, {0,0,0,1,-1,0,-1,-1}, {0,0,-1,0,0,-1,1,-1}, {0,0,0,1,-1,0,-1,-1} },

	{ {0,0,-1,-1,0,-1,1,0}, {0,0,-1,0,-1,1,0,-1}, {0,0,-1,-1,0,-1,1,0}, {0,0,-1,0,-1,1,0,-1} },

	{ {0,0,-1,0,1,0,-1,-1}, {0,0,0,-1,0,1,-1,1}, {0,0,-1,0,1,0,1,1}, {0,0,0,-1,0,1,1,-1} },

	{ {0,0,1,0,-1,0,1,-1}, {0,0,0,1,0,-1,-1,-1}, {0,0,1,0,-1,0,-1,1}, {0,0,0,-1,0,1,1,1} },

	{ {0,0,-1,0,1,0,0,1}, {0,0,0,-1,0,1,1,0}, {0,0,-1,0,1,0,0,-1}, {0,0,-1,0,0,-1,0,1} } 
};

int main(){
	for (int i=0;i<BH+2;i++){
		for(int j=0;j<BW+2; j++){
			map[i][j]=EMPTY;
			if(i==0)map[i][j]=WALL;
			if(i==BH+1)map[i][j]=WALL;
			if(j==0)map[i][j]=WALL;
			if(j==BW+1)map[i][j]=WALL;
		}
	}
	drawScreen();
	srand(unsigned int(GetTickCount()));
	int frame=100;
	while(1){
		x=BW /2;
		y=3;
		r=0;
		printScore();
		Brick=rand()%7;
		cnt =0 ;
		while(1){
			cnt++;

			if(cnt==20){

				if(moveDown())
					break;
				cnt =0 ;
			}
			if(processKey())
				break;
			Sleep(3000/frame);
		}
		while(true){
			if(!eraseBrick()) break;
		}
	}
	return 0;
}
void printScore(){
	gotoxy(30,10);
	printf("Score : %d",score);
}
bool eraseBrick(){
	bool isErase=false;
	for(int i=BH;i>0;i--){
		bool isFull=true;
		for(int j=1;j<=BW;j++){
			if(map[i][j]==EMPTY)
				isFull=false;
		}
		if(isFull){
			isErase=true;
			for(int j=i;j>1;j--){
				for(int k=1;k<=BW;k++){
					map[j][k]=map[j-1][k];
				}
			}
			drawScreen();
			score+=10;
		}
	}
	return isErase;
}
bool processKey(){
	if(kbhit()){
		int c = getch();
		if(c== SPACE){
			while(true){
				if(!colCheck(x,y+1,Brick,r))
					moveDown();
				else break;
			}
		}
		if(c== LEFT && !colCheck(x-1,y,Brick,r)){
			printBrick(false);
			x--;
			printBrick(true);
			
		}
		if(c== RIGHT && !colCheck(x+1,y,Brick,r)){
			printBrick(false);
			x++;
			printBrick(true);
		}
		if(c== DOWN ){
			if(moveDown()){
				cnt=0;
				return moveDown();
			}
		}
		if(c== UP && !colCheck(x,y,Brick,(r+1)%4)){
			printBrick(false);
			r++;
			r%=4;
			printBrick(true);
		}
	}
	return false;
}
bool moveDown(){
	if(colCheck(x,y+1,Brick,r)){
		for(int i =0 ;i<4;i++){
			map[Shape[Brick][r][i].y+y+1][Shape[Brick][r][i].x+x+1]=BRICK;
		}
		return true;
	}
	
	printBrick(false);
	y++;
	printBrick(true);

	return false;
}
bool colCheck(int x, int y, int b, int r){
	//map
	for(int i=0;i<4;i++){
		if(map[Shape[b][r][i].y+y+1][Shape[b][r][i].x+x+1] != EMPTY){
			return true;
		}
	}
	return false;
}
void printBrick(bool show){
	char* b;
	if(show==true){
		b=tile[BRICK];
	}
	else{
		b=tile[EMPTY];
	}
	for(int i=0;i<4;i++){
		gotoxy((x+1+Shape[Brick][r][i].x)* 2,(y+1+Shape[Brick][r][i].y));
		puts(b);
	}
}

void drawScreen(){
	for (int i=0;i<BH+2;i++){
		for(int j=0;j<BW+2; j++){
			char* b = tile[map[i][j]];
			gotoxy(j*2,i);
			puts(b);
		}
	}
}