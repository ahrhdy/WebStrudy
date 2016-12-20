package com.framework.spring.sample.web;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.framework.spring.common.support.CommonConfig;
import com.framework.spring.common.support.CommonService;
import com.framework.spring.sample.service.UfmService;

@Controller
public class UfmController {

	@Autowired
	public UfmService ufmService;
	
	@Autowired
	private CommonService commonService;	
	
	/**
	 * 
	 * @Method Name	: selUfmPaging
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 파일 목록 조회
	 */
	@RequestMapping("/ufm/selFileExist.ajax")
	public ModelAndView selPgmList(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");

		ModelAndView mav = new ModelAndView();
		Map fileMap = ufmService.selFileExist(map);

		mav.addObject("data", fileMap);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: delUfm01
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 파일 정보 삭제 조회
	 */
	@RequestMapping("/ufm/delUfm01.ajax")
	public ModelAndView delFile(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");

		ModelAndView mav = new ModelAndView();
		int result = ufmService.delUfm01(map);

		mav.addObject("data", result);
		mav.setViewName("jsonView");
		return mav;
	}
	
	
	/**
	 * 
	 * @Method Name	: Download
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: UFM테이블 조회 파일다운로드 컨트롤
	 */	
	@RequestMapping("/ufm/Download.do")
	public ModelAndView Download(HttpServletRequest request) throws Exception {
		String uuid = request.getParameter("uuid");
		
		Map map = new HashMap();
		map.put(CommonConfig.COMMON_NAME_SPACE, "ufm");
		map.put(CommonConfig.COMMON_SQL_ID, "selUfmDetail");
		map.put("FILE_UUID", uuid);
		
		Map FileMap = commonService.commonGetDetail(map);
		String filePath = FileMap.get("FILE_PATH").toString();
		String fileName = FileMap.get("FILE_ORI_NAME").toString();

		File file = new File(filePath, uuid);
		ModelAndView mav = new ModelAndView("download");
		mav.addObject("downloadFile", file);
		mav.addObject("fileName", fileName);
		
		return mav;
	}		
}
