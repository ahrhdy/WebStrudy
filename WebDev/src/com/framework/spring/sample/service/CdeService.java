package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


public interface CdeService{	
	public List selCodeList(Map map) throws SQLException;
	public int selCodeExist(Map map) throws SQLException;	
	public Object insCode(Map map) throws Exception;
	public int updCode(Map map) throws SQLException;
	public int delCode(Map map) throws SQLException;
	
	public List selCodeDetailList(Map map) throws SQLException;
	public int selCodeDetailExist(Map map) throws SQLException;	
	public Object insCodeDetail(Map map) throws Exception;
	public int updCodeDetail(Map map) throws SQLException;
	public int delCodeDetail(Map map) throws SQLException;		
}
