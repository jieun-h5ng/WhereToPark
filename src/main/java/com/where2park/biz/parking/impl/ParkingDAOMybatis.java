package com.where2park.biz.parking.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.reservation.RsvVO;
import com.where2park.biz.review.ReviewVO;

@Repository("parkingDAO")
public class ParkingDAOMybatis {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	
//	public ParkingVO getParking() {
//		System.out.println("===> Mybatis로 getParking() 기능 처리");
//		return (ParkingVO)mybatis.selectOne("ParkingDAO.getParking");
//	}


	public List<ParkingVO> getParkingList(ParkingVO vo) {
		System.out.println("===> Mybatis로 getParkingList() 기능 처리");
		return mybatis.selectList("ParkingDAO.getParkingList" , vo);
	}


	public ParkingVO getParking(ParkingVO vo) {
		System.out.println("===> Mybatis로 getParking() 기능 처리");
		return (ParkingVO)mybatis.selectOne("ParkingDAO.getParking", vo);
	}


	public void insertParking(ParkingVO vo) {
		System.out.println("===> Mybatis로 insertParking() 기능 처리");
		mybatis.insert("ParkingDAO.insertParking", vo);
		
	}

	public void updateParking(ParkingVO vo) {
		System.out.println("--> updateParking() 기능처리");
		mybatis.update("ParkingDAO.updateParking", vo);
		
	}

	//예약있으면 체크
	public int deleteParking(ParkingVO vo) {
		System.out.println("--> deleteParking()기능처리");
		System.out.println(vo.getParking_id());
		
		int result = mybatis.selectOne("RsvDAO.deleteParking", vo);
		System.out.println("result :: " + result);
		return result;
	}


	public void updateParking_deleted(ParkingVO vo) {
		System.out.println("--> updateParking_deleted()기능처리");
		mybatis.update("ParkingDAO.updateParking_deleted", vo);
	}
	
	public void updateParking_down(ParkingVO vo) {
		mybatis.update("ParkingDAO.updateParking_down", vo);
	}
	
	public void updateParking_ori(ParkingVO vo) {	
		mybatis.update("ParkingDAO.updateParking_ori", vo);
	}


	public List<ParkingVO> getLongParkingList(ParkingVO vo) {
		System.out.println("===> Mybatis로 getLongParkingList() 기능 처리");
		return mybatis.selectList("ParkingDAO.getLongParkingList",vo);
	}


	public List<ParkingVO> getAllParkingList(ParkingVO vo) {
		System.out.println("===> 장기주차장 검색 탭 클릭");
		return mybatis.selectList("ParkingDAO.getAllParkingList",vo);
	}


	public List<RsvVO> getDateList(ParkingVO vo) {
		return mybatis.selectList("ParkingDAO.getDateList",vo);

	}
	
	//메인페이지에서 장기 주차글로 넘어가는 서비스 - 은지 
	public List<ParkingVO> mainGetParkingList(ParkingVO vo) {
		System.out.println("===> Mybatis로 mainGetParkingList() 기능 처리 : 메인페이지에서 실행");
		return mybatis.selectList("ParkingDAO.mainGetParkingList", vo);

	}
	//메인페이지 위치기반 주차장 추천 - 은지 
	public List<ParkingVO> getRecommendation(ParkingVO vo) {
		System.out.println("===> Mybatis로 getRecommendation() 기능 처리 : 메인페이지에서 실행");
		return mybatis.selectList("ParkingDAO.getRecommendation", vo);
	}

	public List<ReviewVO> getReviewOnParking(ParkingVO vo) {
		return mybatis.selectList("ReviewDAO.getReviewOnParking",vo);
	}


	public List<Integer> countReview(ParkingVO vo) {
		return mybatis.selectList("ReviewDAO.countReview",vo);
	}


	public List<ParkingVO> getAllShortParkingList(ParkingVO vo) {
		// TODO Auto-generated method stub
		return mybatis.selectList("ParkingDAO.getAllShortParkingList",vo);
	}
	public List<ParkingVO> getShortParkingList(ParkingVO vo) {
		// TODO Auto-generated method stub
		return mybatis.selectList("ParkingDAO.getShortParkingList",vo);
	}

}
