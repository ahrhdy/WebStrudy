package com.framework.spring.common.file;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

public class FileRepository {
	private String path;
	private String editorPath;
	private String capturePath;
	private String pdfPath;

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
	public String getEditorPath() {
		return editorPath;
	}

	public void setEditorPath(String editorPath) {
		this.editorPath = editorPath;
	}

	public String getCapturePath() {
		return capturePath;
	}

	public void setCapturePath(String capturePath) {
		this.capturePath = capturePath;
	}
	
	public String getPdfPath() {
		return pdfPath;
	}

	public void setPdfPath(String pdfPath) {
		this.pdfPath = pdfPath;
	}	

//	public FileRepository(String path){
//		this.path = path;
//		File saveFolder = new File(path);
//		if(!saveFolder.exists()||saveFolder.isFile()){
//			saveFolder.mkdir();
//		}
//	}
	
	public String saveFile(MultipartFile file) throws IllegalStateException, IOException{
		String key = UUID.randomUUID().toString();
		file.transferTo(new File(path, key));
		
		return key;
	}
	
	public String saveEditorFile(MultipartFile file) throws IllegalStateException, IOException{
		String key = UUID.randomUUID().toString();
		file.transferTo(new File(editorPath, key));
		
		return key;
	}
	
	public boolean deleteFile(String uuid){
		File file = new File(this.path, uuid);
		boolean result = false;
		if(file.isFile()){
			file.delete();
		}
		return result;
	}
}
