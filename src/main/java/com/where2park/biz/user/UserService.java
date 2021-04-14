package com.where2park.biz.user;

public interface UserService {
	
	void insertUser(UserVO vo);
	
	void updateUser(UserVO vo);
	
	void deleteUser(UserVO vo);
	
	UserVO getUser(UserVO vo);
	
	//회원정보수정 받아오는
	UserVO getUserinfo(UserVO vo);
	
	//닉네임 중복체크
	int nickChk(UserVO vo);
	//이메일 존재여부
	int findemail(UserVO vo);
	
	//이메일 인증
	String mailCheck(String email);
	
	//비번 이메일 발송
	void updatePw(UserVO vo);
	//비번변경
	//void findpw(UserVO vo);
	
	//자동차 정보 가입
	void insertCarInfo(UserVO vo);
	
	UserVO getUsercarInfo(UserVO vo);
	
	//회원정보 수성 및 삭제위한 비번체크
	int checkPw(UserVO vo);
	
	//카카오 로그인
	UserVO kakaogetUser(UserVO vo);
}
