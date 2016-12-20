<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>사용자다건등록</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false); //그리드의 id, 페이징 처리(false)

$(document).ready(function() {
	var validation = new Validation("MyForm");
	
	$("#MyForm").submit(function(){	
		if(!validation.check()){	
			return false;	
		}
	});		
});
 
/**
 * 엑셀파일 업로드
 */
function excelUpload(){	
	var param = new Map();
	sendFormAjax("MyForm", param, "/excelFileUp.fileup", excelUploadCallback);	
}

/**
 * 엑셀파일 업로드 콜백
 */
function excelUploadCallback(json){	
	initForm('MyForm');
	listBind.setHeaderFix(true);
	listBind.bindGrid(json.data);
}

/**
 * 그리드 유효성 검사 및 등록
 */
function setData(){
	if(!listBind.validation()){
		alert("입력데이터를 다시 확인하시기 바랍니다.");
		return false;
	}
	
	var param = new Map();
	param.put("listData", listBind.getJsonStringData());	
	sendJsonAjax("/emp/insEmpMulti.ajax", param, setDataCallBack);	
}

/**
 * 그리드 유효성 검사 및 등록 콜백
 */
function setDataCallBack(json){
	alert(json.data +"건을 등록처리 하였습니다.");
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
					<form enctype="multipart/form-data" id="MyForm" name="MyForm" method="post">
					<h3>사용자 다건 등록
						<span class="fr">				
							<input type="submit" value="엑셀업로드" class="btn btn-info btn-sm" onclick="excelUpload();" />
						</span>		
					</h3>
					
					<table class="table">
						<tbody>
							<tr>
								<td>
									<input type="file" name="fileUp"  data-label="파일" data-required="requird" class="" />					
								</td>
							</tr>
						</tbody>
					</table>		
					</form>
					
					<h3>등록 예정 사용자 목록
						<span class="fr">
							<button class="btn btn-sm btn-warning" onclick="setData()">사용자등록</button>
						</span>
					</h3>			
					<table class="table table-hover table-condensed table-striped">
						<thead data-headersort="gridList">
							<tr>
								<th data-column="USER_ID">아이디</th>
								<th data-column="USER_NAME">이름</th>
								<th data-column="USER_PW">임시비밀번호</th>
								<th data-column="TEL">전화</th>
								<th data-column="MOBILE">휴대전화</th>
								<th data-column="EMAIL">이메일</th>
								<th data-column="POST">우편번호</th>
								<th data-column="ADDR1">기본주소</th>
								<th data-column="ADDR2">상세주소</th>
								<th data-column="USE_YN">사용여부</th>
								<th data-column="USER_KINDCD">사용자종류</th>					
							</tr>
						</thead>
						<tbody id="gridList">
							<tr>
								<td data-required="requird minlength:3" >{USER_ID}</td>
								<td data-required="requird" >{USER_NAME}</td>
								<td data-required="requird minlength:8" >{USER_PW}</td>
								<td data-required="tel">{TEL}</td>
								<td data-required="cellphone">{MOBILE}</td>
								<td data-required="email">{EMAIL}</td>
								<td>{POST}</td>
								<td>{ADDR1}</td>
								<td>{ADDR2}</td>
								<td data-required="requird">{USE_YN}</td>
								<td>{USER_KINDCD}</td>			
							</tr>
						</tbody>
					</table>
		
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