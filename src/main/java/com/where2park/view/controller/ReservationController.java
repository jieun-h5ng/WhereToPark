package com.where2park.view.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.where2park.biz.parking.ParkingService;
import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.reservation.RsvService;
import com.where2park.biz.reservation.RsvVO;
import com.where2park.biz.reservation.impl.RsvDAOMybatis;

@Controller
class ReservationController {
//	@Resource(name = "rsvDAO")
//	private RsvDAOMybatis RsvDAO;

	@Autowired
	private RsvService rsvService;

	@Autowired
	HttpSession session;

	public ReservationController() {
		System.out.println("주차 컨트롤러 객체 생성");
	}

	@RequestMapping("/getRsv.do")
	public String getRsv(RsvVO vo, Model model) {
		System.out.println("getRsv객체 생성");
		model.addAttribute("rsv", rsvService.getRsv(vo));
		return "rsv/getRsv.jsp";

	}

	@RequestMapping("/getRsvList.do")
	public String getRsvList(RsvVO vo, Model model) {
		int id = (int) session.getAttribute("userId");
		vo.setParker_id(id);
		vo.setOwner_id(id);

		model.addAttribute("RsvList", rsvService.getRsvList(vo));
		System.out.println(vo);

		// 채팅 안읽은 갯수 표시 - 은지
		List<RsvVO> RsvList = rsvService.getRsvList(vo);
		List<Integer> noReadMessage = new ArrayList<>();
		for (int i = 0; i < RsvList.size(); i++) {
			RsvList.get(i).getUserVO().setUser_id(id);
			int noCnt = rsvService.selectNotReadMessage(RsvList.get(i));
			noReadMessage.add(noCnt);
			System.out.println("안읽은 메세지 갯수 : " + noCnt);
		}
		model.addAttribute("noRead", noReadMessage);

		return "rsv/getRsvList.jsp";
	}
	//나예
	@RequestMapping("/getRsvList_subscribe.do")
	public String getRsvList_subscribe(RsvVO vo, Model model) {
		System.out.println("넘어온 vo"+vo);
		
		//로그인 한 id
		int id = (int) session.getAttribute("userId");	
//		System.out.println(id);		
//		vo.setParker_id(id);
//		vo.setOwner_id(id);
		
		model.addAttribute("RsvList", rsvService.getRsvList_subscribe(vo));
		System.out.println(vo + "??");

		// 채팅 안읽은 갯수 표시 - 은지
		List<RsvVO> RsvList = rsvService.getRsvList_subscribe(vo);
		List<Integer> noReadMessage = new ArrayList<>();
		for (int i = 0; i < RsvList.size(); i++) {
			RsvList.get(i).getUserVO().setUser_id(id);
			int noCnt = rsvService.selectNotReadMessage(RsvList.get(i));
			noReadMessage.add(noCnt);
			System.out.println("안읽은 메세지 갯수 : " + noCnt);
		}
		model.addAttribute("noRead", noReadMessage);

		return "rsv/getRsvList_subscribe.jsp";
	}

	@RequestMapping("/kakaopay.do")
	public String payment(RsvVO vo, Model model) {
		System.out.println("결제 API 시작");
//		System.out.println(vo.getParkingVO().getOwner_id() + "오너아이디 ㅠ ㅠ");
		//단기주차장 예약할 떄 parkingVO가 null이라서 오류발생..
		System.out.println(vo);
		model.addAttribute("rsvInfo", vo);
		return "rsv/kakaopay.jsp";
	}
	
	@RequestMapping("/insertRsv.do")
	public String insertRsv(RsvVO vo) throws ParseException {
		System.out.println("insertRsv객체 생성");
		System.out.println(vo);
		rsvService.insertRsv(vo);

		return "getRsvList.do";
		//DB 제약조건 때문에 같은 owner의 예약건 두개이상 삽입 불가. 해결완료
	}

	@RequestMapping("/updateRsv.do")
	public String updateRsv(RsvVO vo) {
//		vo.getUserVO().setCar_num(car_num);
//		vo.getUserVO().setCar_type(car_type);
//		vo.getUserVO().setUser_id(vo.getParker_id());
//		
		rsvService.updateRsv(vo);
		return "getRsvList.do";
	}

	@RequestMapping("/deleteRsv.do")
	public String deleteRsv(RsvVO vo) {
		rsvService.deleteRsv(vo);
		return "getRsvList.do";
	}

}