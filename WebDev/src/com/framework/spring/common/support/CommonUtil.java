package com.framework.spring.common.support;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class CommonUtil {
	
	public List jsonArrToList(String jsonData) throws Exception{
		
		List<Map> list = new ArrayList();
		
		JSONParser parser=new JSONParser();		
		Object object = parser.parse(jsonData);
		JSONArray jsonArray = (JSONArray)object;
		
		for(int i=0; i<jsonArray.size(); i++){
			JSONObject jsonMap = (JSONObject)jsonArray.get(i);			
			list.add(jsonMap);	
		}		
		
		return list;
	}

}
