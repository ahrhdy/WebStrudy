<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)GRID 페이징</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", true);	//GRID객체 선언 - @그리드 id, @페이징 처리(true,false)

$(document).ready(function() {
	getDataList();
});

/* 그리드 데이터 조회 */
function getDataList(){		
	var param = new Map();	//파라메터 변수

	listBind.controller("/emp/selEmpPaging.ajax"); //조회 url 설정
	listBind.setParam(param); //조회 파라메터 설정
	listBind.setGridPageInfo("divGridInfo"); //GRID정보 표현 
	listBind.setRowCount(10); //GRID에 보여줄 row의 수 (기본 :10)
	listBind.setPageId("divPage"); //페이징 처리 보여줄 HTML TAG id값	
	listBind.sendAjax(); //데이터 호출
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
						<h2>GRID 페이징</h2>
						
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
								<th width="15%">아이디</th>
								<th width="20%">이름</th>
								<th width="15%">e-메일</th>
								<th width="30%">휴대전화</th>
								<th width="20%">등록일자</th>
								</tr>
							</thead>
							<tbody id="gridList" ><!-- 그리드 id 정의 -->
								<tr>						
									<td>{USER_ID}</td><!-- {그리드컬럼명 정의} -->
									<td>{USER_NAME}</td>
									<td>{EMAIL}</td>
									<td>{MOBILE}</td>
									<td>{INS_DATE}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo"></div><!-- 그리드 정보 표현 id -->
						<div id="divPage" class="form-inline text-center"></div><!-- 그리드 페이징 버튼 -->
						
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