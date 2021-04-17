package com.where2park.biz.reservation;

import java.util.List;

import com.where2park.biz.chat.ChatVO;
import com.where2park.biz.parking.ParkingVO;

public interface RsvService {

	void insertRsv(RsvVO vo);
	void updateRsv(RsvVO vo);
	void deleteRsv(RsvVO vo);
	RsvVO getRsv(RsvVO vo);
	List<RsvVO> getRsvList(RsvVO vo);
	List<RsvVO> getRsvList_subscribe(RsvVO vo);
	
	
	//채팅 안읽은 갯수 표시 - 은지
	int selectNotReadMessage(RsvVO vo);
}

