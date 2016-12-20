package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


public interface HlpService{
	public List selPgmList(Map map) throws SQLException;
	public int insHlp(Map map) throws Exception;
}
