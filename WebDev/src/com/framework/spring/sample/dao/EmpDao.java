package com.framework.spring.sample.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.framework.spring.common.support.CommonConfig;

@Repository
public class EmpDao{
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 * 
	 * @Method Name	: selEmpPaging
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 사용자 정보 페이징 조회
	 */
	public List selEmpPaging(Map map) throws SQLException{
		int skipResult	=	Integer.parseInt((String)map.get(CommonConfig.COMMON_SKIP_RESULT));
		int maxResult	=	Integer.parseInt((String)map.get(CommonConfig.COMMON_MAX_RESULT));
		return sqlMapClientTemplate.queryForList("emp.selEmpPaging", map, skipResult, maxResult);
	}		
	
	/**
	 * 
	 * @Method Name	: selEmpPagingCount
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 사용자 정보 페이징 카운트
	 */
	public int selEmpPagingCount(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.queryForObject("emp.selEmpPagingCount", map);
	}
	
	/**
	 * 
	 * @Method Name	: selEmpList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 사용자 정보 리스트 조회
	 */
	public List selEmpList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("emp.selEmpList", map);
	}	
	
	/**
	 * 
	 * @Method Name	: selEmpExist
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 사용자 아이디 중복 확인
	 */
	public int selEmpExist(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.queryForObject("emp.selEmpExist", map);
	}	
	
	/**
	 * 
	 * @Method Name	: insEmp
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 사용자 정보 등록
	 */
	public Object insEmp(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("emp.insEmp", map);
	}		
	
	/**
	 * 
	 * @Method Name	: updEmp
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 사용자 정보 수정
	 */
	public int updEmp(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.update("emp.updEmp", map);
	}	
	
	/**
	 * 
	 * @Method Name	: delEmp
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 사용자 정보 삭제
	 */
	public int delEmp(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("emp.delEmp", map);
	}	
}
