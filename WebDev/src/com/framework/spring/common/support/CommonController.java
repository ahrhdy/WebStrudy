package com.framework.spring.common.support;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.framework.spring.common.file.FileRepository;
import com.framework.spring.common.file.PdfUtil;
import com.sun.org.apache.xml.internal.security.utils.Base64;


@Controller
public class CommonController {
	
	@Autowired
	private FileRepository repository;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private PdfUtil pdfUtil;


	/**
	 * 
	 * @Method Name	: download
	 * @author	: MongE
	 * @date	: 2012. 10. 28.
	 * 처리내용	: 파일다운로드 컨트롤
	 */
	@RequestMapping("/download.do")
	public ModelAndView download(HttpServletRequest request){
		String uuid = request.getParameter("uuid");
		String name = request.getParameter("name");
		File file = new File(repository.getPath(), uuid);
		ModelAndView mav = new ModelAndView("download");
		mav.addObject("downloadFile", file);
		mav.addObject("fileName", name);
		
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: editor 이미지 가져오기
	 * @author	: MongE
	 * @date	: 2012. 10. 28.
	 * 처리내용	: 에디터 첨부 이미지 다운로드 컨트롤
	 */
	@RequestMapping("/editor.do")
	public ModelAndView editor(HttpServletRequest request){
		String uuid = request.getParameter("uuid");
		String name = request.getParameter("name");
		File file = new File(repository.getEditorPath(), uuid);
		ModelAndView mav = new ModelAndView("download");
		mav.addObject("downloadFile", file);
		mav.addObject("fileName", name);
		
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: editor 이미지 넣기
	 * @author	: MongE
	 * @date	: 2012. 10. 28.
	 * 처리내용	: 파일다운로드 컨트롤
	 */
	@RequestMapping("/capture.do")
	public ModelAndView capture(HttpServletRequest request){
		String uuid = request.getParameter("uuid");
		File file = new File(repository.getCapturePath(), uuid);
		ModelAndView mav = new ModelAndView("download");
		mav.addObject("downloadFile", file);
		mav.addObject("fileName", uuid);
		
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: findJsp
	 * @author	: MongE
	 * @date	: 2013. 1. 24.
	 * 처리내용	: jsp 화면 찾는 공통컨트롤러
	 */
	@RequestMapping("/{work}/{file}.do")
	public String findJsp(@PathVariable String work, @PathVariable String file){	
		return work+"/"+file;	
	}
	
	/**
	 * 
	 * @Method Name	: imageCreate
	 * @author	: Sang_O
	 * @date	: 2015. 8. 19.
	 * 처리내용	:
	 */
	@RequestMapping("/imageCreate.ajax")
	public ModelAndView imageCreate(HttpServletRequest request)throws Exception{
		ModelAndView mav = new ModelAndView();
		String binaryData = request.getParameter("imgSrc");
		String fileName = UUID.randomUUID().toString()+".png";
		FileOutputStream stream = null;
		try{
			if(binaryData.equals("") || binaryData == null){
				throw new Exception();
			}
			
			binaryData = binaryData.replaceAll("data:image/png;base64,", "");
			byte[] file = Base64.decode(binaryData);
			stream = new FileOutputStream(repository.getCapturePath()+"/"+fileName);
			stream.write(file);
			stream.close();
			
		}catch(Exception e){
			
		}finally{
			stream.close();
		}
		
		mav.addObject("data", fileName);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: jsonToExcel
	 * @author	: Sang_O
	 * @date	: 2015. 8. 19.
	 * 처리내용	:
	 */
	@RequestMapping("/common/json/download.excel")
	public String jsonToExcel(HttpServletRequest request, Map model)throws Exception{
		Map map = (HashMap)request.getAttribute("ParamData");
		
		
		model.put(CommonConfig.COMMON_JSON_EXCEL_DATA, (String)map.get("jsonExcelData"));
		model.put(CommonConfig.COMMON_JSON_EXCEL_COLUMN, (String)map.get("jsonExcelColumn"));
		model.put(CommonConfig.COMMON_JSON_EXCEL_LABEL, (String)map.get("jsonExcelLabel"));
		return "excelView";
	}
	
	/**
	 * 
	 * @Method Name	: pdfDownload
	 * @author	: Sang_O
	 * @date	: 2016. 04. 24.
	 * 처리내용	: pdf파일다운로드 컨트롤
	 */
	@RequestMapping("/pdf/download.do")
	public ModelAndView pdfDownload(HttpServletRequest request){
		String uuid = request.getParameter("uuid");
		String name = request.getParameter("name");
		File file = new File(repository.getPdfPath(), uuid);
		ModelAndView mav = new ModelAndView("download");
		mav.addObject("downloadFile", file);
		mav.addObject("fileName", name);
		
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: htmlPdfViewer
	 * @author	: Sang_O
	 * @date	: 2016. 04. 24.
	 * 처리내용	:
	 */	
	@RequestMapping("/common/pdfView.ajax")
	public ModelAndView htmlPdfViewer(HttpServletRequest request, Map model)throws Exception{
		Map map = (HashMap)request.getAttribute("ParamData");
		
		model.put("filePath", repository.getPdfPath());
		model.put(CommonConfig.COMMON_REPORT_DATA, map.get("reportHtmlData"));
		
		String fileName = pdfUtil.fromHTMLtoPDF(model);
		String fileDownName = "download.pdf";
		
		ModelAndView mav = new ModelAndView();	
		mav.addObject("data", "/pdf/download.do?uuid="+fileName+"&name="+fileDownName);
		mav.setViewName("jsonView");
		return mav;		
	}
	
	
	/**
	 * 
	 * @Method Name : editorFileUp
	 * @author : MongE
	 * @date : 2015. 9. 18. 
	 * 처리내용 : 에디터용 파일업로드 샘플
	 */
	@RequestMapping("/editorFileUp.editor")
	public String editorFileUp(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		List list = (List)map.get("FILE_INFO");
		Map fileMap = (Map)list.get(0);
		
		String serverInfo = "http://" + request.getServerName() + ":"+request.getServerPort(); 
		String returnUrl = (String)map.get("callback");
		String fileName = (String)fileMap.get("SAVE_FILE_NAME");
		String fileOrName =  (String)fileMap.get("ORG_FILE_NAME");
		String fileDownUrl = serverInfo + "/editor.do";
		String callbackFun = (String)map.get("callback_func");
		String redirectUrl = returnUrl + "?callback_func="+callbackFun+"&bNewLine=true&sFileName="+fileOrName+"&sFileURL="+fileDownUrl+"?uuid="+fileName+"&name="+fileOrName;

		return "redirect:" + redirectUrl;
	}
	
	
	/**
	 * 
	 * @Method Name : excelFileUp
	 * @author : MongE
	 * @date : 2015. 8. 26. 
	 * 처리내용 : 엑셀데이터 업로드 샘플
	 */
	@RequestMapping("/excelFileUp.fileup")
	public ModelAndView excelFileUp(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
	
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", commonService.commonReadExcelData(map));
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: commonGetList
	 * @author	: Sang_O
	 * @date	: 2015. 8. 19.
	 * 처리내용	: 공통 LIST 조회 컨트롤러
	 */
	@RequestMapping("/common/{nameSpace}/list/{queryId}.ajax")
	public ModelAndView commonGetList(
			@PathVariable String nameSpace, @PathVariable String queryId ,HttpServletRequest request) 
					throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		map.put(CommonConfig.COMMON_NAME_SPACE, nameSpace);
		map.put(CommonConfig.COMMON_SQL_ID, queryId);

		ModelAndView mav = new ModelAndView();	

		mav.addObject("data", commonService.commonGetList(map));
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: commonGetPaging
	 * @author	: Sang_O
	 * @date	: 2015. 8. 19.
	 * 처리내용	: 공통 Paging 처리 컨트롤러
	 */
	@RequestMapping("/common/{nameSpace}/paging/{queryId}.ajax")
	public ModelAndView commonGetPaging(
			@PathVariable String nameSpace, @PathVariable String queryId ,HttpServletRequest request) 
					throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		map.put(CommonConfig.COMMON_NAME_SPACE, nameSpace);
		map.put(CommonConfig.COMMON_SQL_ID, queryId);
		map.put(CommonConfig.COMMON_SKIP_RESULT, map.get("CurPage"));
		map.put(CommonConfig.COMMON_MAX_RESULT, map.get("RowCount"));
		
		ModelAndView mav = new ModelAndView();
		List list = commonService.commonGetPaging(map);

		mav.addObject("data", list.get(0));
		mav.addObject("count", list.get(1));
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: commonGetList
	 * @author	: Sang_O
	 * @date	: 2015. 8. 19.
	 * 처리내용	: 공통 상세(단건) 조회 컨트롤러
	 */
	@RequestMapping("/common/{nameSpace}/detail/{queryId}.ajax")
	public ModelAndView commonGetDetail(
			@PathVariable String nameSpace, @PathVariable String queryId ,HttpServletRequest request) 
					throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		map.put(CommonConfig.COMMON_NAME_SPACE, nameSpace);
		map.put(CommonConfig.COMMON_SQL_ID, queryId);

		ModelAndView mav = new ModelAndView();	

		mav.addObject("data", commonService.commonGetDetail(map));
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: commonInsert
	 * @author	: Sang_O
	 * @date	: 2015. 8. 19.
	 * 처리내용	: 공통 insert 처리 컨트롤러
	 */
	@RequestMapping("/common/{nameSpace}/insert/{queryId}.ajax")
	public ModelAndView commonInsert(
			@PathVariable String nameSpace, @PathVariable String queryId ,HttpServletRequest request) 
					throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		map.put(CommonConfig.COMMON_NAME_SPACE, nameSpace);
		map.put(CommonConfig.COMMON_SQL_ID, queryId);
		
		ModelAndView mav = new ModelAndView();

		mav.addObject("data", commonService.commonInsert(map));
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: commonUpdate
	 * @author	: Sang_O
	 * @date	: 2015. 8. 19.
	 * 처리내용	: 공통 update 처리 컨트롤러
	 */
	@RequestMapping("/common/{nameSpace}/update/{queryId}.ajax")
	public ModelAndView commonUpdate(
			@PathVariable String nameSpace, @PathVariable String queryId ,HttpServletRequest request) 
					throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		map.put(CommonConfig.COMMON_NAME_SPACE, nameSpace);
		map.put(CommonConfig.COMMON_SQL_ID, queryId);
		
		ModelAndView mav = new ModelAndView();		

		mav.addObject("data", commonService.commonUpdate(map));
		mav.setViewName("jsonView");
		return mav;
	}	
	
	/**
	 * 
	 * @Method Name	: commonDelete
	 * @author	: Sang_O
	 * @date	: 2015. 8. 19.
	 * 처리내용	: 공통 Delete 처리 컨트롤러
	 */
	@RequestMapping("/common/{nameSpace}/delete/{queryId}.ajax")
	public ModelAndView commonDelete(
			@PathVariable String nameSpace, @PathVariable String queryId ,HttpServletRequest request) 
					throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		map.put(CommonConfig.COMMON_NAME_SPACE, nameSpace);
		map.put(CommonConfig.COMMON_SQL_ID, queryId);
		
		ModelAndView mav = new ModelAndView();		

		mav.addObject("data", commonService.commonInsert(map));
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * @Method Name	: selXmlUrlReader
	 * @author	: Sang_O
	 * @date	: 2015. 8. 19.
	 * 처리내용	: XML 리터 처리 컨트롤러
	 */
	@RequestMapping("/selXmlUrlReader.ajax")
	public ModelAndView selXmlUrlReader(HttpServletRequest request) throws Exception {
		Map map = (HashMap) request.getAttribute("ParamData");
		ModelAndView mav = new ModelAndView();		

		mav.addObject("data", commonService.selXmlUrlReader(map));
		mav.setViewName("jsonView");
		return mav;
	}

	/**
	 * 
	 * @Method Name : fileUpload
	 * @author : Sang_O
	 * @date : 2016. 10. 21. 
	 * 처리내용 : 파일업로드 처리(파일만 업로드)
	 */
	@RequestMapping("/fileUpload.fileup")
	public ModelAndView fileUpload(HttpServletRequest request) throws IllegalStateException, IOException {
		Map map = (HashMap) request.getAttribute("ParamData");
		ModelAndView mav = new ModelAndView();
		
		List list = (ArrayList)map.get("FILE_INFO");
		Map resultMap = new HashMap();
		//SAVE_FILE_NAME, ORG_FILE_NAME
		resultMap.put("fileName", ((Map)list.get(0)).get("SAVE_FILE_NAME"));
		resultMap.put("originalFileName", ((Map)list.get(0)).get("ORG_FILE_NAME"));

		mav.addObject("data", resultMap);
		mav.setViewName("jsonView");
		return mav;
	}	
}
