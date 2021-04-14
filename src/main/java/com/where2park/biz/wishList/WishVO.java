package com.where2park.biz.wishList;

import com.where2park.biz.parking.ParkingVO;

public class WishVO {
	private int wish_id;
	private int user_id;
	private int parking_id;
	
	private ParkingVO parkingVO;
	
	public WishVO() {
		
	}

	public int getWish_id() {
		return wish_id;
	}

	public void setWish_id(int wish_id) {
		this.wish_id = wish_id;
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

	@Override
	public String toString() {
		return "WishVO [wish_id=" + wish_id + ", user_id=" + user_id + ", parking_id=" + parking_id + "]";
	}

	public ParkingVO getParkingVO() {
		return parkingVO;
	}

	public void setParkingVO(ParkingVO parkingVO) {
		this.parkingVO = parkingVO;
	}
	
}
