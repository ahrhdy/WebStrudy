package com.framework.spring.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.framework.spring.common.support.CommonConfig;
import com.framework.spring.sample.service.EmpService;

@Controller
public class EmpController {
	
	@Autowired
	public EmpService empService;
	
	/**
	 * 
	 * @Method Name	: selEmpPaging
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 사용자 목록(페이징) 조회
	 */
	@RequestMapping("/emp/selEmpPaging.ajax")
	public ModelAndView selEmpPaging(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		map.put(CommonConfig.COMMON_SKIP_RESULT, map.get("CurPage"));
		map.put(CommonConfig.COMMON_MAX_RESULT, map.get("RowCount"));
		
		ModelAndView mav = new ModelAndView();
		List list = empService.selEmpPaging(map);

		mav.addObject("data", list.get(0));
		mav.addObject("count", list.get(1));
		mav.setViewName("jsonView");
		return mav;
	}
	
	@RequestMapping("/emp/selEmpExist.ajax")
	public ModelAndView selEmpExist(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");

		ModelAndView mav = new ModelAndView();
		int resultCount = empService.selEmpExist(map);

		mav.addObject("data", resultCount);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: insEmp
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 사용자 등록
	 */
	@RequestMapping("/emp/insEmp.ajax")
	public ModelAndView insEmp(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		Object ojb = empService.insEmp(map);

		mav.addObject("data", ojb);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: updEmp
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 사용자 수정
	 */
	@RequestMapping("/emp/updEmp.ajax")
	public ModelAndView updEmp(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = empService.updEmp(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: delEmp
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 사용자 삭제
	 */
	@RequestMapping("/emp/delEmp.ajax")
	public ModelAndView delEmp(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = empService.delEmp(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: insEmpMulti
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 사용자다건등록
	 */
	@RequestMapping("/emp/insEmpMulti.ajax")
	public ModelAndView insEmpMulti(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();	
		int result = empService.insEmpMulti(map);

		mav.addObject("data", result);
		mav.setViewName("jsonView");
		return mav;
	}	
	
}
