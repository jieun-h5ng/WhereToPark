package com.where2park.biz.notice.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.where2park.biz.notice.NoticeService;
import com.where2park.biz.notice.NoticeVO;
import com.where2park.biz.review.ReviewVO;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDAOMybatis noticeDAO;
	
	public NoticeServiceImpl() {
		System.out.println("NoticeServiceImpl 생성자 호출");
	}
	
	@Override
	public List<NoticeVO> selectNotice(NoticeVO vo) {
		System.out.println("====>NoticeServiceImpl.selectNotice 실행");
		return noticeDAO.selectNotice(vo);
	}

	@Override
	public void updateNoticeReadDate(NoticeVO vo) {
		System.out.println("====>NoticeServiceImpl.updateNoticeReadDate 실행");
		noticeDAO.updateNoticeReadDate(vo);
	}
	
	@Override
	public void deleteNotice(NoticeVO vo) {
		System.out.println("====>NoticeServiceImpl.deleteNotice 실행");
		noticeDAO.deleteNotice(vo);
	}
	
	@Override
	public NoticeVO selectNoticeUser(NoticeVO vo) {
		System.out.println("====>NoticeServiceImpl.selectNoticeUser 실행");
		return noticeDAO.selectNoticeUser(vo);
	}
	
	@Override
	public void insertNotice(NoticeVO vo) {
		System.out.println("====>NoticeServiceImpl.insertNotice 실행");
		noticeDAO.insertNotice(vo);
	}




}
