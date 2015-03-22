package com.socket;

import java.net.*;
import java.io.*;
public class MultiServerThread implements Runnable{
    private Socket socket;							//���ϸ��
    private MultiServer ms;							//��Ƽ ���� ���
    private ObjectInputStream ois;					//��ǲ��Ʈ��	(RECIEVE)
    private ObjectOutputStream oos;					//�ƿ�ǲ ��Ʈ��  (SEND)
    public MultiServerThread(MultiServer ms){		//��Ƽ ������ ������
        this.ms = ms;
    }
    public synchronized void run(){
        boolean isStop = false;
        try{
            socket = ms.getSocket();				//���� ����� ������ ������
            ois = new ObjectInputStream(socket.getInputStream());		//��ǲ��Ʈ�� ����
            oos = new ObjectOutputStream(socket.getOutputStream());		//�ƿ�ǲ ��Ʈ�� ����
            String message = null;										//�޽��� �� ��� NULL
            while(!isStop){												//ISSTOP�϶����� ����
                message = (String)ois.readObject();						//�޽��� �� ��ǲ��Ʈ�� ������Ʈ���� �о��
                String[] str = message.split("#");						//STR�迭 ���� #�����ڷ� ����
                if(str[1].equals("exit")){								//0= ID  1=MESSAGE (MESSAGE�� EXIT �� ��ο��� ��ε� ĳ�����ϰ�
                    broadCasting(message);								//ISSTOP�� TRUE�� ����� ����)
                    isStop = true;
                }else{
                    broadCasting(message);								//�ƴϸ�  �޽����� ��ο��� ��ε� ĳ���� 0 = ID 1 = MESSAGE
                }
            }
            ms.getList().remove(this);									//����� ����Ʈ���� ����(���� )�� ���� �ϰ� IP�� ���� �޽��� ��� (�ܼ�â)
            System.out.println(socket.getInetAddress()+
                    "���������� �����ϼ̽��ϴ�");
            System.out.println("list size : "+ms.getList().size());		//���� ����Ʈ �� ����� ������ (���� �����ڼ� �� ������)
        }catch(Exception e){
            ms.getList().remove(this);
            System.out.println(socket.getInetAddress()+					//����ó�� 
                    "������������ �����ϼ̽��ϴ�");
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
