package com.framework.spring.common.support;

import java.io.File;
import java.io.FileInputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.framework.spring.common.file.FileRepository;


@Service
public class CommonServiceImpl implements CommonService{
	
	@Autowired
	public CommonDao commonDao;
	
	@Autowired
	private FileRepository repository;	

	public List commonGetList(Map map) throws SQLException{
		return commonDao.commonGetList(map);
	}
	
	public List commonGetPaging(Map map) throws SQLException{
		List<Object> list = new ArrayList();
		list.add(commonDao.commonGetPaging(map));
		list.add(commonDao.commonGetPagingCount(map));
		return list;
	}
	
	public Map commonGetDetail(Map map) throws SQLException{
		return commonDao.commonGetDetail(map);
	}	
	
	public Object commonInsert(Map map) throws SQLException{
		return commonDao.commonInsert(map);
	}
	
	public int commonUpdate(Map map) throws SQLException{
		return commonDao.commonUpdate(map);
	}
	
	public int commonDelete(Map map) throws SQLException{
		return commonDao.commonDelete(map);
	}
	
	public List commonReadExcelData(Map map) throws Exception{
		
		List resultList = new ArrayList();		
		List list = (List)map.get("FILE_INFO");
		Map fileMap = (Map)list.get(0);
		
		String fileName = (String)fileMap.get("SAVE_FILE_NAME");
		String filePath = (String)fileMap.get("FILE_PATH");		
		try{
			Map dataMap = null;
			String[] strArrHeader = new String[30];
			
			File file = new File(filePath+"/"+fileName);
			
	        FileInputStream inputStream = new FileInputStream(file);
			XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
			
			//0번째 sheet 정보 취득
			XSSFSheet sheet = workbook.getSheetAt(0);

			//취득된 sheet에서 rows수 취득
			int rows = sheet.getPhysicalNumberOfRows();
			
			XSSFRow row;
			XSSFCell cell;			

			//취득된 row에서 취득대상 cell수 취득
			int cells = sheet.getRow(0).getPhysicalNumberOfCells();	

			for (int r = 0; r < rows; r++) {
				row = sheet.getRow(r); // row 가져오기
				
				if (row != null) {
					
					dataMap = new HashMap();
					
					for (int c = 0; c < cells; c++) {
						cell = row.getCell(c);
						
						if (cell != null) {
							
							String value = null;

							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								value = "" + new Double(cell.getNumericCellValue()).intValue();								
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = "" + cell.getStringCellValue();
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = "" + cell.getErrorCellValue();
								break;
							default:
								value ="";
							}							
							
							if(r == 0){
								strArrHeader[c] = value;								
							}else{
								dataMap.put(strArrHeader[c], value);								
							}
														
						}
					} // for(c) 문
					
					if(r!=0){
						resultList.add(dataMap);
					}
				}

			} // for(r) 문			
			
		}catch(Exception e){
			
		}finally{
			repository.deleteFile(fileName);
		}
		
		return resultList;
	}	
	
	public List selXmlUrlReader(Map map) throws Exception{
		
		List list = new ArrayList();
		
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(map.get("URL").toString());		
		doc.getDocumentElement().normalize();
		
		NodeList nList = doc.getElementsByTagName("item");
		for (int temp = 0; temp < nList.getLength(); temp++) {
			Map xmlRowMap = new HashMap();
			Node nNode = nList.item(temp);
			if(nNode.getNodeType() == Node.ELEMENT_NODE) {
	
				Element eElement = (Element) nNode;
				xmlRowMap.put("author", getTagValue("author", eElement));
				xmlRowMap.put("title", getTagValue("title", eElement));
				xmlRowMap.put("link", getTagValue("link", eElement));
				xmlRowMap.put("description", getTagValue("description", eElement));
				xmlRowMap.put("pubDate", getTagValue("pubDate", eElement));
			}
			
			list.add(xmlRowMap);
		}		
		return list;
	}
	
	private static String getTagValue(String sTag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();

		Node nValue = (Node) nlList.item(0);

		return nValue.getNodeValue();
	}	
}
