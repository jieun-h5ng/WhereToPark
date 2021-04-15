package com.where2park.view.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.where2park.biz.notice.NoticeService;
import com.where2park.biz.notice.NoticeVO;

@Controller
public class NoticeController {
	//알람은 소켓이 끊어짐과 동시에 핸들러에서 생성된 객체도 사라져버려서 ajax를 사용해서 컨트롤러를 이용하여 유저정보셀렉및 입력
	@Autowired
	private NoticeService noticeService;
	@Autowired
	HttpSession session;
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	public NoticeController() {
		System.out.println("====>NoticeController 생성자 호출");
	}
	
	@RequestMapping("noticeView.do")
	public String notice(NoticeVO vo) {
		return "notice.jsp";
	}
	
	@RequestMapping("/selectNotice.do")
	@ResponseBody
	public List<NoticeVO> selectNotice(NoticeVO vo) {
		System.out.println(vo.getPageNum());
		//vo.setUser_id((int)session.getAttribute("userId"));
		System.out.println("selectNotice Controller : " + vo.getUser_id());
		List<NoticeVO> notice = noticeService.selectNotice(vo);
		//System.out.println(notice.get(0).getNot_message());
		if(notice == null) {
			notice.add(0, vo);
			System.out.println("출력된 notice가 존재하지 않습니다.");
		}
		return notice;
	}
	
	@RequestMapping("updateNoticeReadDate.do")
	@ResponseBody
	public void updateNoticeReadDate(NoticeVO vo) {
		noticeService.updateNoticeReadDate(vo);
		System.out.println("updateNoticeReadDate Controller .....");
	}
	
	@RequestMapping("/deleteNotice.do")
	@ResponseBody
	public void deleteNotice(NoticeVO vo) {
		noticeService.deleteNotice(vo);
	    System.out.println("deleteNotice Controller .....");
	}
	
	@RequestMapping("/selectNoticeUser.do")
	@ResponseBody
	public NoticeVO selectNoticeUser(NoticeVO vo) {
		NoticeVO ownerInfo = noticeService.selectNoticeUser(vo);
		vo.setParking_id(ownerInfo.getParkingVO().getParking_id());
		vo.setParkingVO(ownerInfo.getParkingVO());
		if(ownerInfo.getParkingVO().getOwner_id() != (int)session.getAttribute("userId") ) {
			vo.setUser_id(ownerInfo.getParkingVO().getOwner_id());
			System.out.println("NoticeController 오너아이디오ㅏ 유저아이디 불일치" + vo.getUser_id() + ownerInfo.getParkingVO().getOwner_id());
		}else {
			vo.setUser_id(ownerInfo.getRsvVO().getParker_id());
			System.out.println("NoticeController 오너아이디와 유저아이디 일치" + vo.getUser_id() + ownerInfo.getRsvVO().getParker_id());
		}
		
		return vo;
	} // 알림을 받을 유저의 정보 (user_id와 parking_id, rsv_id) 
	
	@RequestMapping("/insertNotice.do")
//	@ResponseBody
	public void insertNotice(@RequestBody NoticeVO vo) {
		System.out.println(vo.getUser_id() + "userID");
		System.out.println(vo.getNot_url());
		System.out.println(vo.getNot_type());
		System.out.println(vo.getRsv_id());
		//vo.setNot_url("searchParkingDetail.do?parking_id=33867"); 
		noticeService.insertNotice(vo);
		System.out.println("InsertNotice 완료*********************");
	}

}
