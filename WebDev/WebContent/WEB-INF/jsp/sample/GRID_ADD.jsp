<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>(예제)GRID ROW 추가</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);	//GRID객체 선언 - @그리드 id, @페이징 처리(true,false)

/* GRID ROW 추가 */
function gridRowAdd(){
	var param = new Map();
	
	//setAreaParamData : param, tagId (tagId없으면 body태그 사용)
	//특정영역의 폼tag의 value값을 읽어와 파라메터를 생성한다.		
	setAreaParamData(param, "divDetail");
	
	alert(JSON.stringify(param));
	
	//rowAdd() - json데이터를 넣어주면 그리드에 ROW가 추가된다.
	listBind.rowAdd(param["map"]);
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
						<h2>GRID ROW 추가</h2>
						
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="20%">아이디</th>
									<th width="20%">이름</th>
									<th width="30%">e-메일</th>
									<th width="30%">휴대전화</th>
								</tr>
							</thead>
							<tbody id="gridList" >
								<tr>						
									<td>{USER_ID}</td><!-- {그리드컬럼명 정의} -->
									<td>{USER_NAME}</td>
									<td>{EMAIL}</td>
									<td>{MOBILE}</td>
								</tr>
							</tbody>
						</table>
						
						<h2 class="page-header">입력화면
							<span class="fr">
								<input type="button" class="btn btn-sm btn-default" value="초기화" onclick="initForm('divDetail');"/>
								<input type="button" class="btn btn-sm btn-info" value="그리드에 추가" onclick="gridRowAdd();"/>
							</span>			
						</h2>				
						<table id="divDetail" class="table" style="width:100%;">
							<tr>
								<th width="10%">아이디</th>
								<td width="40%"><input type="text" id="USER_ID" name="USER_ID" class="form-control input-sm" value="" /></td>
								<th width="10%">이름</th>
								<td width="40%"><input type="text" id="USER_NAME" name="USER_NAME" class="form-control input-sm" value="" /></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="text" id="EMAIL" name="EMAIL" class="form-control input-sm" value="" /></td>
								<th>휴대전화</th>
								<td><input type="text" id="MOBILE" name="MOBILE" class="form-control input-sm" value="" /></td>
							</tr>											
						</table>			
						
					</div>
					<!-- 컨텐츠 END -->
					
					<!-- 소스 뷰어 START -->
					<div class="col-md-6">
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