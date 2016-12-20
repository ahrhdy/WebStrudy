<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)PDF 뷰어</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var pdf;

$(document).ready(function() {
	//pdf객체 선언 및 뷰어로 사용될 div태그 id값
	pdf = new PdfView("pdfView");
});

/* PDF 파일호출 */
function getPdfFile(fileUrl){
	pdf.getPdf(fileUrl);	//보여줄 pdf파일의 url 정보를 넘긴다.
}

</script>
</head>
<body>
	
	<div id="wrapper">

	<!-- 상단 메뉴 START -->
	<%@ include file="/WEB-INF/jsp/include/IncTop.jsp"%>
	<!-- 상단 메뉴 END -->

        <div id="page-wrapper">

            <div class="container-fluid">

               <div class="row">
	
					<!-- 컨텐츠 START -->
					<div class="col-lg-6">
						<h2>PDF 뷰어
							<span class="fr">					
								<button class="btn btn-sm btn-info" onclick="getPdfFile('/pdfviewer/sample1.pdf');">PDF 샘플01</button>
								<button class="btn btn-sm btn-info" onclick="getPdfFile('/pdfviewer/sample2.pdf');">PDF 샘플02</button>
								<button class="btn btn-sm btn-info" onclick="getPdfFile('/pdfviewer/sample3.pdf');">PDF 샘플03</button>				
							</span>	
						</h2>	
						
						<div id="pdfView"></div><!-- PDF 뷰어 div -->			
					</div>
					<!-- 컨텐츠 END -->
					
					<!-- 소스 뷰어 START -->
					<div class="col-lg-6">
						<%@ include file="sourceView.jsp"%>
					</div>
					<!-- 소스 뷰어 END -->
		
               </div>					
                <!-- /.row -->   					
		
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
	
	</div>
	<!-- /#wrapper -->
</body>
</html>