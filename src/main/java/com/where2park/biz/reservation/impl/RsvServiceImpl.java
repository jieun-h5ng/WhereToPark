package com.where2park.biz.reservation.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.where2park.biz.chat.ChatVO;
import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.reservation.RsvService;
import com.where2park.biz.reservation.RsvVO;

@Service("rsvService")//비즈니스 객체
public class RsvServiceImpl implements RsvService {

		@Autowired
		private RsvDAOMybatis rsvDAO;

		@Autowired
		HttpSession session;
		
		@Override
		public void insertRsv(RsvVO vo) {
			rsvDAO.insertRsv(vo);	// 성공
//			RsvDAO.insertRsv(vo);	// 실패 후 전체 rollback 처리
		}

		@Override
		public void updateRsv(RsvVO vo) {
			rsvDAO.updateRsv(vo);
		}

		@Override
		public void deleteRsv(RsvVO vo) {
			rsvDAO.deleteRsv(vo);
		}

		@Override
		public RsvVO getRsv(RsvVO vo) {
			return rsvDAO.getRsv(vo);
		}

		@Override
		public List<RsvVO> getRsvList(RsvVO vo) {
			return rsvDAO.getRsvList(vo);
		}
		
		//채팅 안읽은 갯수 표시 - 은지 
		@Override
		public int selectNotReadMessage(RsvVO vo) {
			System.out.println("====>ChatServiceImpl.selectNotReadMessage 실행");
			return rsvDAO.selectNotReadMessage(vo);
		}
		
		//나예
		@Override
		public List<RsvVO> getRsvList_subscribe(RsvVO vo) {
			return rsvDAO.getRsvList_subscribe(vo);
		}

//		public List<RsvVO> getReviewOnParking(ParkingVO vo) {
//			return rsvDAO.getReviewOnParking(vo);
//		}
//		
}
