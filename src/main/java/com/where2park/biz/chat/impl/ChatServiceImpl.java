package com.where2park.biz.chat.impl;

import java.util.ArrayList;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.where2park.biz.chat.ChatService;
import com.where2park.biz.chat.ChatVO;
import com.where2park.biz.reservation.RsvVO;

@Service("chatService")
public class ChatServiceImpl implements ChatService {
	@Autowired
	private ChatDAOMybatis chatDAO;
	
	ChatServiceImpl(){
		System.out.println("ChatServiceImpl 생성자 호출");
	}

	
	@Override
	public void insertChatroom(ChatVO vo) {
		System.out.println("====>ChatServiceImpl.insertChatroom 실행");
		chatDAO.insertChatroom(vo);
	} // 채팅방 개설

	@Override
	public ChatVO selectChatroom(ChatVO vo) {
		System.out.println("====>ChatServiceImpl.selectChatroom 실행");
		return chatDAO.selectChatroom(vo);
	} //채팅방 검색 (채팅방을 재접속 했을 때 사용)
	


	@Override
	public ChatVO deleteChat(ChatVO vo) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void insertChat(ChatVO vo) {
		System.out.println("====>ChatServiceImpl.insertChat 실행");
		chatDAO.insertChat(vo);
		
	}


	@Override
	public List<ChatVO> selectChat(ChatVO vo) {
		System.out.println("====>ChatServiceImpl.selectChat 실행");
		return chatDAO.selectChat(vo);
	}


	@Override
	public void updateMessageReadDate(ChatVO vo) {
		System.out.println("====>ChatServiceImpl.updateMessageReadDate 실행");
		chatDAO.updateMessageReadDate(vo);
	}

	//채팅 안읽은 갯수 표시 - 은지 
	@Override
	public int selectNotReadMessage(ChatVO vo) {
		System.out.println("====>ChatServiceImpl.selectNotReadMessage 실행");
		return chatDAO.selectNotReadMessage(vo);
	}

//	@Override
//	public void insertChat(List<ChatVO> chatList) {
//		System.out.println("====>ChatServiceImpl.insertChat 실행");
//		chatDAO.insertChat(chatList);
//		
//	}



}

