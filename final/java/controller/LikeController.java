package com.hobbycam.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hobbycam.like.model.LikeDAO;
import com.hobbycam.like.model.LikeDTO;
import com.hobbycam.like.model.LikeVO;

@Controller
public class LikeController {

	@Autowired
	LikeDAO likeDao;
	
	@RequestMapping("/myLikeList.do")
	public ModelAndView myLike(HttpServletRequest req,
			@RequestParam(value="cp", defaultValue = "1")int cp) {

		ModelAndView mav=new ModelAndView();
		
		HttpSession session=req.getSession();
		if(session.getAttribute("u_idx")==null) {
			mav.addObject("msg","로그인을 진행해 주세요");
			mav.addObject("gopage","index.do");
			mav.setViewName("users/usersMsg");
			return mav;
		}

		int u_idx=(int)session.getAttribute("u_idx");
		int totalCnt=likeDao.myLikeCnt(u_idx);
		int listSize=6;
		int pageSize=5;
		String pageStr=com.hobbycam.page.BootstrapPageModule.pageMake("myLikeList.do",totalCnt,listSize,pageSize,cp);
		
		ArrayList<LikeVO> likeVo=likeDao.myLike(cp, listSize, u_idx);
		
	
		mav.addObject("likeVo",likeVo);
		mav.setViewName("users/myLike");
		mav.addObject("pageStr",pageStr);
		return mav;
	}
	
	
	
	
	@RequestMapping("/myLike.do")
	public ModelAndView getMyLike(HttpServletRequest req, int lesson_idx) {
		ModelAndView mav=new ModelAndView();
		HttpSession session=req.getSession();
		int idx=(int)session.getAttribute("u_idx");


		likeDao.getMyLike(idx,lesson_idx);
		
		mav.setViewName("redirect:/myLikeList.do");
		return mav;
	}
	
}
