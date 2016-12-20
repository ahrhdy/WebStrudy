package com.framework.spring.common.scheduled;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.framework.spring.sample.dao.LogDao;
import com.framework.spring.sample.dao.UfmDao;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	public UfmDao ufmDao;
	
	@Autowired
	public LogDao logDao;	
	
	@Transactional
	public int scheduleFileProcess(Map map) throws Exception{	
		
		File file = null;
		String filePath = "";
		String fileName = "";
		int result = 0;
		
		try{
			logDao.insLog("scheduleFileProcess 시작");
			
			List listFile = ufmDao.selUfmList(map);		
			
			ufmDao.delUfmSchedule(map);
			for(int i=0; i<listFile.size(); i++){
				Map fileMap = (Map)listFile.get(i); 
				filePath = fileMap.get("FILE_PATH").toString();
				fileName = fileMap.get("FILE_UUID").toString();

				file = new File(filePath, fileName);
				if (!file.isFile()) {
					ufmDao.insUfmSchedule(fileMap);
					result++;
				}			
			}
			logDao.insLog("scheduleFileProcess 종료");		
			
		}catch(Exception ex){
			logDao.insLog(ex.getMessage());
			throw new Exception(ex.getMessage());
		}
		return result;
	}
}
