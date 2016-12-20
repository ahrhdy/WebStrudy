<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)GRID 이동</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);	//GRID객체 선언 - @그리드 id, @페이징 처리(true,false)
var listBind01 = new ListBind("gridList01", false);
var listBind02 = new ListBind("gridList02", false);

$(document).ready(function() {
	getDataList();
});

/* 그리드 데이터 조회 */
function getDataList(){		
	var param = new Map();	//파라메터 변수

	listBind.controller("/common/emp/list/selEmpList.ajax"); //조회 url 설정
	listBind.setParam(param); //조회 파라메터 설정
	listBind.setGridPageInfo("divGridInfo"); //GRID정보 표현 
	listBind.setHeaderFix(true, 200); //GRID 틀고정 (높이 200px)
	listBind.sendAjax(); //데이터 호출
}


/* 그리드 데이터 row 이동 */
function rowsMove01(){
	
	$("#gridList").find(":checkbox").each(function(i){
		if(this.checked){
			// listBind의 선택된 row를 listBind01 그리드로 이동
			listBind.rowMove(i, listBind01);
		}		
	});	
}

function rowsMove02(){
	$("#gridList").find(":checkbox").each(function(i){
		if(this.checked){
			// listBind의 선택된 row를 listBind02 그리드로 이동
			listBind.rowMove(i, listBind02);
		}		
	});	
}	

/* 그리드 선택된 row 삭제 */
function rowsRemove01(){
	// rowDelete(checkbox or radio, input name)
	listBind01.rowDelete("checkbox", "rowCheck01");
}

function rowsRemove02(){
	// rowDelete(checkbox or radio, input name)
	listBind02.rowDelete("checkbox", "rowCheck02");
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
						<h2>GRID 이동
							<span class="fr">					
								<input type="button" class="btn btn-sm btn-info" value="이동_01" onclick="rowsMove01();"/>
								<input type="button" class="btn btn-sm btn-info" value="이동_02" onclick="rowsMove02();"/>				
							</span>			
						</h2>
						
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
								<tr>
									<td><input type="checkbox" name="rowCheck"/></td>			
									<td>{USER_ID}</td><!-- {그리드컬럼명 정의} -->
									<td>{USER_NAME}</td>
									<td>{EMAIL}</td>
									<td>{MOBILE}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo"></div><!-- 그리드 정보 표현 id -->
						
						<h2 class="page-header">이동영역 01
							<span class="fr">
								<input type="button" class="btn btn-sm btn-danger" value="삭제" onclick="rowsRemove01();"/>
							</span>
						</h2>						
						<table class="table table-hover table-condensed table-striped">
						<thead>
							<tr>
								<th width="15%">선택</th>
								<th width="20%">아이디</th>
								<th width="25%">이름</th>
								<th width="40%">e-메일</th>
							</tr>
						</thead>
						<tbody id="gridList01" >
							<tr>
								<td><input type="checkbox" name="rowCheck01"/></td>
								<td>{USER_ID}</td><!-- {그리드컬럼명 정의} -->
								<td>{USER_NAME}</td>
								<td>{EMAIL}</td>		
							</tr>
						</tbody>
						</table>	
				
						<h2 class="page-header">이동영역 02
							<span class="fr">
								<input type="button" class="btn btn-sm btn-danger" value="삭제" onclick="rowsRemove02();"/>
							</span>
						</h2>							
						<table class="table table-hover table-condensed table-striped">
						<thead>
							<tr>
								<th width="15%">선택</th>
								<th width="20%">아이디</th>
								<th width="25%">이름</th>
								<th width="40%">e-메일</th>
							</tr>
						</thead>
						<tbody id="gridList02" >
							<tr>
								<td><input type="checkbox" name="rowCheck02"/></td>
								<td>{USER_ID}</td><!-- {그리드컬럼명 정의} -->
								<td>{USER_NAME}</td>
								<td>{EMAIL}</td>
							</tr>
						</tbody>
						</table>			
						
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