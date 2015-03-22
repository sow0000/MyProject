package com.socket;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;

public class MultiServer {
	private ArrayList<MultiServerThread> list; //멀티 서버 스레드 리스트 명시 - 다양한 유저 반영
	private Socket socket;						//소켓 명시
	public MultiServer() throws IOException{	//멀티 서버 생성자 IOEXCEPTION
		list = new ArrayList<MultiServerThread>();	//어레이 리스트 리스트 생성
		ServerSocket serverSocket = new ServerSocket(5000);	//서버 소케 생성 (포트 =5000)
		MultiServerThread mst = null;						//멀티 스레드 명시
		boolean isStop = false;								//서버 스탑 FALSE
		while(!isStop){										//서버가 ISSTOP일때까지 루프돔
			System.out.println("Server ready ....");		//서버 준비완료 메세지
			socket = serverSocket.accept();					//accept()아직 처리되지 않은 연결들이 대기하고 있는 큐에서 제일 처음 연결된
															//연결을 가져와서 새로운 연결된 소켓을 만든다. 
															//그리고 소켓을 가르키는 파일 지정자를 할당하고 이것을 리턴한다.
			mst = new MultiServerThread(this);				//멀티 스레드 생성
			list.add(mst);									//리스트에 멀티 스레드 추가
			Thread t = new Thread(mst);						//스레드 생성
			t.start();										//스레드 시작
		}
	}
	public ArrayList<MultiServerThread> getList(){
		return list;
	}
	public Socket getSocket(){
		return socket;
	}
	public static void main(String[] args) throws IOException{
		new MultiServer();

	}

}
