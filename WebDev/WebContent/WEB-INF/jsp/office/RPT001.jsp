<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>레포트 출력</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var pdf;
var listBind = new ListBind("gridList", false);

$(document).ready(function(){
	pdf = new PdfView("pdfView");	//pdf 뷰어로 사용될 div태그 id값
	
	getUserList();
});

function getUserList(){
	var param = new Map();	//파라메터 변수
	listBind.controller("/aut/selEmpList.ajax");	//컨트롤러 url (리스트 처리용)
	listBind.setHeaderFix(true);	// (유무, 높이) 그리드 헤더 고정 true, 기본값은 false (테이블 그리드일때만 사용가능함)
	listBind.setGridPageInfo("divGridInfo01"); //그리드 행 전체 수 
	listBind.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind.sendAjax();	//컨트롤러 호출
}

/* PDF 파일로 생성 후 뷰어에 보이기(리스트 양식) */
function getPdfMake(){
	var param = new Map();	//파라메터 변수	
	
	param.put("NAME", "맛좋은 맛상오");
	param.put("PHONE", "010-4902-8735");
	param.put("LIST", listBind.getJsonData()); // ListBind.getJsonData() - 그리드 전체 데이터 가져옴
	
	//  양식폼 - /frm/report_sample02.jsp
	pdf.getMakePdf("/frm/report_sample02.do", param);
}

function getExcelList(){
	listBind.setExcelColumn("USER_ID,USER_NAME,MOBILE,TEL,EMAIL");
	listBind.setExcelLabel("아이디,이름,휴대전화,집전화,이메일");
	listBind.excelDownLoad();
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
                		
					<div class="col-lg-6">
						<!-- pdf 뷰어로 사용될 div 태그 Start -->
						<h3>PDF 뷰어</h3>				
						<div id="pdfView">
						</div>
						<!-- pdf 뷰어로 사용될 div 태그 End -->			
					</div>
					
					<div class="col-lg-6">
						<h3>PDF 생성
							<span class="fr">				
								<button class="btn btn-sm btn-info" onclick="getExcelList();">엑셀다운로드</button>
								<button class="btn btn-sm btn-info" onclick="getPdfMake();">PDF 생성 및 보기</button>					
							</span>		
						</h3>
						
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="30%">아이디</th>
									<th width="30%">이름</th>
									<th width="40%">이메일</th>
								</tr>
							</thead>
							<tbody id="gridList" >
								<tr class="curser-pointer">
									<td>{USER_ID}</td>
									<td>{USER_NAME}</td>
									<td>{EMAIL}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo01"></div>				
					</div>
		
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