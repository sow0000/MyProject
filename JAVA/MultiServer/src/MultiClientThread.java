package com.socket;

public class MultiClientThread extends Thread{
	private MultiClient mc;
	public MultiClientThread(MultiClient mc){
		this.mc=mc;
	}
	public void run(){
		String message = null;
		String[] receivedMsg = null;
		boolean isStop = false;
		while(!isStop){
			try{
				//�������� ���޵� ������ ó��
				message = (String)mc.getOis().readObject();
				//id# �޽��� ���·� ���޵Ǹ� #�� �������� id�� �޽��� �и�
				receivedMsg = message.split("#");
			}catch(Exception e){
				e.printStackTrace();
				//������ �߻��ϸ� isStop�� true �� �Ҵ� while ������ ��������
				isStop = true;
			}
			//id 				message
			System.out.println(receivedMsg[0]+ ", "+ receivedMsg[1]);
			//�޽����� exit �ְ� 
			if(receivedMsg[1].equals("exit")){
				//���۵� ���̵� ����� ���̵�� ������ ���
				if (receivedMsg[0].equals(mc.getId())){
					mc.exit();
				}
				//���̵� �ٸ���쿡�� ����� ���Ḧ �ǹ��ϴ°��� �ƴ϶� Ÿ �̿��ڰ� ������Ḧ �ϴ� ���̱� ������
				//�ش� ����ڰ� ���� �ߴٴ� �޽����� �����
				else{
					mc.getJta().append(receivedMsg[0]+"���� ���� �ϼ˽��ϴ�.."+System.getProperty("line.separator"));
					mc.getJta().setCaretPosition(mc.getJta().getDocument().getLength());
				}
			}
			else {
				//�޼����� exit �� ���Ե��� �ʾ��� ���
				mc.getJta().append(receivedMsg[0]+" : " +receivedMsg[1]+System.getProperty("line.separator"));
				mc.getJta().setCaretPosition(mc.getJta().getDocument().getLength());
			}
		}
	}
}
