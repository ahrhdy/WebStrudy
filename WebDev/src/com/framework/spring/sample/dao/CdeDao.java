package com.framework.spring.sample.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CdeDao{
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 * 
	 * @Method Name	: selCodeList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 코드 리스트 조회
	 */
	public List selCodeList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("cde.selCodeList", map);
	}	
	
	/**
	 * 
	 * @Method Name	: selCodeExist
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 코드 중복 확인
	 */
	public int selCodeExist(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.queryForObject("cde.selCodeExist", map);
	}	
	
	/**
	 * 
	 * @Method Name	: insCode
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드 등록
	 */
	public Object insCode(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("cde.insCode", map);
	}		
	
	/**
	 * 
	 * @Method Name	: updCode
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드 정보 수정
	 */
	public int updCode(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.update("cde.updCode", map);
	}	
	
	/**
	 * 
	 * @Method Name	: delCode
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드 정보 삭제
	 */
	public int delCode(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("cde.delCode", map);
	}
	
	
	/**
	 * 
	 * @Method Name	: selCodeDetailList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 코드상세 리스트 조회
	 */
	public List selCodeDetailList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("cde.selCodeDetailList", map);
	}	
	
	/**
	 * 
	 * @Method Name	: selCodeDetailExist
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 코드상세 중복 확인
	 */
	public int selCodeDetailExist(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.queryForObject("cde.selCodeDetailExist", map);
	}	
	
	/**
	 * 
	 * @Method Name	: insCodeDetail
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드상세 등록
	 */
	public Object insCodeDetail(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("cde.insCodeDetail", map);
	}		
	
	/**
	 * 
	 * @Method Name	: updCodeDetail
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드상세 정보 수정
	 */
	public int updCodeDetail(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.update("cde.updCodeDetail", map);
	}	
	
	/**
	 * 
	 * @Method Name	: delCodeDetail
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 코드 정보 삭제
	 */
	public int delCodeDetail(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("cde.delCodeDetail", map);
	}	
}
