package com.framework.spring.common.support;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
 
@Controller
public class LoginController {   
     
	@Autowired
	CommonDao commonDao;
	
	@RequestMapping(value = "/index.do")
    public String index(HttpSession session, HttpServletRequest request, ModelMap model) 
    		throws Exception {
        
		if(session.getAttribute("userLoginInfo") != null){
			return "redirect:" + "http://" + request.getServerName() + ":"+request.getServerPort() + "/office/MAIN.do";
		}else{
			return "login";
		}
    }
	
    @RequestMapping(value = "/login.do")
    public String login(HttpSession session, HttpServletRequest request, ModelMap model) 
    		throws Exception {
        System.out.println("Welcome login!" + session.getId());
        
        String sReturnUrl = "";
        
        Map map = (HashMap)request.getAttribute("ParamData");        
        List userList = new ArrayList();
        map.put("USER_ID", map.get("USERID").toString());
        map.put("USER_PW", map.get("PASSWORD").toString());    
        
        userList = commonDao.commonGetUserInfo(map);
        
        //로그인 정보 변수 설정
        if(userList.size() > 0){
        	session.setAttribute("userLoginInfo", map.get("USERID").toString());
        	return "redirect:" + "http://" + request.getServerName() + ":"+request.getServerPort() + "/office/MAIN.do";
        }else{
        	model.put("flag", "y");
        	return "redirect:" + "http://" + request.getServerName() + ":"+request.getServerPort() + "/index.do";
        }
    }
    
	@RequestMapping(value = "/logout.do")	
	public String logout(HttpSession session, HttpServletRequest request ,ModelMap model) 
			throws Exception {
		session.invalidate();
		String returnUrl = "http://" + request.getServerName() + ":"+request.getServerPort() + "/index.do"; 
		return "redirect:" + returnUrl;
	}
}

