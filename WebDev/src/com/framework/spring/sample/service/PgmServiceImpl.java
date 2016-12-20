package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.spring.sample.dao.PgmDao;


@Service
public class PgmServiceImpl implements PgmService{
	
	@Autowired
	public PgmDao pgmDao;	
	
	public List selPgmList(Map map) throws SQLException{
		return pgmDao.selPgmList(map);
	}
	
	public Object insPgm(Map map) throws Exception{
		
		int Count = pgmDao.selPgmExist(map);
		
		if(Count > 0){
			throw new SQLException("사용중인 프로그램ID 입니다.");
		}
		
		return pgmDao.insPgm(map);
	}
	
	public int updPgm(Map map) throws SQLException{
		return pgmDao.updPgm(map);
	}
	
	public int delPgm(Map map) throws SQLException{
		return pgmDao.delPgm(map);
	}	

}
