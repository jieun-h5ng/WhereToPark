package com.where2park.biz.chat.impl;

import java.util.ArrayList;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.where2park.biz.chat.ChatVO;
import com.where2park.biz.reservation.RsvVO;

@Repository("chatDAO")
public class ChatDAOMybatis {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void insertChatroom(ChatVO vo) {
		System.out.println("===> Mybatis로 insertChatroom() 기능 처리");
		mybatis.insert("ChatDAO.insertChatroom", vo);
		//mybatis.commit();
	}
	
	public ChatVO selectChatroom(ChatVO vo) {
		System.out.println("===> Mybatis로 selectChatroom() 기능 처리");
		return (ChatVO)mybatis.selectOne("ChatDAO.selectChatroom", vo);
	}
	
//	public void insertChat(List<ChatVO> chatList) {
//		System.out.println("===> Mybatis로 insertChat() 기능 처리");
//		mybatis.insert("ChatDAO.insertChat", chatList);
//	}
	
	public void insertChat(ChatVO vo) {
	System.out.println("===> Mybatis로 insertChat() 기능 처리");
	mybatis.insert("ChatDAO.insertChat", vo);
	}
	
	public List<ChatVO> selectChat(ChatVO vo){
		System.out.println("===> Mybatis로 selectChat() 기능 처리");
		return mybatis.selectList("ChatDAO.selectChat", vo);
	}
	
	public void updateMessageReadDate(ChatVO vo) {
		System.out.println("===> Mybatis로 updateMessageReadDate처리");
		mybatis.update("ChatDAO.updateMessageReadDate", vo);
		
	}
	
	//채팅 안읽은 갯수 표시 - 은지 
	public int selectNotReadMessage(ChatVO vo) {
		System.out.println("===>Mybatis로 selectNotReadMessage 기능 구현");
		return mybatis.selectOne("ChatDAO.selectNotReadMessage", vo);
	}


}