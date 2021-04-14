package com.where2park.biz.parking;

import java.util.List;

public interface ParkingService {
	
	//주차장빌려주기글 조회
	//ParkingVO getParking();
	
	ParkingVO getParking(ParkingVO vo);
	// 리스트로 뽑기
	List<ParkingVO> getParkingList(ParkingVO vo);
	
	void insertParking(ParkingVO vo);
	
	void updateParking(ParkingVO vo);
	
	void updateParking_deleted(ParkingVO vo);
	void updateParking_down(ParkingVO vo);
	void updateParking_ori(ParkingVO vo);
	
	int deleteParking(ParkingVO vo);
	
	//메인에서 장기 주차글 조회페이지로 넘어가는 서비스 - 은지 
	List<ParkingVO> mainGetParkingList(ParkingVO vo);
	//메인페이지 위치기반 주차장 추천
	List<ParkingVO> getRecommendation(ParkingVO vo);
	
	//업로드
	//void uploadFile(ParkingVO vo) throws Exception;
}
