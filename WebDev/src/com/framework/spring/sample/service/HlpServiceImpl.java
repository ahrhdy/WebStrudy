package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.spring.sample.dao.HlpDao;


@Service
public class HlpServiceImpl implements HlpService{
	
	@Autowired
	public HlpDao hlpDao;	
	
	public List selPgmList(Map map) throws SQLException{
		return hlpDao.selPgmList(map);
	}
		
	public int insHlp(Map map) throws Exception{
		int count = hlpDao.selHlpExist(map);
		int result = 0;
		if(count > 0){
			result = hlpDao.updHlp(map);
		}else{
			hlpDao.insHlp(map);
			result = 1;			
		}
		
		return result;
	}
}
