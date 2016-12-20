<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)GRID 후 처리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);	//GRID객체 선언 - @그리드 id, @페이징 처리(true,false)

$(document).ready(function() {
	getDataList();
});

/* 그리드 컬럼 숨기기 */
function hideColunm(){
	listBind.hidden("USER_NAME"); //컬럼명 
	listBind.hidden("MOBILE");
}

/* 그리드 컬럼 보이기 */
function showColunm(){
	listBind.show("USER_NAME"); //컬럼명
	listBind.show("MOBILE");
}

/* 그리드 후 처리 */
function afterProcess(json){
	
	//user_id에 따른 그리드에 후처리
	for(var i=0; i<json.data.length; i++){
		if(json.data[i].USER_ID == "admin"){
			$("#gridList").find("tr").eq(i).addClass("info");
		}else if(json.data[i].USER_ID == "testuser11"){
			$("#gridList").find("tr").eq(i).addClass("danger");
		}else if(json.data[i].USER_ID == "testuser21"){			
			$("#gridList").find("tr").eq(i).addClass("warning");
		}
	}
}


/* 그리드 데이터 조회 */
function getDataList(){		
	var param = new Map();	//파라메터 변수

	listBind.controller("/common/emp/list/selEmpList.ajax"); //조회 url 설정
	listBind.setParam(param); //조회 파라메터 설정
	listBind.setGridPageInfo("divGridInfo"); //GRID정보 표현 
	listBind.setCallBack(afterProcess);	//그리드 바인딩 후 처리 콜백 함수
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
						<h2>GRID 후처리
							<span class="fr">					
								<button class="btn btn-sm btn-info" onclick="hideColunm();">컬럼 숨기기</button>
								<button class="btn btn-sm btn-info" onclick="showColunm();">컬럼 보이기</button>				
							</span>			
						</h2>
						
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
								<th width="15%" data-column="USER_ID">아이디</th>
								<th width="20%" data-column="USER_NAME">이름</th>
								<th width="15%" data-column="EMAIL">e-메일</th>
								<th width="30%" data-column="MOBILE">휴대전화</th>
								<th width="20%" data-column="INS_DATE">등록일자</th>
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