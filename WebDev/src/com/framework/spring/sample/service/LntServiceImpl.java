package com.framework.spring.sample.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.spring.sample.dao.LntDao;


@Service
public class LntServiceImpl implements LntService{
	
	@Autowired
	public LntDao lntDao;	
		
	public int insLnt(Map map) throws Exception{
		int count = lntDao.selLntExist(map);
		int result = 0;
		if(count > 0){
			result = lntDao.updLnt(map);
		}else{
			lntDao.insLnt(map);
			result = 1;			
		}
		
		return result;
	}
}
