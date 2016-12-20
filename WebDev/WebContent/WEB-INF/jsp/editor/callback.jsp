<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>FileUploader Callback</title>
</head>
<body>
    <script type="text/javascript">
    	
   		// document.domain 설정
		try { document.domain = "http://*.naver.com"; } catch(e) {}
        // execute callback script
        var sUrl = document.location.search.substr(1);
		if (sUrl != "blank") {
	        var oParameter = {}; // query array

	        sUrl.replace(/([^=]+)=([^&]*)(&|$)/g, function(){
	            oParameter[arguments[1]] = arguments[2];
	            return "";
	        });	  
	        if ((oParameter.errstr || '').length) { // on error
	            (parent.jindo.FileUploader._oCallback[oParameter.callback_func+'_error'])(oParameter);
	        } else {
	        	
	        	//2015.09.17 spring의 다운로드 컨트롤러에 맞게 수정 (download.do?uuid=abcdef&name=abc.jpg)
	        	oParameter["sFileURL"] = oParameter["sFileURL"]+"&name="+oParameter["name"];
	        	
		        (parent.jindo.FileUploader._oCallback[oParameter.callback_func+'_success'])(oParameter);
		   }
		}
    </script>
</body>
</html>