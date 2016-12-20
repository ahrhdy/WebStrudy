package com.framework.spring.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.framework.spring.common.support.CommonConfig;


public class PdfView extends AbstractView{
	
	public PdfView(){
		super.setContentType("application/pdf");
	}
	
	@Override
	protected void renderMergedOutputModel(Map model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		File file = new File((String)model.get(CommonConfig.COMMON_PDF_FILE));
		
		response.setContentType(super.getContentType());
		response.setContentLength((int)file.length());
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", "attachment;filename=\"download.pdf\"");
		OutputStream out = response.getOutputStream();
		FileInputStream  fis = null;
		try{
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
			file.delete();
		}catch (Exception e){
			e.printStackTrace();
		}finally{
			if(fis!=null){fis.close();}
			if(file!=null){file.delete();}
		}		
	}
	
}
