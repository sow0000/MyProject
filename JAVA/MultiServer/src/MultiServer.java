package com.socket;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;

public class MultiServer {
	private ArrayList<MultiServerThread> list; //��Ƽ ���� ������ ����Ʈ ��� - �پ��� ���� �ݿ�
	private Socket socket;						//���� ���
	public MultiServer() throws IOException{	//��Ƽ ���� ������ IOEXCEPTION
		list = new ArrayList<MultiServerThread>();	//��� ����Ʈ ����Ʈ ����
		ServerSocket serverSocket = new ServerSocket(5000);	//���� ���� ���� (��Ʈ =5000)
		MultiServerThread mst = null;						//��Ƽ ������ ���
		boolean isStop = false;								//���� ��ž FALSE
		while(!isStop){										//������ ISSTOP�϶����� ������
			System.out.println("Server ready ....");		//���� �غ�Ϸ� �޼���
			socket = serverSocket.accept();					//accept()���� ó������ ���� ������� ����ϰ� �ִ� ť���� ���� ó�� �����
															//������ �����ͼ� ���ο� ����� ������ �����. 
															//�׸��� ������ ����Ű�� ���� �����ڸ� �Ҵ��ϰ� �̰��� �����Ѵ�.
			mst = new MultiServerThread(this);				//��Ƽ ������ ����
			list.add(mst);									//����Ʈ�� ��Ƽ ������ �߰�
			Thread t = new Thread(mst);						//������ ����
			t.start();										//������ ����
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
