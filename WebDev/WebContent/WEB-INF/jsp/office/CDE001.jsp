<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>코드관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind01 = new ListBind("gridList01", false);
var listBind02 = new ListBind("gridList02", false);

$(document).ready(function() {
	getListCode();
	
	$("#gridList01").on("click","tr", getListCodeDt);
	$("#gridList02").on("click","tr", getCodeDetail);
	
	$("#NEW_CODE").on("click", setCodeCheck);
	$("#NEW_CODE_DT").on("click", setCodeDtCheck);	
});

function getListCode(){	
	var param = new Map();	//파라메터 변수
	setAreaParamData(param, "divSearch");

	listBind01.controller("/cde/selCodeList.ajax");	//컨트롤러 url (리스트 처리용)
	listBind01.setHeaderFix(true, 250);	// (유무, 높이) 그리드 헤더 고정 true, 기본값은 false (테이블 그리드일때만 사용가능함)
	listBind01.setGridPageInfo("divGridInfo01"); //그리드 행 전체 수 
	listBind01.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind01.sendAjax();	//컨트롤러 호출	
}

function getListCodeDt(){
	
	//코드정보 값 설정 및 코드상세정보(cd_sec) 설정
	var row = listBind01.rowIdxData($(this).index()); //그리드의 ROW값
	jsonAutoMapping(row, "divDetail01");
	initForm('divDetail02');
	$("#divDetail02 #CD_SEC").val(row.CD_SEC);
	
	//코드상세목록 조회
	var param = new Map();
	setAreaParamData(param, "divDetail01");
	listBind02.controller("/cde/selCodeDetailList.ajax");	//컨트롤러 url (리스트 처리용)
	listBind02.setHeaderFix(true, 250);	// (유무, 높이) 그리드 헤더 고정 true, 기본값은 false (테이블 그리드일때만 사용가능함)
	listBind02.setGridPageInfo("divGridInfo02"); //그리드 행 전체 수 
	listBind02.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind02.sendAjax();	//컨트롤러 호출	
}

function getCodeDetail(){
	$("#NEW_CODE_DT").prop("checked", false);
	$("#CD_KEY").prop("readonly", true);
	var row = listBind02.rowIdxData($(this).index()); //그리드의 ROW값
	jsonAutoMapping(row, "divDetail02");	
}

function setCodeCheck(){
	var $cdSec = $("#divDetail01 #CD_SEC");
	
	if($(this).prop("checked")){
		$cdSec.prop("readonly", false);
		initForm('divDetail01');
	}else{
		$cdSec.prop("readonly", true);
	}	
}

function setCodeDtCheck(){
	var $cdKey = $("#divDetail02 #CD_KEY");
	
	if($(this).prop("checked")){
		$cdKey.prop("readonly", false);
		$("#CD_KEY").val("");
		$("#CD_VALUE").val("");
		$("#CD_DESC").val("");
	}else{
		$cdKey.prop("readonly", true);
	}		
}

function setData01(){
	var bCheckNew = $("#NEW_CODE").prop("checked");
	var param = new Map();	
	var validation = new Validation("divDetail01");
	
	if(!validation.check()){
		return false;
	}
	
	setAreaParamData(param, "divDetail01");
	
	if(bCheckNew){
		sendJsonAjax("/cde/insCode.ajax", param, setDataCallBack);	
	}else{
		sendJsonAjax("/cde/updCode.ajax", param, setDataCallBack);
	}	
}

function setData02(){
	var bCheckNew = $("#NEW_CODE_DT").prop("checked");
	var param = new Map();	
	var validation = new Validation("divDetail02");
	
	if(!validation.check()){
		return false;
	}
	
	setAreaParamData(param, "divDetail02");
	
	if(bCheckNew){
		sendJsonAjax("/cde/insCodeDetail.ajax", param, setDataDtCallBack);	
	}else{
		sendJsonAjax("/cde/updCodeDetail.ajax", param, setDataDtCallBack);
	}	
}

function setDataCallBack(json){
	alert("저장되었습니다.");
	getListCode();
}

