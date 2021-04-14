package com.where2park.view.handler;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.where2park.biz.notice.NoticeVO;
import com.where2park.view.controller.Chatroom;

@Component
public class NoticeHandler extends TextWebSocketHandler {
	private List<WebSocketSession> sessions = new ArrayList<>();
	private final ObjectMapper objectMapper = new ObjectMapper();
	private Map<Integer, WebSocketSession> notice = new HashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		System.out.println("---------> notice 웹소켓 추가");
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		NoticeVO vo = objectMapper.readValue(message.getPayload(), NoticeVO.class);
		System.out.println(vo.getNot_message() + vo.getNot_type() + vo.getUser_id());
		if(vo.getNot_type().equals("test")) {
			notice.put(vo.getUser_id(), session); //웹소켓연결때 발신된 메세지에서 user_id를 받아서 저장해준다.
		}
		if(vo.getNot_type().equals("review") || vo.getNot_type().equals("reservation") || vo.getNot_type().equals("cancel") || vo.getNot_type().equals("chatting")) {
			notice.get(vo.getUser_id()).sendMessage(message);
			System.out.println("알림메세지 전송" + vo.getUser_id() +" : "+ message);
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
		sessions.remove(session);
		System.out.println("---------> notice 웹소켓 삭제");
	}

}
