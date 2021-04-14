package com.where2park.view.controller;

import java.io.BufferedReader;

import java.io.IOException;
import java.sql.Timestamp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.io.ResolverUtil.Test;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.parking.impl.ParkingDAOMybatis;
import com.where2park.biz.parking.impl.ParkingServiceImpl;
import com.where2park.biz.reservation.RsvVO;
import com.where2park.biz.reservation.impl.RsvServiceImpl;
import com.where2park.biz.review.impl.ReviewServiceImpl;

@Controller
public class MainSearchController {
	@Autowired
	private ParkingServiceImpl parkingService;
	private RsvServiceImpl rsvService;
	private ReviewServiceImpl reviewService;

	@Autowired
	HttpSession session;
	
	public MainSearchController() {
		System.out.println("====> MainSearchController 객체 생성");
	}

	//은지 메인페이지 주차장 검색 
	@RequestMapping("/getSearchParkingList.do")
	public String getSearchParkingList(ParkingVO vo, Model model) {
		//일단 장기주차 (단기주차와 구분하기 위해선 날짜끼리 비교한다던지 하면될듯0
		System.out.println("주차장 위치 : " + vo.getParking_location() );
		System.out.println("주차 시작 시간 : " + vo.getParking_intime());
		System.out.println("주차 종료 시간 : " + vo.getParking_outtime());
		
		//주차시간 문자열 변환
		String intime = vo.getParking_intime();
		intime = intime.replace("T", " ");
		String outtime = vo.getParking_outtime();
		outtime = outtime.replace("T", " ");
		
		System.out.println("변환된 주차 시작 시간 : " + intime);
		System.out.println("변환된 주차 종료 시간 : " + outtime);
		
		//변환된값 재주입 
		vo.setParking_intime(intime);
		vo.setParking_outtime(outtime);
		
		model.addAttribute("LP_List", parkingService.mainGetParkingList(vo));
		System.out.println(parkingService.mainGetParkingList(vo));
		return "search/longParking.jsp";
	}
	
	@RequestMapping("/mainRecommendation.do")
	@ResponseBody
	public List<ParkingVO> getRecommendation(ParkingVO vo) throws Exception {
		System.out.println("되는거냐?");
		System.out.println(vo.getParking_lat());
		System.out.println(vo.getParking_lng());
		
		List<ParkingVO> recommendation = parkingService.getRecommendation(vo);
		return recommendation;
	}

//지은 장기주차 검색 페이지
	
	@RequestMapping(value ="/searchParkingList.do", method=RequestMethod.GET) // 겟요청
	public String searchParkingList(ParkingVO vo, Model model) {
		model.addAttribute("LP_List", parkingService.getAllParkingList(vo));
		return "search/longParking.jsp"; // 다시새로나오는 중.. ajax필요
	}

	@RequestMapping(value ="/searchParkingList.do", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> searchParkingList(@RequestParam(value = "area", defaultValue = " ", required = false) String area,
			@RequestParam(value = "sdate",defaultValue = "2021-04-09", required = false) String sdate,
			@RequestParam(value = "edate",defaultValue = "2021-04-12", required = false) String edate,
			@RequestParam(value = "keyword", defaultValue = "", required = false) String keyword,
			@RequestParam(value = "price", defaultValue = "25000", required = false) int price, ParkingVO vo, Model model) {
		System.out.println("지역: " + area);
		System.out.println("키워드: " + keyword); 
		System.out.println("시작날짜: " + sdate);
		System.out.println("종료날짜: " + edate);
		System.out.println("가격: " + price);
		vo.setParking_title(keyword);
		vo.setParking_content(keyword);
		vo.setParking_price(price);
		vo.setParking_intime(sdate);
		vo.setParking_outtime(edate);
		vo.setParking_location(area);
		
		HashMap<String, Object> parkingList = new HashMap<String, Object>();
		parkingList.put("title",parkingService.getLongParkingList(vo));
//		model.addAttribute("LP_List", parkingService.getLongParkingList(vo));
		return parkingList;
	}

//지은 주차장 상세 페이지
	@RequestMapping(value="/searchParkingDetail.do", method=RequestMethod.GET)
	public String searchParkingDetail(ParkingVO vo, Model model) {
		ParkingVO parking = parkingService.getParking(vo);
		model.addAttribute("p_detail", parking);
		model.addAttribute("booked", parkingService.getDateList(vo));
		//model.addAttribute("p_reviews", parkingService.getReviewOnParking(vo));
		model.addAttribute("totalReview",parkingService.countReview(vo));
		model.addAttribute("p_reviews", parkingService.getReviewOnParking(vo));
	
		
		//js에서 자꾸 parking_id 못읽어서 세션에 저장함... - 은지
		session.setAttribute("parkingId", vo.getParking_id());
		session.setAttribute("parkingInfo", parking);

		return "search/parkingDetail.jsp";
	}
	
	
	@RequestMapping(value="/searchParkingDetail.do", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> searchParkingDetail(ParkingVO vo, Model model, @RequestParam(value = "page", defaultValue = "0", required = false) int page) {

		vo.setPage((page-1)*3); //디버깅해보고 안되면 정석으로... 

		HashMap<String, Object> reviews = new HashMap<String, Object>();
		reviews.put("p_reviews", parkingService.getReviewOnParking(vo));
//		model.addAttribute("p_reviews", parkingService.getReviewOnParking(vo));
		return reviews;
	}
}
