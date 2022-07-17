package com.hobbycam.review.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class ReviewDAOImple implements ReviewDAO {

	@Autowired
	SqlSessionTemplate sqlMap;

	public ReviewDAOImple(SqlSessionTemplate sqlMap) {
		super();
		this.sqlMap = sqlMap;
	}

	@Override
	public ArrayList<ReviewVO> review(int cp, int listSize, int u_idx) {
	
		int start=((cp-1)*listSize)+1;
		int end=cp*listSize;
				
		Map map=new HashedMap();
			map.put("u_idx", u_idx);
			map.put("start", start);
			map.put("end", end);

		ArrayList<ReviewVO> arr=(ArrayList)sqlMap.selectList("myreview",map);
		
		return arr;
	}
	
	
	@Override
	public ArrayList<ReviewVO> unReview(int cp, int listSize, int u_idx) {
		
		int start=((cp-1)*listSize)+1;
		int end=cp*listSize;
				
		Map map=new HashedMap();
			map.put("u_idx", u_idx);
			map.put("start", start);
			map.put("end", end);
		
		ArrayList<ReviewVO> arr=(ArrayList)sqlMap.selectList("myunreview",map);
	
		return arr;
	}
	
	
	
	@Override
	public int myReviewCnt(int idx) {
		int count=sqlMap.selectOne("selectMyreviewCnt",idx);
		return count;
	}
	
	@Override
	public int myUnReviewCnt(int idx) {
		int count=sqlMap.selectOne("selectMyunreviewCnt",idx);
		return count;
	}
	
	
	
	
	
	
	
	@Override
	public int insertReview(ReviewDTO dto) {
		int count=sqlMap.insert("insertReview",dto);
		return count;
	}
	
	@Override
	public int updateReview(ReviewDTO dto) {
		int count=sqlMap.update("updateReview",dto);
		return count;
	}
	
	@Override
	public int deleteReview(int idx) {
		
		int count=sqlMap.delete("deleteReview",idx);
		return count;
	}
}
