package com.where2park.biz.review.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.reservation.RsvVO;
import com.where2park.biz.review.ReviewVO;

@Repository("reviewDAO")
public class ReviewDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 리뷰 목록에 지난 리뷰 가져오기
	public List<ReviewVO> getReviewList(ReviewVO vo){
		System.out.println("⇒ Mybatis로 getReviewList() 기능");
		return mybatis.selectList("ReviewDAO.getReviewList", vo);
	}
	
	// 새 리뷰 작성에 예약정보 가져오기
	public ReviewVO getReview(ReviewVO vo) {
		System.out.println("⇒ Mybatis로 getReview() 기능");
		return (ReviewVO)mybatis.selectOne("ReviewDAO.getReview", vo);
	}
	
	public void insertReview(ReviewVO vo) {
		System.out.println("⇒ Mybatis로 insertReview() 기능");
		mybatis.insert("ReviewDAO.insertReview", vo);
	}
	
	public void deleteReview(ReviewVO vo) {
		System.out.println("⇒ Mybatis로 deleteReview() 기능");
		mybatis.delete("ReviewDAO.deleteReview", vo);
	}
	
	// 리뷰 수정에 리뷰상세 가져오기
	public ReviewVO updateReviewView(ReviewVO vo) {
		System.out.println("⇒ Mybatis로 updateReviewView() 기능");
		return (ReviewVO)mybatis.selectOne("ReviewDAO.updateReviewView", vo);
	}
	
	public void updateReview(ReviewVO vo) {
		System.out.println("⇒ Mybatis로 updateReview() 기능");
		mybatis.update("ReviewDAO.updateReview", vo);
	}

//	public List<ReviewVO> getReviewOnParking(ParkingVO vo) {
//		return mybatis.selectList("ReviewDAO.getReviewOnParking", vo);
//	}
	
}
