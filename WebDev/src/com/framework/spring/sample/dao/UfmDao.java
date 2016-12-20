package com.framework.spring.sample.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UfmDao{
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 * 
	 * @Method Name	: selUfmList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 파일정보 리스트 조회
	 */
	public List selUfmList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("ufm.selUfmList", map);
	}	
	
	/**
	 * 
	 * @Method Name	: selUfmDetail
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 파일정보 상세 조회
	 */	
	public Map selUfmDetail(Map map) throws SQLException{		
		return (Map)sqlMapClientTemplate.queryForObject("ufm.selUfmDetail", map);
	}		
	
	/**
	 * 
	 * @Method Name	: insUfm
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 파일정보 등록
	 */
	public Object insUfm(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("ufm.insUfm", map);
	}
	
	/**
	 * 
	 * @Method Name	: delUfm
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 파일 정보 삭제
	 */
	public int delUfm(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("ufm.delUfm", map);
	}
	
	/**
	 * 
	 * @Method Name	: selUfmScheduleList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 파일정보(물리적파일 없는) 리스트 조회
	 */
	public List selUfmScheduleList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("ufm.selUfmScheduleList", map);
	}
	
	/**
	 * 
	 * @Method Name	: insUfmSchedule
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 파일정보(물리적파일 없는) 등록
	 */
	public Object insUfmSchedule(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("ufm.insUfmSchedule", map);
	}	
	
	/**
	 * 
	 * @Method Name	: delUfmSchedule
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 파일정보(물리적파일 없는) 정보 삭제
	 */
	public int delUfmSchedule(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("ufm.delUfmSchedule", map);
	}	
	

}
