package com.where2park.biz.parking.impl;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.where2park.biz.parking.ParkingService;
import com.where2park.biz.parking.ParkingVO;
import com.where2park.biz.reservation.RsvVO;
import com.where2park.biz.reservation.impl.RsvDAOMybatis;
import com.where2park.biz.review.ReviewVO;
import com.where2park.biz.review.impl.ReviewDAOMybatis;

@Service("parkingService")
public class ParkingServiceImpl implements ParkingService {
	@Autowired
	private ParkingDAOMybatis parkingDAO;
	private ReviewDAOMybatis reviewDAO;

	@Autowired
	HttpSession session;

	@Override
	public ParkingVO getParking(ParkingVO vo) {
		return parkingDAO.getParking(vo);
	}

	@Override
	public List<ParkingVO> getParkingList(ParkingVO vo) {
		return parkingDAO.getParkingList(vo);
	}

	@Override
	public void insertParking(ParkingVO vo) {
		parkingDAO.insertParking(vo);

	}

	@Override
	public void updateParking(ParkingVO vo) {
		parkingDAO.updateParking(vo);

	}
	//예약 있는지 없는지 확인
	@Override
	public int deleteParking(ParkingVO vo) {
		int result = parkingDAO.deleteParking(vo);
		return result;

	}

//	@Override
//	public void uploadFile(ParkingVO vo) throws Exception {
//
//		// 파일 업로드처리
//		MultipartFile uploadFile = vo.getUploadFile();
//		if (!uploadFile.isEmpty()) {
//			String fileName = uploadFile.getOriginalFilename();
//			
//			String parking_pic = System.currentTimeMillis()+ fileName.substring(fileName.lastIndexOf("."));
//			
//			// 상대경로 파일 저장
//			String rootPath = session.getServletContext().getRealPath("/");
//			String attachPath = "WEB-INF/images/";
//			uploadFile.transferTo(new File(rootPath + attachPath + parking_pic));
//			vo.setParking_pic(parking_pic);
////			session.setAttribute("parking_pic", parking_pic);
//		}
//
//	}

	@Override
	public void updateParking_deleted(ParkingVO vo) {
		parkingDAO.updateParking_deleted(vo);

	}

	@Override
	public void updateParking_down(ParkingVO vo) {
		parkingDAO.updateParking_down(vo);
	}

	@Override
	public void updateParking_ori(ParkingVO vo) {
		parkingDAO.updateParking_ori(vo);
	}

	public List<ParkingVO> getLongParkingList(ParkingVO vo) {
		return parkingDAO.getLongParkingList(vo);
	}

	public List<ParkingVO> getAllParkingList(ParkingVO vo) {
		// TODO Auto-generated method stub
		return parkingDAO.getAllParkingList(vo);
	}

	public List<RsvVO> getDateList(ParkingVO vo) {
		return parkingDAO.getDateList(vo);
	}

	//메인페이지에서 장기 주차글로 넘어가는 서비스 - 은지 
	@Override
	public List<ParkingVO> mainGetParkingList(ParkingVO vo) {
		System.out.println("ParkingServiceImpl() mainGetParkingList 기능처리 : 메인페이지 ");
		return parkingDAO.mainGetParkingList(vo);
	}
	//메인페이지 위치기반 주차장 추천 - 은지 
	@Override
	public List<ParkingVO> getRecommendation(ParkingVO vo) {
		System.out.println("ParkingServiceImpl() getRecommendation 기능처리 : 메인페이지 ");
		return parkingDAO.getRecommendation(vo);
	}

	public List<ReviewVO> getReviewOnParking(ParkingVO vo) {
		return parkingDAO.getReviewOnParking(vo);
	}

	public List<Integer> countReview(ParkingVO vo) {
		return parkingDAO.countReview(vo);
		
	}

	public List<ParkingVO> getAllShortParkingList(ParkingVO vo) {
		// TODO Auto-generated method stub
		return parkingDAO.getAllShortParkingList(vo);
	}

	public List<ParkingVO> getShortParkingList(ParkingVO vo) {
		// TODO Auto-generated method stub
		return parkingDAO.getShortParkingList(vo);
	}

}
