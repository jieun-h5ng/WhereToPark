package com.where2park.biz.review.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.review.ReviewService;
import com.where2park.biz.review.ReviewVO;

@Service("reviewService")
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDAOMybatis reviewDAO;
	
	@Autowired
	HttpSession session;
	
	// 리뷰 목록에 지난 리뷰 가져오기
	@Override
	public List<ReviewVO> getReviewList(ReviewVO vo) {
		System.out.println(reviewDAO.getReviewList(vo));
		return reviewDAO.getReviewList(vo);
	}
	
	// 새 리뷰 작성에 예약정보 가져오기
	@Override
	public ReviewVO getReview(ReviewVO vo) {
		System.out.println(reviewDAO.getReview(vo));
		return reviewDAO.getReview(vo);
	}

	@Override
	public void insertReview(ReviewVO vo) {
		reviewDAO.insertReview(vo);
	}
	
	// 리뷰 수정에 리뷰상세 가져오기
	@Override
	public ReviewVO updateReviewView(ReviewVO vo) {
		return reviewDAO.updateReviewView(vo);
	}
	
	@Override
	public void updateReview(ReviewVO vo) {
		reviewDAO.updateReview(vo);
	}

	@Override
	public void deleteReview(ReviewVO vo) {
		reviewDAO.deleteReview(vo);
	}


}
