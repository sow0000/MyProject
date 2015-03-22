package com.socket;

import java.net.*;
import java.io.*;
public class MultiServerThread implements Runnable{
    private Socket socket;							//소켓명시
    private MultiServer ms;							//멀티 서버 명시
    private ObjectInputStream ois;					//인풋스트림	(RECIEVE)
    private ObjectOutputStream oos;					//아웃풋 스트림  (SEND)
    public MultiServerThread(MultiServer ms){		//멀티 쓰레드 생성자
        this.ms = ms;
    }
    public synchronized void run(){
        boolean isStop = false;
        try{
            socket = ms.getSocket();				//현재 연결된 소켓을 가져옴
            ois = new ObjectInputStream(socket.getInputStream());		//인풋스트림 생성
            oos = new ObjectOutputStream(socket.getOutputStream());		//아웃풋 스트림 생성
            String message = null;										//메시지 값 명시 NULL
            while(!isStop){												//ISSTOP일때까지 루프
                message = (String)ois.readObject();						//메시지 값 인풋스트림 오브젝트에서 읽어옴
                String[] str = message.split("#");						//STR배열 생성 #구분자로 분해
                if(str[1].equals("exit")){								//0= ID  1=MESSAGE (MESSAGE가 EXIT 면 모두에게 브로딩 캐스팅하고
                    broadCasting(message);								//ISSTOP을 TRUE로 만들어 종료)
                    isStop = true;
                }else{
                    broadCasting(message);								//아니면  메시지를 모두에게 브로딩 캐스팅 0 = ID 1 = MESSAGE
                }
            }
            ms.getList().remove(this);									//종료시 리스트에서 소켓(연결 )을 제거 하고 IP와 종료 메시지 출력 (콘솔창)
            System.out.println(socket.getInetAddress()+
                    "정상적으로 종료하셨습니다");
            System.out.println("list size : "+ms.getList().size());		//현재 리스트 값 사이즈를 보여줌 (현재 접속자수 를 보여줌)
        }catch(Exception e){
            ms.getList().remove(this);
            System.out.println(socket.getInetAddress()+					//예외처리 
                    "비정상적으로 종료하셨습니다");
            System.out.println("list size : "+ms.getList().size());
        }
    }
    
    public void broadCasting(String message)throws IOException{
        for(MultiServerThread ct : ms.getList()){
           ct.send(message);
        }
    }
    
    public void send(String message)throws IOException{
        oos.writeObject(message);        
    }
}
