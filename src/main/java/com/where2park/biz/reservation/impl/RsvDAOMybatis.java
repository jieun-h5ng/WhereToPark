package com.where2park.biz.reservation.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.where2park.biz.chat.ChatVO;
import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.reservation.RsvVO;

@Repository("rsvDAO")
public class RsvDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

		public void insertRsv(RsvVO vo) {
			System.out.println("===>Mybatis로 insertRsv 기능 구현");
			mybatis.insert("RsvDAO.insertRsv", vo);
		}

	public void updateRsv(RsvVO vo) {
		System.out.println("===>Mybatis로 updateRsv 기능 구현");
		mybatis.update("RsvDAO.updateRsv", vo);
	}

	public void deleteRsv(RsvVO vo) {
		System.out.println("===>Mybatis로 deleteRsv 기능 구현");
		mybatis.delete("RsvDAO.deleteRsv", vo);
	}

	public RsvVO getRsv(RsvVO vo) {
		System.out.println("===>Mybatis로 getRsv 기능 구현");
		return (RsvVO) mybatis.selectOne("RsvDAO.getRsv", vo);
	}

	public List<RsvVO> getRsvList(RsvVO vo) {
		System.out.println("===>Mybatis로 getRsvList 기능 구현");
		return mybatis.selectList("RsvDAO.getRsvList", vo);
	}
	
	
	//채팅 안읽은 갯수 표시 - 은지 
	public int selectNotReadMessage(RsvVO vo) {
		System.out.println("===>Mybatis로 selectNotReadMessage 기능 구현");
		return mybatis.selectOne("ChatDAO.selectNotReadMessage", vo);
	}
	
	//나예
	public List<RsvVO> getRsvList_subscribe(RsvVO vo) {
		System.out.println("===>Mybatis로 getRsvList_subscribe 기능 구현");
		return mybatis.selectList("RsvDAO.getRsvList_subscribe", vo);
	}
	
	
//	public List<RsvVO> getReviewOnParking(ParkingVO vo) {
//		System.out.println("===>Mybatis로 getReviewOnParking 기능 구현");
//		return mybatis.selectList("RsvDAO.getReviewOnParking", vo);
//	}
}
