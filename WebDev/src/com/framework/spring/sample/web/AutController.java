package com.framework.spring.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.framework.spring.sample.service.AutService;

@Controller
public class AutController {

	@Autowired
	public AutService autService;
	
	/**
	 * 
	 * @Method Name	: selEmpList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 사용자 목록 조회
	 */
	@RequestMapping("/aut/selEmpList.ajax")
	public ModelAndView selEmpList(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");

		ModelAndView mav = new ModelAndView();
		List list = autService.selEmpList(map);

		mav.addObject("data", list);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: selAutList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 프로그램 권한 목록 조회
	 */
	@RequestMapping("/aut/selAutList.ajax")
	public ModelAndView selAutList(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");

		ModelAndView mav = new ModelAndView();
		List list = autService.selAutList(map);

		mav.addObject("data", list);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: insAut
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 사용자 프로그램권한 등록
	 */
	@RequestMapping("/aut/insAut.ajax")
	public ModelAndView insEmp(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		Object ojb = autService.insAut(map);

		mav.addObject("data", ojb);
		mav.setViewName("jsonView");
		return mav;
	}	
}
