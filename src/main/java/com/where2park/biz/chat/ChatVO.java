package com.where2park.biz.chat;

import java.sql.Timestamp;
import java.util.Date;

public class ChatVO {
	private int message_id;
	private int chatroom_id;
	private Date chatroom_datetime;
	private int rsv_id;
	private int parker_id;
	private int user_id;
	private String message_content;
	private Timestamp message_datetime;
	private Date message_read_datetime;
	private String message_type;
	private int check;
	
	public int getMessage_id() {
		return message_id;
	}
	public void setMessage_id(int message_id) {
		this.message_id = message_id;
	}
	public int getChatroom_id() {
		return chatroom_id;
	}
	public void setChatroom_id(int chatroom_id) {
		this.chatroom_id = chatroom_id;
	}
	public Date getChatroom_datetime() {
		return chatroom_datetime;
	}
	public void setChatroom_datetime(Date chatroom_datetime) {
		this.chatroom_datetime = chatroom_datetime;
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
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getMessage_content() {
		return message_content;
	}
	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}
	public Date getMessage_datetime() {
		return message_datetime;
	}
	public void setMessage_datetime(Timestamp message_dateTime) {
		this.message_datetime = message_dateTime;
	}
	public Date getMessage_read_date() {
		return message_read_datetime;
	}
	public void setMessage_read_date(Date message_read_datetime) {
		this.message_read_datetime = message_read_datetime;
	}
	
	public String getMessage_type() {
		return message_type;
	}
	public void setMessage_type(String message_type) {
		this.message_type = message_type;
	}
		public int getCheck() {
		return check;
	}
	public void setCheck(int check) {
		this.check = check;
	}
	@Override
	public String toString() {
		return "ChatVO [message_id=" + message_id + ", chatroom_id=" + chatroom_id + ", chatroom_datetime="
				+ chatroom_datetime + ", rsv_id=" + rsv_id + ", parker_id=" + parker_id + ", user_id=" + user_id
				+ ", message_content=" + message_content + ", message_dateTime=" + message_datetime
				+ ", message_read_date=" + message_read_datetime + "]";
	}

}
