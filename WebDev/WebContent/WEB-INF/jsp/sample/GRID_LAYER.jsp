<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)GRID 레이어</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);	//GRID객체 선언 - @그리드 id, @페이징 처리(true,false)

$(document).ready(function() {
	getDataList();
	
	//그리드 메뉴버튼 클릭
	$("#gridList").on("mouseenter", "button[name='layerMenu']",function( event ) {	
		var $selecter = $(this);
		var idx = $("button[name='layerMenu']").index(this);
		var winY = $(window).scrollTop();
		var posY = $selecter.offset().top - winY;
		var posX = $selecter.offset().left - 530;
		
		jsonAutoMapping(listBind.rowIdxData(idx), "gridMenu");
		$("#gridMenu").css("top", posY).css("left", posX).show();
	});		
});

/*그레드 레이어 닫기*/
function setHideLayer(){
	$("#gridMenu").hide();
}

/* 그리드 데이터 조회 */
function getDataList(){		
	var param = new Map();	//파라메터 변수

	listBind.controller("/common/emp/list/selEmpList.ajax"); //조회 url 설정
	listBind.setHeaderFix(true);
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
						<h2>GRID 레이어</h2>
						
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
								<th width="15%">아이디</th>
								<th width="20%">이름</th>
								<th width="15%">e-메일</th>
								<th width="30%">휴대전화</th>
								<th width="20%">메뉴</th>
								</tr>
							</thead>
							<tbody id="gridList" ><!-- 그리드 id 정의 -->
								<tr>						
									<td>{USER_ID}</td><!-- {그리드컬럼명 정의} -->
									<td>{USER_NAME}</td>
									<td>{EMAIL}</td>
									<td>{MOBILE}</td>
									<td><button name="layerMenu" class="btn btn-sm btn-info">상세</button></td>
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
	
<!-- 레이어메뉴 START -->
<div id="gridMenu" class="layer" style="display:none;position:fixed;z-index:1;">
	<div class="fr btn glyphicon glyphicon-remove" onclick="setHideLayer();"></div>
	<table class="table table-bordered">
	<tr>
		<th width="15%">아이디</th>
		<td width="35%">
			<input type="text" id="USER_ID" name="USER_ID" class="form-control input-sm" value="" />					
		</td>
		<th width="15%">이름</th>
		<td width="35%"><input type="text" id="USER_NAME" name="USER_NAME" class="form-control input-sm" value="" /></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" id="USER_PW" name="USER_PW" class="form-control input-sm" value="" /></td>
		<th>사용여부</th>
		<td>
			<input type="radio" id="USE_YN" name="USE_YN" value="Y" />예 
			<input type="radio" name="USE_YN" value="N" />아니오
		</td>		
	</tr>
	<tr>
		<th>전화</th>
		<td><input type="text" id="TEL" name="TEL" class="form-control input-sm" value="" /></td>
		<th>휴대전화</th>
		<td><input type="text" id="MOBILE" name="MOBILE" class="form-control input-sm" value="" /></td>
	</tr>	
	<tr>
		<th>이메일</th>
		<td><input type="text" id="EMAIL" name="EMAIL" class="form-control input-sm" value="" /></td>
		<th>우편번호</th>
		<td><input type="text" id="POST" name="POST" class="form-control input-sm" value="" /></td>				
	</tr>
	<tr>
		<th>기본주소</th>
		<td>
			<input type="text" id="ADDR1" name="ADDR1" class="form-control input-sm" value="" />
		</td>
		<th>상세주소</th>
		<td>
			<input type="text" id="ADDR2" name="ADDR2" class="form-control input-sm" value="" />
		</td>				
	</tr>																				
	</table>	
</div>
<!-- 레이어메뉴 END -->
</body>
</html>