package com.where2park.biz.chat;

import java.util.List;

import com.where2park.biz.reservation.RsvVO;

public interface ChatService {
	//채팅방 생성
	void insertChatroom(ChatVO vo);
	
	//채팅방 조회
	ChatVO selectChatroom(ChatVO vo);

	//채팅 내용 삭제 (가능하면)
	ChatVO deleteChat(ChatVO vo);
	
//	//채팅입력
//	void insertChat(List<ChatVO> chatList);
	
	//채팅입력
	void insertChat(ChatVO vo);
	
	//채팅내용 불러오기
	List<ChatVO> selectChat(ChatVO vo);
	
	//채팅읽었는지 안읽었는지 업데이트
	void updateMessageReadDate(ChatVO vo);
	
	//채팅 안읽은 갯수 표시 - 은지
	int selectNotReadMessage(ChatVO vo);
	
}
