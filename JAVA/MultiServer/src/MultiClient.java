package com.socket;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.net.*;
import javax.swing.*;

public class MultiClient implements ActionListener{

	private Socket socket;						//소켓 명시
	private ObjectInputStream ois;				//인풋 스트림 명시
	private ObjectOutputStream oos;				//아웃풋 스트림 명시
	//------------------------------------------------------
	//AWT요소 
	//------------------------------------------------------
	private JFrame jframe;
	private JTextField jtf;
	private JTextArea jta;
	private JLabel jlb1,jlb2;
	private JPanel jp1,jp2;
	private JButton jbtn;
	//ID 및 IP 생성
	private String ip;
	private String id;
	

	public MultiClient(String argIp, String argId){
		ip = argIp;
		id = argId;
		jframe = new JFrame("Multi Chatting");
		jtf = new JTextField(30);
		jta = new JTextArea("",10,50);
		jlb1 = new JLabel("Usage ID : [["+id +"]]");
		jlb2 = new JLabel("IP : "+ip);
		jbtn = new JButton("종료");
		
		//JPanel에 BorderLayout를 적용해서 컴포넌트 배치
		jp1 = new JPanel();
		jp2 = new JPanel();
		jlb1.setBackground(Color.YELLOW);
		jlb2.setBackground(Color.GREEN);
		jta.setBackground(Color.PINK);
		jp1.setLayout(new BorderLayout());
		jp2.setLayout(new BorderLayout());

		jp1.add(jbtn, BorderLayout.EAST);
		jp1.add(jtf, BorderLayout.CENTER);
		jp2.add(jlb1, BorderLayout.CENTER);
		jp2.add(jlb2, BorderLayout.EAST);

		jframe.add(jp1, BorderLayout.SOUTH);
		jframe.add(jp2, BorderLayout.NORTH);

		//데이터 량이 많아지면 스크롤 처리 해야 하기 때문에 JScrollPane 객체 생성

		JScrollPane jsp = new JScrollPane(jta,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
				JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		jframe.add(jsp, BorderLayout.CENTER);
		jtf.addActionListener(this);
		jbtn.addActionListener(this);
		jframe.addWindowListener(new WindowAdapter(){
			public void windowClosing(WindowEvent e){
				try{
					oos.writeObject(id+"#exit");
				}catch(IOException ee){
					ee.printStackTrace();
				}
				System.exit(0);
			}
			public void windowOpened(WindowEvent e){
				jtf.requestFocus();
			}
		});
		jta.setEditable(false);

		//스크린 사이즈를 구하기 위해 Toolkit 객체 생성
		Toolkit tk =Toolkit.getDefaultToolkit();
		Dimension d= tk.getScreenSize();

		int screenHeight = d.height;
		int screenWidth = d.width;

		//화면의 크기를 지정하지 않아 아래처럼 pack()를 동작시키면 사용된 모든 컴퍼넌트의 크기를 인식해서
		//자연스럽게 화면 크기를지정함 
		jframe.pack();

		//모니터 화면 중앙에 어플리케이션 배치  
		jframe.setLocation((screenWidth - jframe.getWidth())/2, 
				(screenHeight - jframe.getHeight())/2 );
		jframe.setResizable(false);
		jframe.setVisible(true);

	}
	
	//액션 퍼포먼스 (버튼이 눌렸을때....발생)

	
	//메시지 작성을 위해 jTextField 에 데이터를 입히고 enter를 치면 ActionEvent가 발생함
	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		Object obj = e.getSource();	//오브젝트 소스에서 오브젝트 값을 읽어옴 
		String msg = jtf.getText();	//메시지 읽어옴 (입력 TEXTFIELD에서 MSG STRING 값으로저장)



		if (obj==jtf){
			if (msg==null||msg.length()==0){//글을 쓰지 않고 이벤트 발생 시 경고창 팝업
				JOptionPane.showMessageDialog(jframe, "글을쓰세요","경고",JOptionPane.WARNING_MESSAGE);
			}
			else{		//으외의 상황에서는 메시지 전송
				try{
					//입력한 데이터를 (id#메시지 )형태로 서버로 전송 
					oos.writeObject(id+"#"+msg);		//출력스트림에 ID#메시지로 전달
				}catch(IOException ee){
					ee.printStackTrace();
				}
				jtf.setText("");						//메시지가 출력스트림으로 전달되면 입력창에 기존 문자를 지우고 빈문자삽입
			}
		}
		else if (obj==jbtn){//종료 버튼 클릭시 종료 처리			
			try{
				//id#exit 형태로 서버로 메시지 전달해서 프로그램 종료를 알림
				oos.writeObject(id+"#exit");
			}catch(IOException ee){
				ee.printStackTrace();
			}
			System.exit(0);		//시스템 종료
		}

	}
	
	
	public void exit(){
		System.exit(0);						//시스템 종료 
	}
	public void init()throws IOException{
		socket = new Socket(this.ip,5000);		//소켓 생성 IP.PORT
		System.out.println("connected....");		
		oos=new ObjectOutputStream(socket.getOutputStream());	//출력스트림생성
		ois=new ObjectInputStream(socket.getInputStream());		//입력스트림생성
		//oos=new ObjectOutputStream(socket.getOutputStream());//순서 바뀌면 잘안됨
		MultiClientThread ct = new MultiClientThread(this);		//멀티 스레드 생성
		Thread t = new Thread(ct);								//스레드 생성 (멀티 스레드) 
		t.start();												//스ㅏ레드 시작
	}
	public static void main(String args[]) throws IOException{
		JFrame.setDefaultLookAndFeelDecorated(true);
		MultiClient cc= new MultiClient("10.0.2.37","Pyopie");//용탁이네
		cc.init();
	}
	public ObjectInputStream getOis(){
		return ois;
	}
	public JTextArea getJta(){
		return jta;
	}
	public String getId(){
		return id;
	}

}
