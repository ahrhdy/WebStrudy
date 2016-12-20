package com.framework.spring.sample.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PgmDao{
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 * 
	 * @Method Name	: selPgmList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 프로그램 정보 리스트 조회
	 */
	public List selPgmList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("pgm.selPgmList", map);
	}	
	
	/**
	 * 
	 * @Method Name	: selPgmExist
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 프로그램ID 중복 확인
	 */
	public int selPgmExist(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.queryForObject("pgm.selPgmExist", map);
	}	
	
	/**
	 * 
	 * @Method Name	: insPgm
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 프로그램 정보 등록
	 */
	public Object insPgm(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("pgm.insPgm", map);
	}		
	
	/**
	 * 
	 * @Method Name	: updPgm
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 프로그램 정보 수정
	 */
	public int updPgm(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.update("pgm.updPgm", map);
	}	
	
	/**
	 * 
	 * @Method Name	: delPgm
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 프로그램 정보 삭제
	 */
	public int delPgm(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("pgm.delPgm", map);
	}	
}
