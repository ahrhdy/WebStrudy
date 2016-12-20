<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>스케쥴러 로그</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);

$(document).ready(function() {
	getDataList();
});

function getDataList(){
	var param = new Map();	//파라메터 변수
	
	listBind.controller("/common/log/list/selLogList.ajax");	//컨트롤러 url
	listBind.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind.setHeaderFix(true);
	listBind.setGridPageInfo("divGridInfo"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind.sendAjax();	//컨트롤러 호출
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
                
					<h3>작업목록</h3>
								
				 	<table class="table table-hover table-condensed table-striped">
						<thead data-headersort="gridList">
							<tr>
								<th width="15%" data-column="SCHEDULE_DATE">작업일시</th>
								<th width="85%" data-column="SCHEDULE_MSG">작업내용</th>
							</tr>
						</thead>
						<tbody id="gridList">			
							<tr>
								<td>{SCHEDULE_DATE}</td>
								<td>{SCHEDULE_MSG}</td>
							</tr>
						</tbody>
					</table>
					<div id="divGridInfo"></div>		
		
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