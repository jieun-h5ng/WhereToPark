package com.where2park.view.handler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.where2park.biz.chat.ChatVO;
import com.where2park.view.controller.Chatroom;

@Component
public class WebSocketHandler extends TextWebSocketHandler {

	private List<WebSocketSession> sessions = new ArrayList<>();
	private final ObjectMapper objectMapper = new ObjectMapper();
	private static final String FILE_UPLOAD_PATH = "C:/test/websocket/";
	private Integer chatroom_id = 0;
	@Autowired
	@Qualifier("chatRoom")
	private Chatroom saveChat;

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		System.out.println("웹소켓 연결 : " + session.getId());

	}// 연결되어 있을 때

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		System.out.println("session.getId : " + session.getId());
		ChatVO chat = objectMapper.readValue(message.getPayload(), ChatVO.class);
		System.out.println(chat.getCheck() + "몇명이 들어와있을까요오오오오오오옹");
		Map<WebSocketSession, Integer> chatroom = saveChat.saveSession(session, chat.getChatroom_id());
//		if(chat.getMessage_type().equals("fileUpload")){
//			chatroom_id = chat.getChatroom_id();
//			System.out.println("파일전송준비");
//			}
		chat.setCheck(saveChat.searchSession(session));
		
		if (!chat.getMessage_type().equals("start")) { //입퇴장 메세지가 아닐경우에 
			saveChat.saveChatting(chat); //메세지 저장 
			}
		String jsonMsg = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(chat);
		for (WebSocketSession sess : chatroom.keySet()) {
			if (chatroom.get(sess).equals(chatroom.get(session))) {
				sess.sendMessage(new TextMessage(jsonMsg));
				System.out.println("메세지 전송 :" + message + sess.getId() + ":" + chat.getChatroom_id() + ":" + session.getId());
			}
		}
	}//Text 메시지 전송 

	@Override
	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
		System.out.println("파일전송준비.................................................");
//		ByteBuffer byteBuffer = message.getPayload();
//		System.out.println("파일전송준비.................................................");
//		String fileName = "temp.jpg";
//		File dir = new File(FILE_UPLOAD_PATH);
//		if(!dir.exists()) {
//			dir.mkdirs();
//		}
//		
//		File file = new File(FILE_UPLOAD_PATH, fileName);
//		FileOutputStream out = null;
//		FileChannel outChannel = null;
//		try {
//			byteBuffer.flip(); //byteBuffer를 읽기 위해 세팅
//			out = new FileOutputStream(file, true); //생성을 위해 OutputStream을 연다.
//			outChannel = out.getChannel(); //채널을 열고
//			byteBuffer.compact(); //파일을 복사한다.
//			outChannel.write(byteBuffer); //파일을 쓴다.
//		}catch(Exception e) {
//			e.printStackTrace();
//		}finally {
//			try {
//				if(out != null) {
//					out.close();
//				}
//				if(outChannel != null) {
//					outChannel.close();
//				}
//			}catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
//		
//		byteBuffer.position(0); //파일을 저장하면서 position값이 변경되었으므로 0으로 초기화한다.
//		//파일쓰기가 끝나면 이미지를 발송한다.
//		Map<WebSocketSession, Integer> chatroom = saveChat.saveSession(session, chatroom_id);
//		for (WebSocketSession sess : chatroom.keySet()) {
//			if (chatroom.get(sess).equals(chatroom.get(session))) {
//				try {
//					sess.sendMessage(new BinaryMessage(byteBuffer));//초기화된 버퍼 발송 
//					System.out.println("파일전송 진행완료.....");
//				} catch (IOException e) {
//					e.printStackTrace();
//					System.out.println("파일전송 진행중.....에러에러에러");
//				} 
//				
//			}
//		}
		
	}//image 메시지 전송 
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// saveChat.insertChat();
		saveChat.deleteSession(session);
		sessions.remove(session);
		System.out.println("연결 종료 : " + session.getId());
	}// 연결이 끊어졌을 때
}
