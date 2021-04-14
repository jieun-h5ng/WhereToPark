package com.where2park.view.controller;

import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

import com.where2park.biz.chat.ChatService;
import com.where2park.biz.chat.ChatVO;

@Component("chatRoom")
public class Chatroom {
	@Autowired
	@Qualifier("chatService")
	ChatService chatService;
	
	private Map<WebSocketSession, Integer> chatroom = new HashMap<>();
	
	public Chatroom() {
		System.out.println("Chatroom 생성자 호출");
	}
	
	public void saveChatting (ChatVO vo){
		Timestamp now = new Timestamp(System.currentTimeMillis());
		vo.setMessage_datetime(now);

		System.out.println("=====>chatroom save Chatting<======");
		System.out.println(vo.getChatroom_id());
		System.out.println(vo.getUser_id());
		System.out.println(vo.getMessage_datetime());
		System.out.println(vo.getMessage_content());

		chatService.insertChat(vo);
	}
	
	public Map<WebSocketSession, Integer> saveSession (WebSocketSession session, Integer chatroom_id ) {
		if(!chatroom.containsKey(session)) { //chatroom에 파라미터로 받은 세션과 동일한 세션이 없으면 추가해줌 
		try {
			chatroom.put(session, chatroom_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println(chatroom.get(session) + " : chatroom에 새롭게 추가된 세션");
		}
		
		return chatroom;
	}
	
	public int searchSession (WebSocketSession session) {
		int check = 0;
		for (int i = 0; i < chatroom.size(); i++) {
			if(chatroom.containsKey(session)) {
				check ++;
			}
		}
		
		return check;
	}
	
	public void deleteSession(WebSocketSession session) {
		chatroom.remove(session);
	}
	
	
}
