package com.framework.spring.sample.service;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.framework.spring.common.support.CommonUtil;
import com.framework.spring.sample.dao.BrdDao;
import com.framework.spring.sample.dao.UfmDao;


@Service
public class BrdServiceImpl implements BrdService{
	
	@Autowired
	public BrdDao brdDao;	
	
	@Autowired
	public UfmDao ufmDao;
	
	public List selBrdPaging(Map map) throws SQLException{
		List<Object> list = new ArrayList();
		list.add(brdDao.selBrdPaging(map));
		list.add(brdDao.selBrdPagingCount(map));
		return list;
	}
	
	@Transactional
	public Object insBrd01(Map map) throws Exception{
		
		CommonUtil commonUtil = new CommonUtil();
		File file = null;
		int nBrdSeq = 0;		
		
		try{
			//등록 or 수정 처리
			if("".equals(map.get("BRD_SEQ").toString())){			
				nBrdSeq = brdDao.insBrd01(map);
			}else{
				brdDao.updBrd01(map);
				nBrdSeq = Integer.parseInt(map.get("BRD_SEQ").toString());
			}
			

			
			//기존 업로드 되었던 파일목록 처리 (파일삭제시 물리적인 파일도 삭제 처리)			
			if(map.containsKey("FILE_LIST")){
				List selFileList = brdDao.selBrdAttachList(map);	//기존에 업로드된 파일목록 조회
				List fileList = commonUtil.jsonArrToList(map.get("FILE_LIST").toString()); //화면에서 넘어온 기존파일목록
				List deleteFileList = selFileList;
				
				for(int i=0; i<selFileList.size(); i++){
					String fileId01 = ((Map)selFileList.get(i)).get("FILE_UUID").toString();
					
					for(int j=0; j<fileList.size(); j++){
						String fileId02 = ((Map)fileList.get(j)).get("FILE_UUID").toString();
						
						if(fileId01.equals(fileId02)){
							deleteFileList.remove(j);
						}
					}
				}
				
				for(int k=0; k<deleteFileList.size(); k++){
					Map delFileMap = (Map)deleteFileList.get(k);
					brdDao.delBrd02(delFileMap);
					
					Map ufmMap = ufmDao.selUfmDetail(delFileMap);
					String filePath = ufmMap.get("FILE_PATH").toString();
					String fileName = ufmMap.get("FILE_UUID").toString();
					file = new File(filePath, fileName);
					if(file.isFile()){
						file.delete();
					}					
				}
			}		
			
			
			//신규 업로드 파일정보 등록
			if(map.containsKey("FILE_INFO")){
				List fileList = (List)map.get("FILE_INFO");
				for(int i=0; i<fileList.size(); i++){
					Map fileMap = (Map)fileList.get(i);
					fileMap.put("BRD_SEQ", nBrdSeq);
					fileMap.put("FILE_UUID", fileMap.get("SAVE_FILE_NAME"));					
					brdDao.insBrd02(fileMap);
				}
			}
			
		}catch(Exception ex){
			throw new Exception(ex.getMessage());
		}

		
		return nBrdSeq;
	}
	
	public int updBrd01(Map map) throws SQLException{
		return brdDao.updBrd01(map);
	}
	
	@Transactional
	public int delBrd01(Map map) throws Exception{
		
		File file = null;
		//관련 댓글삭제
		brdDao.delBrd03BrdSeq(map);		
		
		//관련 파일정보 삭제
		List selFileList = brdDao.selBrdAttachList(map);	//기존에 업로드된 파일목록 조회
		for(int i=0; i<selFileList.size(); i++){
			Map fileMap = (Map)selFileList.get(i);
			brdDao.delBrd02(fileMap);
			
			Map ufmMap = ufmDao.selUfmDetail(fileMap);
			String filePath = ufmMap.get("FILE_PATH").toString();
			String fileName = ufmMap.get("FILE_UUID").toString();
			file = new File(filePath, fileName);
			if(file.isFile()){
				file.delete();
			}			
		}		
		
		//관련 게시글 삭제		
		return brdDao.delBrd01(map);
	}
	
	public List selBrdReplyList(Map map) throws SQLException{
		return brdDao.selBrdReplyList(map);
	}	
	
	public List selBrdAttachList(Map map) throws SQLException{
		return brdDao.selBrdAttachList(map);
	}	
	
	public List selBrdKindList(Map map) throws SQLException{
		return brdDao.selBrdKindList(map);
	}	
	
	@Transactional
	public int insBrd04(Map map) throws SQLException{
		
		int count = brdDao.selBrdKindExist(map);
		int result = 0;
		
		if(count > 0){
			result = brdDao.updBrd04(map);
		}else{
			brdDao.insBrd04(map);
			result = 1;
		}
		return result;
	}	
}
