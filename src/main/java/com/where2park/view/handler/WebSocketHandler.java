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
		System.out.println("접속한 인원 수 : " + chat.getCheck());
		Map<WebSocketSession, Integer> chatroom = saveChat.saveSession(session, chat.getChatroom_id());
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
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// saveChat.insertChat();
		saveChat.deleteSession(session);
		sessions.remove(session);
		System.out.println("연결 종료 : " + session.getId());
	}// 연결이 끊어졌을 때
}
