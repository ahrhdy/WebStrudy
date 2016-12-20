package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;


public interface PgmService{
	public List selPgmList(Map map) throws SQLException;
	public Object insPgm(Map map) throws Exception;
	public int updPgm(Map map) throws SQLException;
	public int delPgm(Map map) throws SQLException;	
}
