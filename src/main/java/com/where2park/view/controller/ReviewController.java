package com.where2park.view.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.where2park.biz.review.ReviewService;
import com.where2park.biz.review.ReviewVO;
import com.where2park.biz.review.impl.ReviewDAOMybatis;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	@Autowired
	HttpSession session;
	
	@Resource(name="reviewDAO")
	private ReviewDAOMybatis reviewDAO;
	
	public ReviewController() {
		System.out.println("⇒Review Controller");
	}
	
	@RequestMapping("/review_list.do")
	public String getReviewList(ReviewVO vo, Model model) {
		System.out.println(reviewService.getReviewList(vo)+"리뷰 목록에 리뷰 작성 내역 출력 리뷰 목록에 리뷰 작성 내역 출력");
		vo.setUser_id((int)session.getAttribute("userId"));
		model.addAttribute("reviewList", reviewService.getReviewList(vo));
		return "review/review_list.jsp";
	}
	
	@RequestMapping("/review_wrt.do")
	public String getReview(ReviewVO vo, Model model) {
		// 리뷰 쓰기 화면에 예약정보 출력
		System.out.println(reviewService.getReview(vo)+"리뷰 쓰기에 예약정보 출력 리뷰 쓰기에 예약정보 출력");
		model.addAttribute("review", reviewService.getReview(vo));
		session.setAttribute("rsvId", vo.getRsv_id());
		return "review/review_wrt.jsp";
	}
	
	@RequestMapping("/insert_review.do")
	public String insertReview(ReviewVO vo) {
		// 새 리뷰 입력
		System.out.println(vo.getReview_content()+"새 리뷰 입력 새 리뷰 입력 새 리뷰 입력");
		vo.setUser_id((int)session.getAttribute("userId"));
		reviewService.insertReview(vo);
		return "/review_list.do";
	}
	
	@RequestMapping("/delete_review.do")
	public String deleteReview(ReviewVO vo, Model model) {
//		System.out.println(reviewDAO.deleteReview(vo)+"리뷰 삭제 리뷰 삭제 리뷰 삭제");
		System.out.println("리뷰 삭제 리뷰 삭제 리뷰 삭제");
//		vo.setUser_id((int)session.getAttribute("userId"));
//		model.addAttribute("review", reviewService.deleteReview(vo));
		reviewService.deleteReview(vo);
		return "/review_list.do";
	}
	
	@RequestMapping("/update_review_view.do")
	public String updateReviewView(ReviewVO vo, Model model) {
		// 리뷰 수정 화면에 리뷰상세 출력
		System.out.println(reviewService.updateReviewView(vo)+"리뷰 수정 화면 출력 리뷰 수정 화면 출력");
		//reviewService.updateReview(vo);
		model.addAttribute("review", reviewService.updateReviewView(vo));
		return "review/review_mdf.jsp";
	}
	
	@RequestMapping("/update_review.do")
	public String updateReview(ReviewVO vo) {
//		System.out.println(reviewDAO.updateReview(vo)+"리뷰 수정 리뷰 수정 리뷰 수정");
		System.out.println("리뷰 수정 리뷰 수정 리뷰 수정");
		reviewService.updateReview(vo);
		// 수정 내용이 쿼리스트링으로 가고있다...
		return "/review_list.do";
	}
	



}
