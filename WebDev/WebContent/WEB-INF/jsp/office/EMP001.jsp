<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>사용자관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", true);
var comboBind = new ComboBind("USER_KINDCD");

$(document).ready(function() {
	getDataList();
	comboBind.setComboName("USER_KINDCD");
	comboBind.setCodeSection("CD002");
	
	$("#gridList").on("click","tr", getDetail);	//사용자정보 그리드 row클릭 이벤트
	$("#NEW_DATA").on("click", setUserIdCheck);
	$("#divDetail #USER_ID").focusout(function(){
		if($("#NEW_DATA").prop("checked")){
			var param = new Map();
			param.put("USER_ID", $("#divDetail #USER_ID").val());
			sendJsonAjax("/emp/selEmpExist.ajax", param, checkExistUserId);
		}
	});
});

/**
 * 사용자 아이디 체크
 */
function checkExistUserId(json){
	if(json.data > 0){
		alert("사용중인 아이디 입니다.");
		$("#divDetail #USER_ID").val("");
	}
}

/**
 * 사용자 정보 조회
 */
function getDataList(){
	var param = new Map();	//파라메터 변수
	
	//divSearch영역의 폼태그의 value값을 읽어와 파라메터를 생성한다.		
	setAreaParamData(param, "divSearch");
	
	listBind.controller("/emp/selEmpPaging.ajax");	//컨트롤러 url
	listBind.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind.setRowCount(10);	//그리드에 보여줄 row의 수 (기본 :10)
	listBind.setPageId("divPage");	// 페이징 보여줄 태그 id
	listBind.setGridPageInfo("divGridInfo"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind.sendAjax();	//컨트롤러 호출
}

/**
 * 사용자 상세정보 설정
 */
function getDetail(){
	var row = listBind.rowIdxData($(this).index()); //그리드의 ROW값
	$("#divDetail #USER_ID").prop("readonly", true);
	$("#USER_PW_RE").val(row["USER_PW"]);
	$("#NEW_DATA").prop("checked", false);
	jsonAutoMapping(row, "divDetail");	
}

/**
 * 사용자 정보 저장
 */
function setData(){
	var bCheckNew = $("#NEW_DATA").prop("checked");
	var param = new Map();	
	var validation = new Validation("divDetail");
	
	if(!validation.check()){
		return false;
	}
	
	setAreaParamData(param, "divDetail");
	
	if(bCheckNew){
		sendJsonAjax("/emp/insEmp.ajax", param, setDataCallBack);	
	}else{
		sendJsonAjax("/emp/updEmp.ajax", param, setDataCallBack);
	}
}

/**
 * 사용자 저장 콜백
 */
function setDataCallBack(json){
	initForm('divDetail');
	alert("저장되었습니다.");
	getDataList();
}

/**
 * 사용자 삭제
 */
function delData(){
	var param = new Map();	
	setAreaParamData(param, "divDetail");
	
	sendJsonAjax("/emp/delEmp.ajax", param, delDataCallBack);
}

/**
 * 사용자 삭제 콜백
 */
function delDataCallBack(json){
	initForm('divDetail');
	alert("삭제되었습니다.");
	getDataList();
}

/**
 * 신규생성 체크시 이벤트
 */
function setUserIdCheck(){
	var $userId = $("#divDetail #USER_ID");
	
	if($(this).prop("checked")){
		$userId.prop("readonly", false);
		initForm('divDetail');
	}else{
		$userId.prop("readonly", true);
	}
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
		
					<h3>사용자 목록
						<span class="fr">
							<button class="btn btn-sm btn-default" onclick="initForm('divSearch');">초기화</button>
							<button class="btn btn-sm btn-info" onclick="getDataList()">조회</button>
						</span>
					</h3>
						
					<table id="divSearch" class="table table-bordered table-condensed">
						<tr>
							<th width="10%">아이디</th>
							<td width="40%"><input type="text" id="USER_ID" name="USER_ID" class="form-control input-sm" value="" /></td>
							<th width="10%">이름</th>
							<td width="40%"><input type="text" id="USER_NAME" name="USER_NAME" class="form-control input-sm" value="" /></td>
						</tr>
						<tr>
							<th>사용자종류</th>
							<td>
								<select id="USER_KINDCD" name="USER_KINDCD" class="form-control input-sm" >
								</select>				
							</td>
							<th>휴대전화</th>
							<td><input type="text" id="MOBILE" name="MOBILE" class="form-control input-sm" value="" /></td>
						</tr>						
					</table>		
				
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
						<tbody id="gridList">			
							<tr class="curser-pointer">
								<td>{USER_ID}</td>
								<td>{USER_NAME}</td>
								<td>{EMAIL}</td>
								<td>{MOBILE}</td>
								<td>{INS_DATE}</td>
							</tr>
						</tbody>
					</table>
					<div id="divGridInfo"></div>
					<div id="divPage" class="form-inline text-center"></div>
					
					<h3>상세화면
						<span class="fr">
							<input type="checkbox" id="NEW_DATA" name="NEW_DATA" /><label for="NEW_DATA" class="h5 curser-pointer">신규등록</label>		
							<button class="btn btn-sm btn-primary" onclick="setData();">저장</button>
							<button class="btn btn-sm btn-danger" onclick="delData();">삭제</button>
						</span>				
					</h3>
					<div id="divDetail">
						<table class="table table-bordered">
						<tr>
							<th width="15%">아이디</th>
							<td width="35%">
								<input type="text" id="USER_ID" name="USER_ID" readonly="readonly" data-label="아이디" data-required="requird minlength:3" class="form-control input-sm" value="" />					
							</td>
							<th width="15%">이름</th>
							<td width="35%"><input type="text" id="USER_NAME" name="USER_NAME" data-label="이름" data-required="requird" class="form-control input-sm" value="" /></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" id="USER_PW" name="USER_PW" data-label="비밀번호" data-required="requird minlength:8" class="form-control input-sm" value=""   placeholder="Enter password"/></td>
							<th>비밀번호 확인</th>
							<td><input type="password" id="USER_PW_RE" name="USER_PW_RE" data-label="비밀번호확인" data-required="requird equals:USER_PW" class="form-control input-sm" value="" /></td>
						</tr>
						<tr>
							<th>전화</th>
							<td><input type="text" id="TEL" name="TEL" data-label="전화" data-required="tel" class="form-control input-sm" value="" /></td>
							<th>휴대전화</th>
							<td><input type="text" id="MOBILE" name="MOBILE" data-label="휴대전화" data-required="cellphone" class="form-control input-sm" value="" /></td>
						</tr>	
						<tr>
							<th>이메일</th>
							<td><input type="text" id="EMAIL" name="EMAIL" data-label="이메일" data-required="email"class="form-control input-sm" value="" /></td>
							<th>우편번호</th>
							<td><input type="text" id="POST" name="POST" class="form-control input-sm" data-required="number minlength:5" maxlength="6"  value="" /></td>				
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
						<tr>
							<th>사용여부</th>
							<td>
								<input type="radio" id="USE_YN" name="USE_YN" data-label="사용여부" data-required="requird" value="Y" />예 
								<input type="radio" name="USE_YN" value="N" />아니오
							</td>
							<th>사용자종류</th>
							<td>
								<select id="USER_KINDCD" name="USER_KINDCD" class="form-control input-sm" >
								</select>				
							</td>
						</tr>																					
						</table>	
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