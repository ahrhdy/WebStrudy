package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


public interface AutService{
	public List selEmpList(Map map) throws SQLException;
	public List selAutList(Map map) throws SQLException;	
	public Object insAut(Map map) throws Exception;
	public boolean commonCheckMenuAut(Map map) throws Exception;
}
