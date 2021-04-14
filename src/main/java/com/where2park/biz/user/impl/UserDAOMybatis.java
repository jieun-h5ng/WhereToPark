package com.where2park.biz.user.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.where2park.biz.user.UserVO;

@Repository("userDAO")
public class UserDAOMybatis {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	//로그인
	public UserVO getUser(UserVO vo) {
		System.out.println("==> getUser() 기능처리");
		return (UserVO)mybatis.selectOne("UserDAO.getUser", vo);
	}
	//카카오로그인
	public UserVO kakaogetUser(UserVO vo) {
		System.out.println("==> kakaogetUser() 기능처리");
		return (UserVO)mybatis.selectOne("UserDAO.kakaogetUser", vo);
	}
	
	
	
	//회원가입
	public void insertUser(UserVO vo) {
		System.out.println("==> insertUser() 기능처리");
		mybatis.insert("UserDAO.insertUser", vo);
	}
	
	//자동차 정보 가입
	public void insertCarInfo(UserVO vo) {
		System.out.println("==> insertCarInfo() 기능처리");
		mybatis.insert("UserDAO.insertCarInfo", vo);
	}
	//회원정보
	public UserVO getUserinfo(UserVO vo) {
		System.out.println("==> getUserinfo() 기능처리");
		return (UserVO)mybatis.selectOne("UserDAO.getUserinfo", vo);
	}
	
	//수정
	public void updateUser(UserVO vo) {
		System.out.println("==> updateUser() 기능처리");
		mybatis.update("UserDAO.updateUser", vo);
	}
	
	//탈퇴
	public void deleteUser(UserVO vo) {
		System.out.println("==> deleteUser() 기능처리");
		mybatis.delete("UserDAO.deleteUser", vo);
	}
	
	//닉네임 중복체크
	public int nickChk(UserVO vo) {
		System.out.println("마이바티스 ==> 닉네임 중복검사");
		int result = mybatis.selectOne("UserDAO.nickChk", vo);
		System.out.println("닉네임 중복검사리턴값 " + result);
		return result;
	}
	//이메일 존재여부
	public int findemail(UserVO vo) {
		System.out.println("마이바티스 ==> 이메일 존재여부 검사");
		int email_result = mybatis.selectOne("UserDAO.findemail", vo);
		System.out.println("이메일 중복검사리턴값 :" + email_result);
		return email_result;
	}
	
	//비번 변경
	@Transactional
	public int updatePw(UserVO vo) {
		System.out.println("mybatis updatePw실행");
		return mybatis.update("UserDAO.upadtePw", vo);
		
	}
	
	//카 인포 
	public UserVO getUsercarInfo(UserVO vo) {
		System.out.println("==> getUsercarInfo() 기능처리");
		return (UserVO)mybatis.selectOne("UserDAO.getUsercarInfo", vo);
	}
	
	//수정 비번체크
	public int checkPw(UserVO vo) {
		System.out.println("==> checkPw() 비번 맞는지 기능처리");
		//return (UserVO)mybatis.selectOne("UserDAO.checkPw", vo);
		int pw_result = mybatis.selectOne("UserDAO.checkPw", vo);
		return pw_result;
	}
	
	
}
