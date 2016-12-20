<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)GRID ROW</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);	//GRID객체 선언 - @그리드 id, @페이징 처리(true,false)

$(document).ready(function() {
	getDataList();
	
	//그리드 선택한 row 클릭 처리
	$("#gridList").on("click","tr", getGridClick);
});

/* 그리드 클릭 처리 */
function getGridClick(){
	var idx = $(this).index();
	var row = listBind.rowIdxData(idx); //선택한 그리드 ROW 값
	alert(JSON.stringify(row));
	
	var rowColumn = listBind.rowColumn(idx, "USER_ID"); //선택한 그리드의 USER_ID 컬럼 값
	alert(rowColumn);
}

/* 그리드 전체 정보 JSON */
function getGridAllJson(){
	//getJsonData 그리드의 모든 ROW JSON 정보 가져옴
	alert(listBind.getJsonData());
}

/* 그리드 전체 정보 JSON STRING */
function getGridAllJsonString(){
	//getJsonData 그리드의 모든 ROW JSON 정보 가져옴
	alert(listBind.getJsonStringData());	
}

/* 그리드 다건 선택 정보 JSON */
function getGridSelectJson(){
	//getJsonDataChecked(그리드의 체크박스 name)
	alert(listBind.getJsonDataChecked("rowCheck"));
}

/* 그리드 다건 선택 정보 JSON STRING */
function getGridSelectJsonString(){
	//getJsonStringDataChecked(그리드의 체크박스 name)
	alert(listBind.getJsonStringDataChecked("rowCheck"));	
}

/* 그리드 데이터 조회 */
function getDataList(){		
	var param = new Map();	//파라메터 변수

	listBind.controller("/common/emp/list/selEmpList.ajax"); //조회 url 설정
	listBind.setParam(param); //조회 파라메터 설정
	listBind.setGridPageInfo("divGridInfo"); //GRID정보 표현 
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
						<h2>GRID ROW 정보	</h2>
						<span class="fr">					
							<button class="btn btn-sm btn-success" onclick="getGridAllJson();">GRID 전체 JSON</button>
							<button class="btn btn-sm btn-success" onclick="getGridAllJsonString();">GRID 전체 JSON STRING</button>
							<button class="btn btn-sm btn-success" onclick="getGridSelectJson();">GRID 다건 선택 JSON</button>
							<button class="btn btn-sm btn-success" onclick="getGridSelectJsonString();">GRID 다건 선택 JSON STRING</button>			
						</span>				
						
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
								<th width="10%">
									<input type="checkbox" name="checkAll" onclick="checkAll(this, 'rowCheck');" />
								</th>											
								<th width="15%">아이디</th>
								<th width="20%">이름</th>
								<th width="25%">e-메일</th>
								<th width="30%">휴대전화</th>
								</tr>
							</thead>
							<tbody id="gridList" ><!-- 그리드 id 정의 -->
								<tr style="cursor: pointer;">
									<td><input type="checkbox" name="rowCheck"/></td>		
									<td>{USER_ID}</td><!-- {그리드컬럼명 정의} -->
									<td>{USER_NAME}</td>
									<td>{EMAIL}</td>
									<td>{MOBILE}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo"></div><!-- 그리드 정보 표현 id -->
						
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