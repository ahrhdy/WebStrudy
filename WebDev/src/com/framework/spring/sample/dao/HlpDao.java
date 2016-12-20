package com.framework.spring.sample.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class HlpDao{
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 * 
	 * @Method Name	: selPgmList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 도움말 리스트 조회
	 */
	public List selPgmList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("hlp.selPgmList", map);
	}	
	
	/**
	 * 
	 * @Method Name	: selHlpExist
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 도움말 중복 확인
	 */
	public int selHlpExist(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.queryForObject("hlp.selHlpExist", map);
	}		
	
	/**
	 * 
	 * @Method Name	: insHlp
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 도움말 등록
	 */
	public Object insHlp(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("hlp.insHlp", map);
	}
	
	/**
	 * 
	 * @Method Name	: updHlp
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 도움말수정
	 */
	public int updHlp(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.update("hlp.updHlp", map);
	}	
}
