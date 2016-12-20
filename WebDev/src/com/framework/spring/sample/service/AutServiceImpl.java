package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.framework.spring.common.support.CommonUtil;
import com.framework.spring.sample.dao.AutDao;
import com.framework.spring.sample.dao.PgmDao;


@Service
public class AutServiceImpl implements AutService{
	
	@Autowired
	public AutDao autDao;
	
	@Autowired
	public PgmDao pgmDao;
	
	public List selEmpList(Map map) throws SQLException{
		return autDao.selEmpList(map);
	}
	
	public List selAutList(Map map) throws SQLException{
		return autDao.selAutList(map);
	}
	
	@Transactional
	public Object insAut(Map map) throws Exception{
		
		CommonUtil commonUtil = new CommonUtil();
		int result = 0;
		try{
			List gridList = commonUtil.jsonArrToList(map.get("listData").toString());
			autDao.delAut(map); //사용자의 프로그램 권한 전체 삭제
			
			for(int i=0; i<gridList.size(); i++){
				Map rowData = (Map)gridList.get(i);
				rowData.put("USER_ID", map.get("USER_ID"));
				autDao.insAut(rowData);
				result++;
			}
		}catch(SQLException se){
			se.getErrorCode();
		}
		return result;
	}
	
	public boolean commonCheckMenuAut(Map map) throws Exception{
		String strUri = map.get("REQUEST_URI").toString();
		List autList = autDao.selUserAutList(map);
		int autCount = 0;
		boolean bResult = true;
		
		Map param = new HashMap();
		param.put("PGM_URL", strUri);
		
		int pgmCount = pgmDao.selPgmList(param).size();	
		
		for(int i=0; i<autList.size(); i++){
			Map autMap = (Map)autList.get(i);
			
			if(strUri.equals(autMap.get("PGM_URL").toString())){
				autCount++;
			}				
		}
		
		if(autCount == 0 && pgmCount > 0){
			bResult = false;
		}
			
		return bResult;
	}	
}
