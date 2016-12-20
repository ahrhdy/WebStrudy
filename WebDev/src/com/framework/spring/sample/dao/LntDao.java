package com.framework.spring.sample.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LntDao{
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 * 
	 * @Method Name	: selLntExist
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 레이어팝업 중복 확인
	 */
	public int selLntExist(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.queryForObject("lnt.selLntExist", map);
	}		
	
	/**
	 * 
	 * @Method Name	: insLnt
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 레이어팝업 등록
	 */
	public Object insLnt(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("lnt.insLnt", map);
	}
	
	/**
	 * 
	 * @Method Name	: updLnt
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 레이어팝업수정
	 */
	public int updLnt(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.update("lnt.updLnt", map);
	}	
}
