package com.where2park.biz.review;

import java.sql.Timestamp;

//import java.util.List;

import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.reservation.RsvVO;
import com.where2park.biz.user.UserVO;

public class ReviewVO {
	private int review_id;	
	private int user_id;	
	private int rsv_id;	
	private Timestamp review_date;
	private String review_content;	
	private int review_rating;
	
	private RsvVO rsvVO;
	private ParkingVO parkingVO;
	private UserVO userVO;
	
	// ? 필요한가 ?
//	private List<ReviewVO> reviewList;
	
	// ? 필요한가 ?
//	public List<ReviewVO> getReviewList() {
//		return reviewList;
//	}
//	public void setReviewList(List<ReviewVO> reviewList) {
//		this.reviewList = reviewList;
//	}
	public ReviewVO() {
	}
	public int getReview_id() {
		return review_id;
	}
	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getRsv_id() {
		return rsv_id;
	}
	public void setRsv_id(int rsv_id) {
		this.rsv_id = rsv_id;
	}
	public Timestamp getReview_date() {
		return review_date;
	}
	public void setReview_date(Timestamp review_date) {
		this.review_date = review_date;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public int getReview_rating() {
		return review_rating;
	}
	public void setReview_rating(int review_rating) {
		this.review_rating = review_rating;
	}
	@Override
	public String toString() {
		return "ReviewVO [review_id=" + review_id + ", user_id=" + user_id + ", rsv_id=" + rsv_id + ", review_date="
				+ review_date + ", review_content=" + review_content + ", review_rating=" + review_rating + "]";
	}
	
	public RsvVO getRsvVO() {
		return rsvVO;
	}
	public void setRsvVO(RsvVO rsvVO) {
		this.rsvVO = rsvVO;
	}
	public ParkingVO getParkingVO() {
		return parkingVO;
	}
	public void setParkingVO(ParkingVO parkingVO) {
		this.parkingVO = parkingVO;
	}
	public UserVO getUserVO() {
		return userVO;
	}
	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}
}
