package com.where2park.biz.notice;

import java.util.List;

import com.where2park.biz.review.ReviewVO;

public interface NoticeService {
	//알림내역 모아보기
	List<NoticeVO> selectNotice(NoticeVO vo);
	
	//알림페이지에 접속했을때 알림읽은날 추가 
	void updateNoticeReadDate(NoticeVO vo);
	
	//알림삭제버튼을 누르면 알림내역 삭제
	void deleteNotice(NoticeVO vo);
	
	//알림을 받을 유저의정보 조회  
	NoticeVO selectNoticeUser(NoticeVO vo);
	
	//알림업데이트 
	void insertNotice(NoticeVO vo);
}