function setDataDtCallBack(json){
	alert("저장되었습니다.");

	//코드상세목록 조회
	var param = new Map();
	param.put("CD_SEC", $("#divDetail02 #CD_SEC").val());
	listBind02.controller("/cde/selCodeDetailList.ajax");	//컨트롤러 url (리스트 처리용)
	listBind02.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind02.sendAjax();	//컨트롤러 호출		
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
					<div class="col-lg-6">
						<h3>코드종류
							<span class="fr">
								<button class="btn btn-sm btn-default" onclick="initForm('divSearch');">초기화</button>
								<button class="btn btn-sm btn-info" onclick="getListCode();">조회</button>
							</span>
						</h3>
						
						<table id="divSearch" class="table table-bordered table-condensed">
							<tr>
								<th width="15%">코드섹션</th>
								<td width="35%"><input type="text" id="CD_SEC" name="CD_SEC" class="form-control input-sm" value="" /></td>
								<th width="15%">코드명</th>
								<td width="35%"><input type="text" id="CD_SEC_NAME" name="CD_SEC_NAME" class="form-control input-sm" value="" /></td>
							</tr>						
						</table>		
									
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="20%">코드섹션</th>
									<th width="40%">코드섹션명</th>
									<th width="40%">코드섹션설명</th>
								</tr>
							</thead>
							<tbody id="gridList01">
								<tr class="curser-pointer">
									<td>{CD_SEC}</td>
									<td>{CD_SEC_NAME}</td>
									<td>{CD_SEC_DESC}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo01"></div>
					</div>
					
					<div class="col-lg-6">
						<h3>코드정보
							<span class="fr">
								<input type="checkbox" id="NEW_CODE" name="NEW_CODE" /><label for="NEW_CODE" class="h5 curser-pointer">신규등록</label>
								<input type="button" class="btn btn-sm btn-primary" value="저장" onclick="setData01();"/>
							</span>
						</h3>
						
						<div id="divDetail01">
							<table class="table table-bordered">
							<tr>
								<th width="25%">코드섹션</th>
								<td width="75%"><input type="text" id="CD_SEC" name="CD_SEC" data-label="코드섹션" data-required="requird" maxlength="6" class="form-control input-sm" value="" readonly="readonly"/></td>
							</tr>
							<tr>
								<th width="25%">코드섹션명</th>
								<td width="75%"><input type="text" id="CD_SEC_NAME" name="CD_SEC_NAME" data-label="코드섹션명" data-required="requird" class="form-control input-sm" value="" /></td>
							</tr>
							<tr>
								<th width="25%">코드설명</th>
								<td width="75%"><input type="text" id="CD_SEC_DESC" name="CD_SEC_DESC" class="form-control input-sm" value="" /></td>
							</tr>																			
							</table>	
						</div>			
								
					</div>
		
				</div>
		
				<div class="row">
					<div class="col-lg-6">
						<h3>코드상세목록</h3>
									
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="20%">코드키</th>
									<th width="40%">코드값</th>
									<th width="40%">코드설명</th>
								</tr>
							</thead>
							<tbody id="gridList02">
								<tr class="curser-pointer">
									<td>{CD_KEY}</td>
									<td>{CD_VALUE}</td>
									<td>{CD_DESC}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo02"></div>	
					</div>
					
					<div class="col-lg-6">
						<h3>코드상세정보
							<span class="fr">
								<input type="checkbox" id="NEW_CODE_DT" name="NEW_CODE_DT" /><label for="NEW_CODE_DT" class="h5 curser-pointer">신규등록</label>
								<input type="button" class="btn btn-sm btn-primary" value="저장" onclick="setData02();"/>
							</span>
						</h3>
						
						<div id="divDetail02">
							<table class="table table-bordered">
							<tr>
								<th width="25%">코드섹션</th>
								<td width="75%"><input type="text" id="CD_SEC" name="CD_SEC" data-label="코드섹션" data-required="requird" maxlength="6" class="form-control input-sm" value="" readonly="readonly" /></td>
							</tr>
							<tr>
								<th width="25%">코드키</th>
								<td width="75%"><input type="text" id="CD_KEY" name="CD_KEY" data-label="코드키" data-required="requird" maxlength="6" class="form-control input-sm" value="" readonly="readonly"/></td>
							</tr>
							<tr>
								<th width="25%">코드값</th>
								<td width="75%"><input type="text" id="CD_VALUE" name="CD_VALUE" data-label="코드값" data-required="requird" maxlength="100" class="form-control input-sm" value="" /></td>
							</tr>
																														<tr>
								<th width="25%">코드설명</th>
								<td width="75%"><input type="text" id="CD_DESC" name="CD_DESC" class="form-control input-sm" value="" /></td>
							</tr>
							</table>	
						</div>
							
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