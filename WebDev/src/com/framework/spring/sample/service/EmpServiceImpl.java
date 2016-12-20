package com.framework.spring.sample.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.framework.spring.common.support.CommonUtil;
import com.framework.spring.sample.dao.EmpDao;


@Service
public class EmpServiceImpl implements EmpService{
	
	@Autowired
	public EmpDao empDao;	
	
	public List selEmpPaging(Map map) throws SQLException{
		List<Object> list = new ArrayList();
		list.add(empDao.selEmpPaging(map));
		list.add(empDao.selEmpPagingCount(map));
		return list;
	}
	
	public int selEmpExist(Map map) throws SQLException{
		return empDao.selEmpExist(map);
	}	
	
	public Object insEmp(Map map) throws Exception{
		
		int userCount = empDao.selEmpExist(map);
		
		if(userCount > 0){
			throw new SQLException("사용중인 아이디 입니다.");
		}
		
		return empDao.insEmp(map);
	}
	
	public int updEmp(Map map) throws SQLException{
		return empDao.updEmp(map);
	}
	
	public int delEmp(Map map) throws SQLException{
		return empDao.delEmp(map);
	}	
	
	@Transactional
	public int insEmpMulti(Map map) throws Exception{
		
		CommonUtil commonUtil = new CommonUtil();
		int result = 0;
		try{
			List gridList = commonUtil.jsonArrToList(map.get("listData").toString());
			
			for(int i=0; i<gridList.size(); i++){
				Map rowData = (Map)gridList.get(i);
				empDao.insEmp(rowData);
				result++;
			}
		}catch(SQLException se){
			se.getErrorCode();
		}
		return result;
	}	
}
