package com.framework.spring.common.support;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


public interface CommonService{
	public List commonGetList(Map map) throws SQLException;
	public List commonGetPaging(Map map) throws SQLException;
	public Map commonGetDetail(Map map) throws SQLException;
	public Object commonInsert(Map map) throws SQLException;
	public int commonUpdate(Map map) throws SQLException;
	public int commonDelete(Map map) throws SQLException;
	public List commonReadExcelData(Map map) throws Exception;	
	public List selXmlUrlReader(Map map) throws Exception;
}
