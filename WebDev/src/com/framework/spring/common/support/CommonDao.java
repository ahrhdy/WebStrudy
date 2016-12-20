package com.framework.spring.common.support;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CommonDao{
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	public List commonGetList(Map map) throws SQLException{
		String strSqlInfomation =  (String)map.get(CommonConfig.COMMON_NAME_SPACE)+"."+(String)map.get(CommonConfig.COMMON_SQL_ID);		
		return sqlMapClientTemplate.queryForList(strSqlInfomation, map);
	}	
	
	public List commonGetPaging(Map map) throws SQLException{
		String strSqlInfomation	=	(String)map.get(CommonConfig.COMMON_NAME_SPACE)+"."+(String)map.get(CommonConfig.COMMON_SQL_ID);
		int skipResult	=	Integer.parseInt((String)map.get(CommonConfig.COMMON_SKIP_RESULT));
		int maxResult	=	Integer.parseInt((String)map.get(CommonConfig.COMMON_MAX_RESULT));
		return sqlMapClientTemplate.queryForList(strSqlInfomation, map, skipResult, maxResult);
	}		
	
	public int commonGetPagingCount(Map map) throws SQLException{
		String strSqlInfomation	=	(String)map.get(CommonConfig.COMMON_NAME_SPACE)+"."+(String)map.get(CommonConfig.COMMON_SQL_ID)+"Count";
		return (Integer)sqlMapClientTemplate.queryForObject(strSqlInfomation, map);
	}	
	
	public Map commonGetDetail(Map map) throws SQLException{
		String strSqlInfomation	=	(String)map.get(CommonConfig.COMMON_NAME_SPACE)+"."+(String)map.get(CommonConfig.COMMON_SQL_ID);
		return (Map)sqlMapClientTemplate.queryForObject(strSqlInfomation, map);
	}	
	
	public Object commonInsert(Map map) throws SQLException{
		String strSqlInfomation	=	(String)map.get(CommonConfig.COMMON_NAME_SPACE)+"."+(String)map.get(CommonConfig.COMMON_SQL_ID);
		return sqlMapClientTemplate.insert(strSqlInfomation, map);
	}		
	
	public int commonUpdate(Map map) throws SQLException{
		String strSqlInfomation	=	(String)map.get(CommonConfig.COMMON_NAME_SPACE)+"."+(String)map.get(CommonConfig.COMMON_SQL_ID);
		return (Integer)sqlMapClientTemplate.update(strSqlInfomation, map);
	}	
	
	public int commonDelete(Map map) throws SQLException{
		String strSqlInfomation	=	(String)map.get(CommonConfig.COMMON_NAME_SPACE)+"."+(String)map.get(CommonConfig.COMMON_SQL_ID);
		return (Integer)sqlMapClientTemplate.delete(strSqlInfomation, map);
	}
	
	public List commonGetUserInfo(Map map) throws SQLException{		
		return sqlMapClientTemplate.queryForList("emp.selEmpDetail", map);
	}	
	
}
