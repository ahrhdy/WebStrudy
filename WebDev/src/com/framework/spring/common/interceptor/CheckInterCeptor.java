package com.framework.spring.common.interceptor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.framework.spring.common.file.FileRepository;
import com.framework.spring.sample.dao.UfmDao;
import com.framework.spring.sample.service.AutService;
import com.nhncorp.lucy.security.xss.XssFilter;

public class CheckInterCeptor extends HandlerInterceptorAdapter {
	private final static Logger LOG = LoggerFactory.getLogger(CheckInterCeptor.class);
	public static final String SESSION_USER_ID_KEY = "SS_USER_ID";
	
	@Autowired
	private FileRepository repository;
	
	@Autowired
	private UfmDao ufmDao;
	
	@Autowired
	private AutService autService;
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		String strUri = request.getRequestURI();
		String strUrlType = strUri.split("\\.")[1]; 
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Map map = request.getParameterMap();
		Iterator it = map.keySet().iterator();
		HttpSession session = request.getSession();
		
		paramMap.put(SESSION_USER_ID_KEY, session.getAttribute("userLoginInfo"));	//세션값 Map 설정
		paramMap.put("REQUEST_URI", strUri);
		
		if("do".equals(strUrlType) && !autService.commonCheckMenuAut(paramMap)){
			response.sendRedirect("/index.do");
			return false;
		}else if("fileup".equals(strUrlType) || "editor".equals(strUrlType)){
			XssFilter filter = XssFilter.getInstance("lucy-xss.xml", true);
			MultipartHttpServletRequest fileReq = (MultipartHttpServletRequest)request;
			Iterator itFiles = fileReq.getFileNames();
			List<Map<String, Object>> fileList = new ArrayList();
			Map<String, Object> fileMap = null;			
			
			while(it.hasNext()){
				String key = (String) it.next();			
				paramMap.put(key, filter.doFilter(request.getParameter(key).toString()));
			}			

			while (itFiles.hasNext()) {		
				fileMap = new HashMap<String, Object>();
				MultipartFile file = fileReq.getFile(itFiles.next().toString());			
				String fileName = "";
				if("fileup".equals(strUrlType)){
					fileName = repository.saveFile(file);				
					fileMap.put("FILE_PATH", repository.getPath());
				}else if("editor".equals(strUrlType)){
					fileName = repository.saveEditorFile(file);
					fileMap.put("FILE_PATH", repository.getEditorPath());
				}
				fileMap.put("SAVE_FILE_NAME", fileName);
				fileMap.put("ORG_FILE_NAME", file.getOriginalFilename());
				fileMap.put("FILE_SIZE", file.getSize());				
				fileMap.put("SS_USER_ID", paramMap.get(SESSION_USER_ID_KEY));				
				fileList.add(fileMap);
				
				ufmDao.insUfm(fileMap);
			}	
			paramMap.put("FILE_INFO", fileList);			
		}else{
			while(it.hasNext()){
				String key = (String) it.next();
				paramMap.put(key, request.getParameter(key).toString());			
			}			
		}
		request.setAttribute("ParamData", paramMap);
		LOG.info("[Intercepter]Parameters : "+paramMap);
		return super.preHandle(request, response, handler);
	}

}
