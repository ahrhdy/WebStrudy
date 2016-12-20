package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


public interface EmpService{
	public List selEmpPaging(Map map) throws SQLException;
	public int selEmpExist(Map map) throws SQLException;	
	public Object insEmp(Map map) throws Exception;
	public int updEmp(Map map) throws SQLException;
	public int delEmp(Map map) throws SQLException;	
	public int insEmpMulti(Map map) throws Exception;
}
