package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.spring.sample.dao.CdeDao;


@Service
public class CdeServiceImpl implements CdeService{
	
	@Autowired
	public CdeDao cdeDao;	

	public List selCodeList(Map map) throws SQLException{		
		return cdeDao.selCodeList(map);
	}	
	
	public int selCodeExist(Map map) throws SQLException{
		return cdeDao.selCodeExist(map);
	}	
	
	public Object insCode(Map map) throws Exception{
		
		int count = cdeDao.selCodeExist(map);
		
		if(count > 0){
			throw new SQLException("사용중인 코드섹션 입니다.");
		}
		
		return cdeDao.insCode(map);
	}
	
	public int updCode(Map map) throws SQLException{
		return cdeDao.updCode(map);
	}
	
	public int delCode(Map map) throws SQLException{
		return cdeDao.delCode(map);
	}
	
	public List selCodeDetailList(Map map) throws SQLException{		
		return cdeDao.selCodeDetailList(map);
	}	
	
	public int selCodeDetailExist(Map map) throws SQLException{
		return cdeDao.selCodeDetailExist(map);
	}	
	
	public Object insCodeDetail(Map map) throws Exception{
		
		int count = cdeDao.selCodeDetailExist(map);
		
		if(count > 0){
			throw new SQLException("사용중인 코드키 입니다.");
		}
		
		return cdeDao.insCodeDetail(map);
	}
	
	public int updCodeDetail(Map map) throws SQLException{
		return cdeDao.updCodeDetail(map);
	}
	
	public int delCodeDetail(Map map) throws SQLException{
		return cdeDao.delCodeDetail(map);
	}	
}
