package com.framework.spring.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.framework.spring.sample.service.HlpService;

@Controller
public class HlpController {

	@Autowired
	public HlpService hlpService;
	
	/**
	 * 
	 * @Method Name	: selPgmList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 프로그램 목록 조회
	 */
	@RequestMapping("/hlp/selPgmList.ajax")
	public ModelAndView selPgmList(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");

		ModelAndView mav = new ModelAndView();
		List list = hlpService.selPgmList(map);

		mav.addObject("data", list);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: insHlp
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 도움말 등록
	 */
	@RequestMapping("/hlp/insHlp.ajax")
	public ModelAndView insHlp(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = hlpService.insHlp(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}	
}
