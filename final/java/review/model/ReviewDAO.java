package com.hobbycam.review.model;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface ReviewDAO {

	public ArrayList<ReviewVO> review(int cp, int listSize, int u_idx);
	
	public ArrayList<ReviewVO> unReview(int cp, int listSize, int u_idx);
	
	public int insertReview(ReviewDTO dto);
	
	public int updateReview(ReviewDTO dto);
	
	public int deleteReview(int idx);
	
	public int myReviewCnt(int idx);
	
	public int myUnReviewCnt(int idx);

}
