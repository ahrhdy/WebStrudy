package com.framework.spring.common.file;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.framework.spring.common.support.CommonConfig;

public class ExcelView extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook workbook,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String fileName = "download";
		String sheetName = "sheet";
		HSSFSheet sheet = createSheet(workbook, sheetName);
		
		String strJson = (String)model.get(CommonConfig.COMMON_JSON_EXCEL_DATA);
		String[] strArrColumn = model.get(CommonConfig.COMMON_JSON_EXCEL_COLUMN).toString().split(",");
		String[] strArrLebel  = model.get(CommonConfig.COMMON_JSON_EXCEL_LABEL).toString().split(",");
		JSONParser parser=new JSONParser();		
		Object object = parser.parse(strJson);
		JSONArray jsonArray = (JSONArray)object;
		
		createHeader(sheet, strArrLebel);
		createRow(sheet, jsonArray, strArrColumn);		
		response.setHeader("Content-Disposition", "attachment;fileName=\""+fileName+".xls\";");
	}
	
	private HSSFSheet createSheet(HSSFWorkbook workbook, String sheetName) {
		HSSFSheet sheet = workbook.createSheet();
		workbook.setSheetName(0, sheetName);
		return sheet;
	}
	
	private void createHeader(HSSFSheet sheet, String[] labelList) {
		HSSFRow firstRow = sheet.createRow(0);
		for(int i=0;i<labelList.length;i++){
			HSSFCell cell = firstRow.createCell((short)i);
			cell.setCellValue(labelList[i]);
		}
	}
	
	private void createRow(HSSFSheet sheet, JSONArray jsonArray,  String[] column) {
		
		for(int i=0; i<jsonArray.size(); i++){
			HSSFRow row = sheet.createRow(i+1);
			JSONObject data = (JSONObject)jsonArray.get(i);
			for(int j=0; j<column.length; j++){
				HSSFCell cell = row.createCell((short)j);
				cell.setCellValue(data.get(column[j]).toString());
			}	
		}
	}
}