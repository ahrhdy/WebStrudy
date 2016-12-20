package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


public interface BrdService{
	public List selBrdPaging(Map map) throws SQLException;	
	public Object insBrd01(Map map) throws Exception;
	public int updBrd01(Map map) throws SQLException;
	public int delBrd01(Map map) throws Exception;	
	public List selBrdReplyList(Map map) throws SQLException;
	public List selBrdAttachList(Map map) throws SQLException;
	
	public List selBrdKindList(Map map) throws SQLException;	
	public int insBrd04(Map map) throws SQLException;
}
