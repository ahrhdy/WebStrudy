package com.framework.spring.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.framework.spring.sample.service.CdeService;

@Controller
public class CdeController {
	
	@Autowired
	public CdeService cdeService;
	
	/**
	 * 
	 * @Method Name	: selCodeExist
	 * @author	: mong e
	 * @date	: 2016. 7. 2.
	 * 처리내용	: 코드섹션 체크
	 */
	@RequestMapping("/cde/selCodeExist.ajax")
	public ModelAndView selCodeExist(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");

		ModelAndView mav = new ModelAndView();
		int resultCount = cdeService.selCodeExist(map);

		mav.addObject("data", resultCount);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: selCodeList
	 * @author	: mong e
	 * @date	: 2016. 7. 2.
	 * 처리내용	: 코드목록 조회
	 */
	@RequestMapping("/cde/selCodeList.ajax")
	public ModelAndView selCodeList(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");

		ModelAndView mav = new ModelAndView();
		List list = cdeService.selCodeList(map);

		mav.addObject("data", list);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: insCode
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드 등록
	 */
	@RequestMapping("/cde/insCode.ajax")
	public ModelAndView insCode(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		Object ojb = cdeService.insCode(map);

		mav.addObject("data", ojb);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: updCode
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드 수정
	 */
	@RequestMapping("/cde/updCode.ajax")
	public ModelAndView updCode(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = cdeService.updCode(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: delCode
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드 삭제
	 */
	@RequestMapping("/cde/delCode.ajax")
	public ModelAndView delCode(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = cdeService.delCode(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: selCodeDetailExist
	 * @author	: mong e
	 * @date	: 2016. 7. 2.
	 * 처리내용	: 코드상세 체크
	 */
	@RequestMapping("/cde/selCodeDetailExist.ajax")
	public ModelAndView selCodeDetailExist(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");

		ModelAndView mav = new ModelAndView();
		int resultCount = cdeService.selCodeDetailExist(map);

		mav.addObject("data", resultCount);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: selCodeDetailList
	 * @author	: mong e
	 * @date	: 2016. 7. 2.
	 * 처리내용	: 코드상세목록 조회
	 */
	@RequestMapping("/cde/selCodeDetailList.ajax")
	public ModelAndView selCodeDetailList(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");

		ModelAndView mav = new ModelAndView();
		List list = cdeService.selCodeDetailList(map);

		mav.addObject("data", list);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: insCodeDetail
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드상세 등록
	 */
	@RequestMapping("/cde/insCodeDetail.ajax")
	public ModelAndView insCodeDetail(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		Object ojb = cdeService.insCodeDetail(map);

		mav.addObject("data", ojb);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: updCodeDetail
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드상세 수정
	 */
	@RequestMapping("/cde/updCodeDetail.ajax")
	public ModelAndView updCodeDetail(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = cdeService.updCodeDetail(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: delCodeDetail
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드상세 삭제
	 */
	@RequestMapping("/cde/delCode.ajax")
	public ModelAndView delCodeDetail(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = cdeService.delCodeDetail(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}	
	
}
