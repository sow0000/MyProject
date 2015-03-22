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
				//서버에서 전달된 데이터 처리
				message = (String)mc.getOis().readObject();
				//id# 메시지 형태로 전달되면 #을 기준으로 id와 메시지 분리
				receivedMsg = message.split("#");
			}catch(Exception e){
				e.printStackTrace();
				//오류가 발생하면 isStop에 true 를 할당 while 루프를 빠져나옴
				isStop = true;
			}
			//id 				message
			System.out.println(receivedMsg[0]+ ", "+ receivedMsg[1]);
			//메시지에 exit 있고 
			if(receivedMsg[1].equals("exit")){
				//전송된 아이디가 사용자 아이디와 동일할 경우
				if (receivedMsg[0].equals(mc.getId())){
					mc.exit();
				}
				//아이디가 다를경우에는 사용자 종료를 의미하는것이 아니라 타 이용자가 사용종료를 하는 것이기 때문에
				//해당 사용자가 종료 했다는 메시지를 출력함
				else{
					mc.getJta().append(receivedMsg[0]+"님이 종료 하셧습니다.."+System.getProperty("line.separator"));
					mc.getJta().setCaretPosition(mc.getJta().getDocument().getLength());
				}
			}
			else {
				//메세지의 exit 가 포함되지 않았을 경우
				mc.getJta().append(receivedMsg[0]+" : " +receivedMsg[1]+System.getProperty("line.separator"));
				mc.getJta().setCaretPosition(mc.getJta().getDocument().getLength());
			}
		}
	}
}
