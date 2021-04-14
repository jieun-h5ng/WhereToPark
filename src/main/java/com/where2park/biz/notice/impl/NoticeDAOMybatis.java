package com.where2park.biz.notice.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.where2park.biz.notice.NoticeVO;
import com.where2park.biz.review.ReviewVO;

@Repository("noticeDAO")
public class NoticeDAOMybatis {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<NoticeVO> selectNotice(NoticeVO vo) {
		System.out.println("===> Mybatis로 selectNotice() 기능 처리");
		return mybatis.selectList("NoticeDAO.selectNotice", vo);
	}
	
	public void updateNoticeReadDate(NoticeVO vo) {
		System.out.println("====>Mybatis로 updateNoticeReadDate() 기능 처리");
		mybatis.update("NoticeDAO.updateNoticeReadDate", vo);
	}
	
	public void deleteNotice(NoticeVO vo) {
		System.out.println("====>Mybatis로 deleteNotice() 기능 처리");
		mybatis.delete("NoticeDAO.deleteNotice", vo);
		
	}
	
	public NoticeVO selectNoticeUser(NoticeVO vo) {
		System.out.println("===> Mybatis로 selectNoticeUser() 기능 처리");
		return mybatis.selectOne("NoticeDAO.selectNoticeUser", vo);
	}
	
	public void insertNotice(NoticeVO vo) {
		System.out.println("====>Mybatis로 insertNotice() 기능 처리실행");
		mybatis.insert("NoticeDAO.insertNotice", vo);	
	}
}
