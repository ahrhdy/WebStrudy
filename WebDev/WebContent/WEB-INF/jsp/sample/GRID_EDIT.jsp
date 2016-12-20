<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)GRID 조회</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);	//GRID객체 선언 - @그리드 id, @페이징 처리(true,false)

$(document).ready(function() {
	getDataList();
	
	//수정 클릭
	$("#gridList").on("click", ".glyphicon-pencil",function( event ) {					
		var idx = $(".glyphicon-pencil").index(this);
		listBind.rowEdit(idx);			
	});
	
	//저장 클릭
	$("#gridList").on("click", ".glyphicon-floppy-disk",function( event ) {			
		var idx = $(".glyphicon-floppy-disk").index(this);			
		var param = listBind.rowSave(idx); //그리드 정보 저장
		alert(JSON.stringify(param));
	});	

	//삭제 클릭
	$("#gridList").on("click", ".glyphicon-remove",function( event ) {			
		var idx = $(".glyphicon-remove").index(this);		
		listBind.rowDeleteIndex(idx);
	});		
});

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
						<h2>GRID EDIT</h2>
						
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
								<th width="15%">아이디</th>
								<th width="20%">이름</th>
								<th width="15%">e-메일</th>
								<th width="20%">등록일자</th>
								</tr>
							</thead>
							<tbody id="gridList" ><!-- 그리드 id 정의 -->
								<tr>						
									<td>{USER_ID}</td><!-- {그리드컬럼명 정의} -->
									<td data-input="text" data-class="form-control input-sm" data-column="USER_NAME">{USER_NAME}</td>
									<td data-input="text" data-class="form-control input-sm" data-column="EMAIL">{EMAIL}</td>
									<td data-input="text" data-class="form-control input-sm" data-column="INS_DATE" data-datepicker="yy-mm-dd">{INS_DATE}</td>
									<td>
										<span style="cursor: pointer;" class="glyphicon glyphicon-pencil"></span>
										<span style="cursor: pointer;" class="glyphicon glyphicon-floppy-disk"></span>
										<span style="cursor: pointer;" class="glyphicon glyphicon-remove"></span>
									</td>						
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