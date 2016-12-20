package com.framework.spring.sample.service;

import java.io.File;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.spring.sample.dao.UfmDao;

@Service
public class UfmServiceImpl implements UfmService {

	@Autowired
	public UfmDao ufmDao;

	public Map selFileExist(Map map) throws Exception {
		Map fileMap = ufmDao.selUfmDetail(map);
		String filePath = fileMap.get("FILE_PATH").toString();
		String fileName = fileMap.get("FILE_UUID").toString();

		File file = new File(filePath, fileName);
		if (file.isFile()) {
			fileMap.put("FILE_EXIST", "Y");
		} else {
			fileMap.put("FILE_EXIST", "N");
		}

		return fileMap;
	}

	public int delUfm01(Map map) throws Exception {
		return ufmDao.delUfm(map);
	}
}
