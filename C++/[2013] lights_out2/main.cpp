#include<iostream>
#include<windows.h>
#include<conio.h> //kbhit을 위한 헤더
#include"LightsOut.h"
#include"Light.h"
#include"QueueStack.h"
#include"Node.h"
using namespace std;

void gotoxy(int x, int y){  //커서 이동용 함수
  COORD XY={x,y};
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),XY);
}

void HideCursor(){ //커서 숨기는 함수
  CONSOLE_CURSOR_INFO CurInfo;
  CurInfo.dwSize=1;
  CurInfo.bVisible=FALSE;
  SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE),&CurInfo);
}

void printMainMenu(int& Case){
  gotoxy(20,8);
  cout<<"========= Main =========";
  gotoxy(20,9);
  cout<<"|     Load Map         |";
  gotoxy(20,10);
  cout<<"|     Game Start       |";
  gotoxy(20,11);
  cout<<"|     End              |";
  gotoxy(20,12);
  cout<<"========================";
  gotoxy(23,Case+8);
  cout<<"▶";

  while(1){
    if(kbhit()){
      gotoxy(23,Case+8);
      cout<<"  ";
      int c=getch();
      if(c==72&&Case!=1)
        Case--;
      if(c==80&&Case!=3)
        Case++;
      if(c==13)
        break;
      gotoxy(23,Case+8);
      cout<<"▶";
    }
  }
}

void printMapMenu(char* fname){
  int Num=1;
  char* temp=fname;

  gotoxy(20,8);
  cout<<"====== Select Map ======";
  gotoxy(20,9);
  cout<<"|     Map1             |";
  gotoxy(20,10);
  cout<<"|     Map2             |";
  gotoxy(20,11);
  cout<<"|     Map3             |";
  gotoxy(20,12);
  cout<<"|     Map4             |";
  gotoxy(20,13);
  cout<<"|     Map5             |";
  gotoxy(20,14);
  cout<<"|     Map6             |";
  gotoxy(20,15);
  cout<<"|     Map7             |";
  gotoxy(20,16);
  cout<<"|     Map8             |";
  gotoxy(20,17);
  cout<<"|     Map9             |";
  gotoxy(20,18);
  cout<<"========================";
  gotoxy(23,Num+8);
  cout<<"▶";

  while(1){
    if(kbhit()){
      gotoxy(23,Num+8);
      cout<<"  ";
      int c=getch();
      if(c==72&&Num!=1)
        Num--;
      if(c==80&&Num!=9)
        Num++;
      if(c==13)
        break;
      gotoxy(23,Num+8);
      cout<<"▶";
    }
  }

  temp=temp+3;
  *temp=Num+48;
}
void printMenu(){ //Function for print out game menu
  gotoxy(20,8);
  cout<<"====== Lights Out ======";
  gotoxy(20,9);
  cout<<"|     z : Undo         |";
  gotoxy(20,10);
  cout<<"|     x : Reset        |";
  gotoxy(20,11);
  cout<<"|     c : Give up      |";
  gotoxy(20,12);
  cout<<"========================";
}

int main(){
  _CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF|_CRTDBG_LEAK_CHECK_DF); //Check memory leack
  HideCursor();

  int c=1, loaded=0, x=0, y=0, cnt=0;
  char yn, fname[16]={"Map .txt"}; //fname=>Array for a name of map
  LightsOut game; //Object for game

  while(c!=3){
    if(loaded==0){
      gotoxy(20,0);
      cout<<"========================";
      gotoxy(20,1);
      cout<<"|                      |";
      gotoxy(20,2);
      cout<<"|      Lgiths Out      |";
      gotoxy(20,3);
      cout<<"|                      |";
      gotoxy(20,4);
      cout<<"|      Made by SoW     |";
      gotoxy(20,5);
      cout<<"|                      |";
      gotoxy(20,6);
      cout<<"========================";
    }

    printMainMenu(c);

    switch(c){
      case 1:
        {
          printMapMenu(fname);
          system("cls");

          if(game.LoadMap(fname)){ //If load map success, print out loaded map
            game.PrintLights();
            loaded=1; //Change loaded state
          }
          else
            cout<<"There is no file"<<endl;
        }
        break;
      case 2:
        {
          if(loaded==0){ //If there is not loaded map, not start
            gotoxy(20,13);
            cout<<"There is no map. Please load map first"<<endl;
            Sleep(1000);
            gotoxy(20,13);
            cout<<"                                      "<<endl;
            break;
          }
          else
            game.Reset(); //Before start game, reset all of states

          gotoxy(25,13);
          cout<<"Game Start!!"<<endl;
          Sleep(1000); //Wait 0.5 second
          system("cls"); //Clear screen

          game.PrintLights();
          printMenu(); //Print out menu for game

          while(1){
            cnt++;
            if(cnt==10)
              game.ping(x,y,0);
            else if(cnt==20){
              game.ping(x,y,1);
              cnt=0;
            }

            if(kbhit()){
              game.ping(x,y,1);
              int ch=getch();
              if(ch==75&&x!=0)
                x--;
              if(ch==77&&x!=4)
                x++;
              if(ch==72&&y!=0)
                y--;
              if(ch==80&&y!=4)
                y++;
              if(ch==13){
                game.LightOnOff(x,y); //Light on/off of read coordinate
                game.Push(x,y); //Save coordinate into queuestacks
                game.PrintLights();
              }

              if(ch==122){ //Undo
                gotoxy(20,13);
                cout<<"Undo? (Y/N) : ";
                cin>>yn;

                if(yn=='Y'||yn=='y'){
                  if(!game.Undo()){ //If undo fail, warning to user
                    gotoxy(20,13);
                    cout<<"You can not any more undo!"<<endl;
                    Sleep(1000);
                  }
                }

                game.PrintLights();
                gotoxy(20,13);
                cout<<"                          ";
              }

              if(ch==120){ //Reset
                gotoxy(20,13);
                cout<<"Reset? (Y/N) : ";
                cin>>yn;

                if(yn=='Y'||yn=='y'){
                  game.Reset(); //Reset all history
                  Sleep(1000); //Wait 0.5 second
                  game.PrintLights();
                }
                gotoxy(20,13);
                cout<<"                          ";
              }

              if(ch==99){ //Give up!
                gotoxy(20,13);
                cout<<"Give up? (Y/N) : ";
                cin>>yn;

                gotoxy(20,13);
                cout<<"                          ";

                if(yn=='Y'||yn=='y'){
                  gotoxy(25,13);
                  cout<<"Game Over!!!"<<endl;
                  loaded=0;
                  game.Reset(); //Reset all history
                  Sleep(1000); //Wait 0.5 second
                  system("cls"); //Clear screen
                  break;
                }
              }

              if(game.IsSolved()){ //If all of lights are off, end game and save results
                gotoxy(25,13);
                cout<<"Game Over!!!";
                game.RecordSolution("Results.txt");
                gotoxy(20,15);
                cout<<"Record your solution and score on Results.txt!!"<<endl;
                gotoxy(20,16);
                cout<<"Go back to the main"<<endl;
                gotoxy(20,17);
                loaded=0;
                system("pause");
                system("cls");
                break;
              }
              cnt=0;
            }
            Sleep(20);
          }
        }
        break;
      case 3: //End program
        {
          gotoxy(20,13);
          cout<<"End!!"<<endl;
        }
        break;
    }
  }

  return 0;
}