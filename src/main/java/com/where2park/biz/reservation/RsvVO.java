package com.where2park.biz.reservation;

import java.sql.Timestamp;
import java.util.Date;

import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.review.ReviewVO;
import com.where2park.biz.user.UserVO;

public class RsvVO {

	private int rsv_id;
	private int parker_id;
	private int owner_id;
	private int parking_id;
	private int rsv_price;
	private Date rsv_intime;
	private Date rsv_outtime;
	private int rsv_states;

	private ParkingVO parkingVO; //조인할 주차장 객체
	private UserVO userVO; //조인할 유저객체
	private ReviewVO reviewVO;

	public ReviewVO getReviewVO() {
		return reviewVO;
	}

	public void setReviewVO(ReviewVO reviewVO) {
		this.reviewVO = reviewVO;
	}

	public UserVO getUserVO() {
		return userVO;
	}

	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}

	public ParkingVO getParkingVO() {
		return parkingVO;
	}

	public void setParkingVO(ParkingVO parkingVO) {
		this.parkingVO = parkingVO;
	}

	public int getRsv_id() {
		return rsv_id;
	}

	public void setRsv_id(int rsv_id) {
		this.rsv_id = rsv_id;
	}

	public int getParker_id() {
		return parker_id;
	}

	public void setParker_id(int parker_id) {
		this.parker_id = parker_id;
	}

	public int getOwner_id() {
		return owner_id;
	}

	public void setOwner_id(int owner_id) {
		this.owner_id = owner_id;
	}

	public int getParking_id() {
		return parking_id;
	}

	public void setParking_id(int parking_id) {
		this.parking_id = parking_id;
	}

	public int getRsv_price() {
		return rsv_price;
	}

	public void setRsv_price(int rsv_price) {
		this.rsv_price = rsv_price;
	}

	public Date getRsv_intime() {
		return rsv_intime;
	}

	public void setRsv_intime(Date rsv_intime) {
		this.rsv_intime = rsv_intime;
	}

	public Date getRsv_outtime() {
		return rsv_outtime;
	}

	public void setRsv_outtime(Date rsv_outtime) {
		this.rsv_outtime = rsv_outtime;
	}

	public int getRsv_states() {
		return rsv_states;
	}

	public void setRsv_states(int rsv_states) {
		this.rsv_states = rsv_states;
	}

	@Override
	public String toString() {
		return "RsvVO [rsv_id=" + rsv_id + ", parker_id=" + parker_id + ", parking_id="
				+ parking_id + ", rsv_price=" + rsv_price + ", "
				+ (rsv_intime != null ? "rsv_intime=" + rsv_intime + ", " : "")
				+ (rsv_outtime != null ? "rsv_outtime=" + rsv_outtime + ", " : "") + "rsv_states=" + rsv_states + "]";
	}


}
