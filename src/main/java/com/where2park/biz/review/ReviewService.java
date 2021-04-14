package com.where2park.biz.review;

import java.util.List;

public interface ReviewService {
	List<ReviewVO> getReviewList(ReviewVO vo);
	ReviewVO getReview(ReviewVO vo);
	void insertReview(ReviewVO vo);
	ReviewVO updateReviewView(ReviewVO vo);
	void updateReview(ReviewVO vo);
	void deleteReview(ReviewVO vo);
}
