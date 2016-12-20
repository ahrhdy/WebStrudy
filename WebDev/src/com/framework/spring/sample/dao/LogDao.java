package com.framework.spring.sample.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LogDao{
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 * 
	 * @Method Name	: selLogList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 로그목록 조회
	 */
	public int selLogList(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.queryForObject("log.selLogList", map);
	}		
	
	/**
	 * 
	 * @Method Name	: insLog
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 로그 등록
	 */
	public Object insLog(String strMsg) throws SQLException{
		return sqlMapClientTemplate.insert("log.insLog", strMsg);
	}
	
	/**
	 * 
	 * @Method Name	: delLog
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 로그 삭제
	 */
	public int delLog(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("log.delLog", map);
	}
}
