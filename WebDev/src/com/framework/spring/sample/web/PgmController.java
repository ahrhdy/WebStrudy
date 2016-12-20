package com.framework.spring.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.framework.spring.sample.service.PgmService;

@Controller
public class PgmController {
	
	@Autowired
	public PgmService pgmService;
	
	/**
	 * 
	 * @Method Name	: selPgmList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 프로그램목록 조회
	 */
	@RequestMapping("/pgm/selPgmList.ajax")
	public ModelAndView selPgmList(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		List list = pgmService.selPgmList(map);

		mav.addObject("data", list);		
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: insPgm
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 프로그램 등록
	 */
	@RequestMapping("/pgm/insPgm.ajax")
	public ModelAndView insPgm(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		Object ojb = pgmService.insPgm(map);

		mav.addObject("data", ojb);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: updPgm
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 프로그램 수정
	 */
	@RequestMapping("/pgm/updPgm.ajax")
	public ModelAndView updPgm(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = pgmService.updPgm(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: delPgm
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 프로그램 삭제
	 */
	@RequestMapping("/pgm/delPgm.ajax")
	public ModelAndView delPgm(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = pgmService.delPgm(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}
	
}
