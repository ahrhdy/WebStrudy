package com.framework.spring.common.file;

import java.io.File;
import java.io.FileOutputStream;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import com.framework.spring.common.support.CommonConfig;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.html.simpleparser.HTMLWorker;
import com.lowagie.text.html.simpleparser.StyleSheet;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.pdf.PdfWriter;


public class PdfUtil {
	
	private String createStamp(String filePath, String fileName) throws Exception {
			
		PdfContentByte under = null;
		PdfContentByte over = null;
		PdfReader reader = null;
		PdfStamper stamp = null;
		Image img = null;
		File file = null;
		
		String fileInfo = filePath + "/" + fileName;
		String jobFileInfo = filePath + "/" + UUID.randomUUID().toString();			
		
		try{
			reader = new PdfReader(fileInfo);
			int n = reader.getNumberOfPages();
			int i = 1;
						
			stamp = new PdfStamper(reader, new FileOutputStream(jobFileInfo));
			img = Image.getInstance(filePath + "/watermark.jpg");
			BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED);
			
			img.setAbsolutePosition(350, 150);
			
			while (i <= n) 
			{
				// Watermark under the existing page
				under = stamp.getUnderContent(i);
				under.addImage(img);
				
				// Text over the existing page
				over = stamp.getOverContent(i);
				over.beginText();
				over.setFontAndSize(bf, 14);
				over.showText("No. " + i);
				over.endText();
				
				i++;
			}			
			stamp.close();					  
			file = new File(fileInfo);
			file.delete();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{			
			if(file!=null){file.delete();}
		}

		
		return jobFileInfo;
	}
	
	public String fromHTMLtoPDF(Map model) throws Exception{
		
		String filePath = (String)model.get("filePath");		
		String htmlTag = (String)model.get(CommonConfig.COMMON_REPORT_DATA);
		
		String pdfFile = UUID.randomUUID().toString();
		String pdfInfo = filePath + "/" + pdfFile; 
		
		try{
			FontFactory.register(filePath+"/GulimChe.ttf");
			Document document = new Document();
			StyleSheet style = new StyleSheet();
			style.loadTagStyle("body", "face", "굴림체"); 
			style.loadTagStyle("body", "encoding", "Identity-H"); 
			style.loadTagStyle("body", "leading", "12,0"); 

			PdfWriter.getInstance(document, new FileOutputStream(pdfInfo));
			document.open();
			ArrayList p = HTMLWorker.parseToList(new StringReader(htmlTag), style);
			for (int k = 0; k < p.size(); ++k){
				document.add((Element) p.get(k));
			}
			document.close();
						
			String[] fileInfo = createStamp(filePath, pdfFile).split("/");
			pdfFile = fileInfo[fileInfo.length-1];
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return pdfFile;
	}	
	
}
