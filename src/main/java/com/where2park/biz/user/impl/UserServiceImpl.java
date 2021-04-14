package com.where2park.biz.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.where2park.biz.user.UserService;
import com.where2park.biz.user.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDAOMybatis userDAO;
	
	@Override
	public void insertUser(UserVO vo) {
		userDAO.insertUser(vo);
	}

	@Override
	public void updateUser(UserVO vo) {
		userDAO.updateUser(vo);
	}

	@Override
	public void deleteUser(UserVO vo) {
		userDAO.deleteUser(vo);
	}

	@Override
	public UserVO getUser(UserVO vo) {
		return userDAO.getUser(vo);
	}
	
	//중복체크
	@Override
	public int nickChk(UserVO vo) {
		int result = userDAO.nickChk(vo);
		return result;
	}
	//이메일 인증
	@Override
	public String mailCheck(String email) {
		return email;
		
	}
	//이메일 발송
	@Override
	public void updatePw(UserVO vo) {
		userDAO.updatePw(vo);
		
	}
	// 이메일 존재여부검사
	@Override
	public int findemail(UserVO vo) {
		int email_result = userDAO.findemail(vo);
		return email_result;
	}
	
	//자동차 정보 입력
	@Override
	public void insertCarInfo(UserVO vo) {
		userDAO.insertCarInfo(vo);
	}

	@Override
	public UserVO getUsercarInfo(UserVO vo) {
		return userDAO.getUsercarInfo(vo);
	}

	@Override
	public UserVO getUserinfo(UserVO vo) {
		return userDAO.getUserinfo(vo);
	}
	
	//비번체크
	@Override
	public int checkPw(UserVO vo) {
		int pw_result = userDAO.checkPw(vo);
		return pw_result;
	}
//	public UserVO checkPw(UserVO vo) {
//		return userDAO.checkPw(vo);
//	}
	
	//카카오 로그인
	@Override
	public UserVO kakaogetUser(UserVO vo) {
		return userDAO.kakaogetUser(vo);
	}
	
	//비번변경
//	@Override
//	public void findpw(UserVO vo) {
//		userDAO.updatePw(vo);
//	}

	
	

}
