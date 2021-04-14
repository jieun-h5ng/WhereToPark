package com.where2park.view.controller;

import java.sql.Timestamp;

import java.util.ArrayList;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.where2park.biz.chat.ChatService;
import com.where2park.biz.chat.ChatVO;

@Controller
//webSocket으로 접속 가능한 url정보를 명시 소켓서버 생성, 이 클래스는 서버라는 것을 명시 (싱글톤 패턴으로 관리)
public class ChattingController {
	//private final SimpMessagingTemplate simpMessagingTemplate = null;
	
	@Autowired
	@Qualifier("chatService")
	private ChatService chatService;
	
	@Autowired
	HttpSession session;

	public ChattingController() {
		System.out.println("======>채팅 컨트롤러 객체 생성");
	}
	
//	@RequestMapping("/selectNotReadMessagedo")
//	public int selectNotReadMessage(List) {
//
//		return 
//	}
	
	@RequestMapping("/insertChatroom.do")
	public String insertChatroom(ChatVO vo) {
//		//insertRsv 한다음에 거기서 rsv_id랑 paker_id받아서 넣어줘야됨 - 은지
		chatService.insertChatroom(vo);
		return "/chatroom.do";
	}
	
	@RequestMapping("/chatroom.do")
	public String openChatroom(ChatVO vo, Model model) {
		//채팅방 아이디 받아오기 
		int chatroom = chatService.selectChatroom(vo).getChatroom_id();
		
		if(chatroom == 0) { //채팅방아이디가없다면  채팅방 생성
			return "/insertChatroom.do";
		}
			
		vo.setUser_id((int)session.getAttribute("userId"));
		vo.setChatroom_id(chatroom);
		
		//메세지 읽음표시 업데이트
		chatService.updateMessageReadDate(vo);
		
		System.out.println("**********[ chatroom_id : " + chatroom +" : "+ "/ 입장자 아이디 : " + (int)session.getAttribute("userId") +"]**********");
		
		//채팅방 아이디와 예약아이디 넘겨주기 
		model.addAttribute("chatroom", chatroom);
		model.addAttribute("rsvId", vo.getRsv_id());
		
		vo.setChatroom_id(chatroom);

		//전에 입력된 채팅의 내용 불러오기 
		model.addAttribute("message", chatService.selectChat(vo));
		
		return "/chat-random.jsp";
	}
	
	
	@RequestMapping("/updateMessageRead.do")
	@ResponseBody
	public void updateMessageRead(ChatVO vo) {
		System.out.println(vo.getChatroom_id());
		System.out.println(vo.getUser_id());
		chatService.updateMessageReadDate(vo);
	} // ajax를 통해서 읽은 채팅날짜 실시간 업데이트 
}

