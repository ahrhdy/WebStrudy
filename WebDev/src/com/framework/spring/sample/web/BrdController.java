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
import com.framework.spring.sample.service.BrdService;

@Controller
public class BrdController {
	
	@Autowired
	public BrdService brdService;

	/**
	 * 
	 * @Method Name	: selBrdPaging
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 게시글 목록(페이징) 조회
	 */
	@RequestMapping("/brd/selBrdPaging.ajax")
	public ModelAndView selBrdPaging(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		map.put(CommonConfig.COMMON_SKIP_RESULT, map.get("CurPage"));
		map.put(CommonConfig.COMMON_MAX_RESULT, map.get("RowCount"));
		
		ModelAndView mav = new ModelAndView();
		List list = brdService.selBrdPaging(map);

		mav.addObject("data", list.get(0));
		mav.addObject("count", list.get(1));
		mav.setViewName("jsonView");
		return mav;
	}

	/**
	 * 
	 * @Method Name	: insBrd01
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시글 등록
	 */
	@RequestMapping("/brd/insBrd01.fileup")
	public ModelAndView insBrd01(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		Object ojb = brdService.insBrd01(map);

		mav.addObject("data", ojb);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: updBrd01
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시글 수정
	 */
	@RequestMapping("/brd/updBrd01.ajax")
	public ModelAndView updBrd01(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = brdService.updBrd01(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: delBrd01
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시글 삭제
	 */
	@RequestMapping("/brd/delBrd01.ajax")
	public ModelAndView delBrd01(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = brdService.delBrd01(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: selBrdAttachList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 게시글 첨부파일 목록 조회
	 */
	@RequestMapping("/brd/selBrdAttachList.ajax")
	public ModelAndView selBrdAttachList(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		List list = brdService.selBrdAttachList(map);

		mav.addObject("data", list);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: selBrdReplyList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 게시글 댓글 목록 조회
	 */
	@RequestMapping("/brd/selBrdReplyList.ajax")
	public ModelAndView selBrdReplyList(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		List list = brdService.selBrdReplyList(map);

		mav.addObject("data", list);
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: selBrdKindList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 게시글 종류 목록 조회
	 */
	@RequestMapping("/brd/selBrdKindList.ajax")
	public ModelAndView selBrdKindList(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		List list = brdService.selBrdKindList(map);

		mav.addObject("data", list);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: insBrd04
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시판종류 등록
	 */
	@RequestMapping("/brd/insBrd04.ajax")
	public ModelAndView insBrd04(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		
		ModelAndView mav = new ModelAndView();
		int count = brdService.insBrd04(map);

		mav.addObject("data", count);
		mav.setViewName("jsonView");
		return mav;
	}	
}
