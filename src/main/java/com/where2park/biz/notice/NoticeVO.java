package com.where2park.biz.notice;

import java.sql.Timestamp;

import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.reservation.RsvVO;

public class NoticeVO {
	private int not_id;
	private int user_id;
	private int parking_id;
	private int rsv_id;
	private String not_type;
	private String not_message;
	private String not_url;
	private Timestamp not_datetime;
	private Timestamp not_read_datetime;
	private int pageNum;
	
	private RsvVO rsvVO;
	private ParkingVO parkingVO;
	
	public int getNot_id() {
		return not_id;
	}
	public void setNot_id(int not_id) {
		this.not_id = not_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getParking_id() {
		return parking_id;
	}
	public void setParking_id(int parking_id) {
		this.parking_id = parking_id;
	}
	public int getRsv_id() {
		return rsv_id;
	}
	public void setRsv_id(int rsv_id) {
		this.rsv_id = rsv_id;
	}
	public String getNot_type() {
		return not_type;
	}
	public void setNot_type(String not_type) {
		this.not_type = not_type;
	}
	public String getNot_message() {
		return not_message;
	}
	public void setNot_message(String not_message) {
		this.not_message = not_message;
	}
	public String getNot_url() {
		return not_url;
	}
	public void setNot_url(String not_url) {
		this.not_url = not_url;
	}
	public Timestamp getNot_datetime() {
		return not_datetime;
	}
	public void setNot_datetime(Timestamp not_datetime) {
		this.not_datetime = not_datetime;
	}
	public Timestamp getNot_read_datetime() {
		return not_read_datetime;
	}
	public void setNot_read_datetime(Timestamp not_read_datetime) {
		this.not_read_datetime = not_read_datetime;
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
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int page) {
		this.pageNum = page;
	}
	
	@Override
	public String toString() {
		return "NoticeVO [not_id=" + not_id + ", user_id=" + user_id + ", parking_id=" + parking_id + ", rsv_id="
				+ rsv_id + ", not_type=" + not_type + ", not_message=" + not_message + ", not_url=" + not_url
				+ ", not_datetime=" + not_datetime + ", not_read_datetime=" + not_read_datetime + ", rsvVO=" + rsvVO
				+ ", parkingVO=" + parkingVO + "]";
	}

	
}
