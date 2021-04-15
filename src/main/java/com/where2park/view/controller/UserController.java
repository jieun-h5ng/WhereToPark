package com.where2park.view.controller;

import java.io.*;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.JsonNode;
import com.where2park.biz.user.UserService;
import com.where2park.biz.user.UserVO;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	HttpSession session;

	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value ="/login.do" , method = RequestMethod.POST )
	public String login(UserVO vo, HttpSession session) {
		int email_result = userService.findemail(vo);
		System.out.println("이메일 찾은 결과" + email_result);
		if(email_result == 0) {
			System.out.println("가입된 이메일 없습니다");
			return "user/error_join.jsp";
		}else {
			System.out.println("가입된 이메일 있고, 로그인 진행중");
			UserVO user = userService.getUser(vo);
			System.out.println("너 user?" + user);
			if (user != null) {
				//크롤링
				/*
				String line = "";
				try{
		            //파일 객체 생성
		            File file = new File("D:\\pythonChatbot\\lecture\\날씨.txt");
		            //입력 스트림 생성
		            FileReader filereader = new FileReader(file);
		            //입력 버퍼 생성
		            BufferedReader bufReader = new BufferedReader(filereader);
		            while((line = bufReader.readLine()) != null){
		                System.out.println(line);
		                String[] arr = line.split(",");
		                for (int i = 0; i < arr.length; i++) {
							//System.out.println(arr[i]);
						}
		                String address = arr[0].trim();
		                String temp = arr[1].trim();
		                String text = arr[2].trim();
		                System.out.println(temp);
		                System.out.println(text);
		                session.setAttribute("address", address);
		                session.setAttribute("temp", temp);
		                session.setAttribute("text", text);
		            }
		            //.readLine()은 끝에 개행문자를 읽지 않는다.            
		            bufReader.close();
		        }catch (FileNotFoundException e) {
		        }catch(IOException e){
		            System.out.println(e);
		        }
				//크롤링 끝
				*/
				session.setAttribute("userId", user.getUser_id());
				session.setAttribute("userNickName", user.getUser_nickname());
				return "index.jsp";
			} else {
				return "user/error_pw.jsp";
			}
		}
//		String result = Integer.toString(email_result);
//		System.out.println("리턴값이 뭐니?" + result);
//		return "user/userLogin.jsp";
	}

	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		System.out.println("로그아웃");
		session.invalidate();
		return "index.jsp";
	}

	// 회원가입 폼
	@RequestMapping("/insertUser.do")
	public String insertUser(UserVO vo, Model model){
		System.out.println("이번에도 여기?");
		// 파일 업로드처리
		MultipartFile uploadFile_F = vo.getUploadFile_F();
		if (!uploadFile_F.isEmpty()) {
			String fileName = uploadFile_F.getOriginalFilename();
			String user_pic = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
			//상대경로
			String rootPath = session.getServletContext().getRealPath("/");
			String attachPath =  "/images/profile/";
			try {
				uploadFile_F.transferTo(new File(rootPath + attachPath + user_pic));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			/*
			// 절대경로 파일 저장
			String attachPath = "D:/finalproject/Where2Park/src/main/webapp/images/profil/";
			try {
				uploadFile_F.transferTo(new File(attachPath + user_pic));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			*/
			vo.setUser_pic(user_pic);
			System.out.println("프로필사진 업로드");
		}
		System.out.println("인서트회원가입");
		
		int result = userService.nickChk(vo);
		if (result == 1) { // 닉네임 중복이면
			return "user/userJoinForm.jsp";
			
		} else if (result == 0) { // 중복아니면 회원가입
			userService.insertUser(vo);
			model.addAttribute("user", userService.getUsercarInfo(vo));
			System.out.println("모델 값은 무엇?" + model);
		}
		return "user/carInfo.jsp";
	}

	// 닉네임 중복체크
	@ResponseBody
	@RequestMapping(value = "/nickChk.do", method = RequestMethod.POST)
	public int nickChk(UserVO vo) {
		System.out.println(vo);
		int result = userService.nickChk(vo);
		return result;
	}
	// 비밀번호 맞는지 체크
	@ResponseBody
	@RequestMapping(value = "/checkPw.do", method = RequestMethod.POST)
	public int checkPw(UserVO vo) {
		System.out.println("??" + vo);
		int pw_result = userService.checkPw(vo);
		System.out.println(pw_result);
		return pw_result;
	}
	
	// 이메일 인증
	@ResponseBody
	@RequestMapping(value = "/mailCheck.do", method = RequestMethod.GET)
	public String mailCheck(String email) {
		// 데이터확인
		System.out.println("이메일 인증 데이터 전송확인");
		System.out.println("받는사람주소" + email);

		// 인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);

		// 이메일 보내기
		String setFrom = "naye0417@gmail.com";
		String toMail = email;
		String title = "어따세워 회원가입 인증 이메일 입니다.";
		String content = "어따세워 홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + "<b>" + checkNum + "</b>" + "입니다."
				+ "<br>" + "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

		// 이메일 전송 코드
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
			System.out.println("메일전송완료");

		} catch (Exception e) {
			e.printStackTrace();
		}

		String num = Integer.toString(checkNum);
		return num;
	}
	
	// 비번찾기 메일발송
	@ResponseBody
	@RequestMapping(value="/findPw.do", method = RequestMethod.POST)
	public int updatePw(String user_email, UserVO vo) {
		System.out.println(user_email);
		int email_result = userService.findemail(vo);
		
		System.out.println(email_result);
		if(email_result == 0) {
			System.out.println("가입된 이메일 없습니다");
			System.out.println(email_result);
		}
		else {
		System.out.println("가입된 이메일 있습니다");
		System.out.println(email_result);
		System.out.println("비번찾기 이메일 전송확인");
		System.out.println("받는사람주소 : " + user_email);
		String pw = "";
		for (int i = 0; i < 12; i++) {
			pw += (char) ((Math.random() * 26) + 97);
		}
		vo.setUser_email(user_email);
		vo.setUser_password(pw);
		// 비밀번호 변경
		userService.updatePw(vo);
		System.out.println("VO는 무엇?"+vo);
		System.out.println("pw는 무엇?"+pw);
		System.out.println("email는 무엇?"+user_email);

		System.out.println("이메일로 임시 비번 발송");

			// 이메일 보내기
			String setFrom = "naye0417@gmail.com";
			String toMail = user_email;
			String title = "어따세워 비밀번호 찾기 이메일 입니다.";
			String content = "어따세워 홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + 
					"임시비밀번호는 " + "<b>" + vo.getUser_password()
					+ "</b>" + "입니다." + "임시번호를 변경하여 사용하세요.";

			// 이메일 전송 코드
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				helper.setText(content, true);
				mailSender.send(message);
				System.out.println("비번바꾸기 메일전송완료");

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("비번바꾸기 이메일 전송실패");
			}
		}
		return email_result;
		}
	
	
	// 카정보 가입
	@RequestMapping("/insertCatInfo.do")
	public String insertCarInfo(UserVO vo) {
		System.out.println("자동차정보 인서트중");
		userService.insertCarInfo(vo);
		return "index.jsp";
		
	}
	
	
	//회원가입 정보찾아오는
	@RequestMapping("/getUserinfo.do")
	public String getupdateUser(UserVO vo, Model model) {
		int id = (int)session.getAttribute("userId");
		vo.setUser_id(id);
		model.addAttribute("user", userService.getUserinfo(vo));
		System.out.println("정보," + vo );
		return "user/getUserinfo.jsp";
	}
	
	//회원가입 수정
	@RequestMapping("/updateUser.do")
	public String updateUser(UserVO vo, Model model) {
		// 파일 업로드처리
		MultipartFile uploadFile_F = vo.getUploadFile_F();
		if (!uploadFile_F.isEmpty()) {
			String fileName = uploadFile_F.getOriginalFilename();
			String user_pic = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
			//상대경로
			String rootPath = session.getServletContext().getRealPath("/");
			String attachPath =  "/images/profile/";
			try {
				uploadFile_F.transferTo(new File(rootPath + attachPath + user_pic));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 절대경로 파일 저장
			/*
			String attachPath = "D:/finalproject/Where2Park/src/main/webapp/images/profil/";
			try {
				uploadFile_F.transferTo(new File(attachPath + user_pic));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			*/
			
			vo.setUser_pic(user_pic);
		}
			System.out.println("프로필사진 수정업로드");
			userService.updateUser(vo);
			int id = (int)session.getAttribute("userId");
			vo.setUser_id(id);
			System.out.println("업데이트가 됐니?");
			return "getUserinfo.do";
	}
	
	//회원탈퇴
	@RequestMapping("/deleteUser.do")
	public String deleteUser(UserVO vo, HttpSession session) {
		userService.deleteUser(vo);
		System.out.println("탈퇴진행");
		session.invalidate();
		return "index.jsp";
	}
	
	//카톡 로그인
	@RequestMapping("kakaologin.do")
	public String kakaoLogin(UserVO vo, Model model) {
		System.out.println("카카오 정보가 넘어왔니?" + vo);
			System.out.println("모델은 모엇" + vo);
			if(vo.getUser_email() != null) {
				//따음표 제거
				String email = vo.getUser_email();
				email = email.replaceAll("\\\"","");
				//따음표 제거
				String nickname = vo.getUser_email();
				nickname = nickname.replaceAll("\\\"","");
				vo.setUser_email(nickname);
				//따음표 제거
				String url = vo.getUser_pic();
				url = url.replaceAll("\\\"","");
				vo.setUser_pic(url);
			}
			model.addAttribute("user", vo);
			int email_result = userService.findemail(vo);
			if(email_result == 0) {
				System.out.println("가입된 이메일 없습니다");
				return "user/kakaoJoinForm.jsp";
			}else {
				System.out.println("가입된 이메일 있고, 로그인 진행중");
				UserVO user = userService.kakaogetUser(vo);
				System.out.println(vo);
				if(user !=null) {
					//크롤링
					String line = "";
					try{
			            //파일 객체 생성
			            File file = new File("D:\\pythonChatbot\\lecture\\날씨.txt");
			            //입력 스트림 생성
			            FileReader filereader = new FileReader(file);
			            //입력 버퍼 생성
			            BufferedReader bufReader = new BufferedReader(filereader);
			            while((line = bufReader.readLine()) != null){
			                System.out.println(line);
			                String[] arr = line.split(",");
			                for (int i = 0; i < arr.length; i++) {
								//System.out.println(arr[i]);
							}
			                String address = arr[0].trim();
			                String temp = arr[1].trim();
			                String text = arr[2].trim();
			                System.out.println(temp);
			                System.out.println(text);
			                session.setAttribute("address", address);
			                session.setAttribute("temp", temp);
			                session.setAttribute("text", text);
			            }
			            //.readLine()은 끝에 개행문자를 읽지 않는다.            
			            bufReader.close();
			        }catch (FileNotFoundException e) {
			        }catch(IOException e){
			            System.out.println(e);
			        }
					//크롤링 끝
					
					System.out.println("너 user?" + user);
					session.setAttribute("userId", user.getUser_id());
					session.setAttribute("userNickName", user.getUser_nickname());
				}
				return "index.jsp";
			}
	}
	// 카톡 회원가입 폼
	@RequestMapping("/insertkakaoUser.do")
	public String insertkakaoUser(UserVO vo, Model model){
		System.out.println("카카오 여기?");
			userService.insertUser(vo);
			model.addAttribute("user", userService.getUsercarInfo(vo));
			System.out.println("모델 값은 무엇?" + model);
		return "user/carInfo.jsp";
	}
	
	
	/*	
	//카카오톡 로그인
	@ResponseBody
	@RequestMapping(value="/kakaoLogin.do")
	public String kakaoCallback(String code) {	
		System.out.println("카카오로인인");
		//post 방식으로 key-value 데이터를 요청
		RestTemplate rt = new RestTemplate();
		
		//HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8"); // 키 밸류 형태라고 알려줌.
		
		// HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "07b3be0e595ef9b7d3342fa05ef8fb30");
		params.add("redirect_uri", "http://localhost:9999/Where2Park/kakao/callback");
		params.add("code", code);
		
		//HttpHeader와 HttpBody 를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String,String>> kakaoTokenRequest =
				new HttpEntity<>(params,headers);
		
		// Http 요청하기 - Post 방식으로 - response 변수의 응답 받음.
		ResponseEntity<String> response =rt.exchange(
			"https://kauth.kakao.com/oauth/token",
			HttpMethod.POST,
			kakaoTokenRequest,
			String.class
		);	
		System.out.println("카카오 인증 완료"  + response );
		return "카카오 인증 완료 :" + response;
	}
	*/
	
}
