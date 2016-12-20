package com.framework.spring.common.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class BaseExceptionResolver implements HandlerExceptionResolver {
	
	private String view;

	public void setView(String view) {
		this.view = view;
	}

	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, 
			   Object obj, Exception exception){
			   
			   ModelAndView mav = new ModelAndView();
			   try{
					String strUri = request.getRequestURI();
					String strType = strUri.split("\\.")[1];			
					mav.addObject("errorMessage", exception.getMessage());
					
					if("ajax".equals(strType)){
						mav.setViewName("jsonView");
					}else{						
						mav.setViewName(view);
					}					
				}catch (Exception e){
					e.printStackTrace();
				}
		     return mav;
		   }
}
