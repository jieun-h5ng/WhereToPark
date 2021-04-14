package com.where2park.biz.user;

import org.springframework.web.multipart.MultipartFile;

public class UserVO {
	private int user_id;
	private String user_email;
	private String user_password;
	private String user_nickname;
	private String user_phone;
	private String user_pic;
	private String car_num;
	private String car_type;
	private String car_location;
	
	//파일 업로드 변수 추가
	private MultipartFile uploadFile_F;
	
	
	
	public MultipartFile getUploadFile_F() {
		return uploadFile_F;
	}
	public void setUploadFile_F(MultipartFile uploadFile_F) {
		this.uploadFile_F = uploadFile_F;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_pic() {
		return user_pic;
	}
	public void setUser_pic(String user_pic) {
		this.user_pic = user_pic;
	}
	public String getCar_num() {
		return car_num;
	}
	public void setCar_num(String car_num) {
		this.car_num = car_num;
	}
	public String getCar_type() {
		return car_type;
	}
	public void setCar_type(String car_type) {
		this.car_type = car_type;
	}
	public String getCar_location() {
		return car_location;
	}
	public void setCar_location(String car_location) {
		this.car_location = car_location;
	}
	@Override
	public String toString() {
		return "UserVO [user_id=" + user_id + ", user_email=" + user_email + ", user_password=" + user_password
				+ ", user_nickname=" + user_nickname + ", user_phone=" + user_phone + ", user_pic=" + user_pic
				+ ", car_num=" + car_num + ", car_type=" + car_type + ", car_location=" + car_location + "]";
	}
	
	
	
	
	
}
