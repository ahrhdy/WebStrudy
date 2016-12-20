package com.framework.spring.sample.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AutDao{
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 * 
	 * @Method Name	: selEmpList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 사용자 리스트 조회
	 */
	public List selEmpList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("aut.selEmpList", map);
	}	
	
	/**
	 * 
	 * @Method Name	: selAutList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 사용자 프로그램 권한 리스트 조회
	 */
	public List selAutList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("aut.selAutList", map);
	}	
	
	/**
	 * 
	 * @Method Name	: selUserAutList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 사용자 프로그램 권한 리스트 조회(권한체크용 - 인터셉터)
	 */
	public List selUserAutList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("aut.selUserAutList", map);
	}		
	
	
	/**
	 * 
	 * @Method Name	: insAut
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 프로그램 권한 등록
	 */
	public Object insAut(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("aut.insAut", map);
	}		
	
	
	/**
	 * 
	 * @Method Name	: delAut
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 프로그램권한 정보 삭제
	 */
	public int delAut(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("aut.delAut", map);
	}	
}
