package com.where2park.view.controller;


import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.where2park.biz.parking.ParkingService;
import com.where2park.biz.parking.ParkingVO;

@Controller
@SessionAttributes("parking")
public class ParkingController {

	@Autowired
	private ParkingService parkingService;

	@Autowired
	HttpSession session;

	@RequestMapping("/insertParking.do")
	public String insertParking(ParkingVO vo) {
		System.out.println("여기?!");
		
			// 파일 업로드처리
			MultipartFile uploadFile = vo.getUploadFile();
			if (!uploadFile.isEmpty()) {
				String fileName = uploadFile.getOriginalFilename();
				String parking_pic = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
				
				//상대경로 파일 저장 
				String rootPath = session.getServletContext().getRealPath("/");
				String attachPath = "/images/";
				try {
					//업로드
					uploadFile.transferTo(new File(rootPath + attachPath + parking_pic));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				vo.setParking_pic(parking_pic);
				System.out.println("파일업로드한게 저장되었습니다");
			} else {
				System.out.println("??");
			}
			parkingService.insertParking(vo);
			return "getParkingList.do";
			
	}

	@RequestMapping("/shortgetParking.do")
	public String shortgetParking(ParkingVO vo, Model model) {
		model.addAttribute("parking", parkingService.getParking(vo));
		return "parking/shortgetParking.jsp";
	}
	@RequestMapping("/longgetParking.do")
	public String longgetParking(ParkingVO vo, Model model) {
		model.addAttribute("parking", parkingService.getParking(vo));
		
		return "parking/longgetParking.jsp";
	}

	@RequestMapping("/getParkingList.do")
	public String getParkingList(ParkingVO vo, Model model) {
			int id = (int)session.getAttribute("userId");
			vo.setOwner_id(id);
			model.addAttribute("parkingList", parkingService.getParkingList(vo));
			System.out.println(vo + "가 무엇");
			return "parking/getParkingList.jsp";
		
	}

	@RequestMapping("/updateParking.do")
	public String updateParking(ParkingVO vo) throws Exception {
		// 파일 업로드처리
		MultipartFile uploadFile = vo.getUploadFile();
		String fileName = uploadFile.getOriginalFilename();
		String parking_pic = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
		//상대경로 파일 저장 
		String rootPath = session.getServletContext().getRealPath("/");
		String attachPath = "/images/";
		try {
			//업로드
			uploadFile.transferTo(new File(rootPath + attachPath + parking_pic));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		vo.setParking_pic(parking_pic);
		vo.setParking_deleted(0);
		parkingService.updateParking(vo);
		System.out.println("수정 vo" + vo);
		return "getParkingList.do";
	}

	@RequestMapping("/updateParking_deleted.do")
	public String updateParking_deleted(ParkingVO vo) {
		parkingService.updateParking_deleted(vo);
		return "getParkingList.do";
	}

	@RequestMapping("/updateParking_down.do")
	public String updqteParking_down(ParkingVO vo) {
		parkingService.updateParking_down(vo);
		return "getParkingList.do";
	}

	@RequestMapping("/updateParking_ori.do")
	public String updateParking_ori(ParkingVO vo) {
		parkingService.updateParking_ori(vo);
		return "getParkingList.do";
	}

	//예약있는지 체크
	@ResponseBody
	@RequestMapping(value = "/deleteParking.do", method = RequestMethod.POST)
	public int deleteParking(ParkingVO vo) {
		System.out.println("딜리트 파킹" + vo);
		int rsv_result = parkingService.deleteParking(vo);
		System.out.println("예약 있는지 체크" + rsv_result);
		return rsv_result;
	}

}
