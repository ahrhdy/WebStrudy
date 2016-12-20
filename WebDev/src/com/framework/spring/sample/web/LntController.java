package com.framework.spring.sample.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.framework.spring.sample.service.LntService;

@Controller
public class LntController {

	@Autowired
	public LntService lntService;

	/**
	 * 
	 * @Method Name	: insLnt
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 레이어팝업 등록
	 */
	@RequestMapping("/lnt/insLnt.ajax")
	public ModelAndView insLnt(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = lntService.insLnt(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}	
}
