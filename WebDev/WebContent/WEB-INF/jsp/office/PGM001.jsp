<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>프로그램화면관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);
$(document).ready(function() {
	getDataList();
	
	$("#gridList").on("click","tr", getDetail);	//사용자정보 그리드 row클릭 이벤트
	$("#NEW_DATA").on("click", setProgramCheck);
});

function setProgramCheck(){
	var $pgmId = $("#divDetail #PGM_ID");
	
	if($(this).prop("checked")){
		$pgmId.prop("readonly", false);
		initForm('divDetail');
	}else{
		$pgmId.prop("readonly", true);
	}
}

function getDataList(){
	var param = new Map();	//파라메터 변수
	
	//divSearch영역의 폼태그의 value값을 읽어와 파라메터를 생성한다.		
	setAreaParamData(param, "divSearch");
	
	listBind.controller("/pgm/selPgmList.ajax");	//컨트롤러 url
	listBind.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind.setHeaderFix(true);
	listBind.setGridPageInfo("divGridInfo"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind.sendAjax();	//컨트롤러 호출
}

function getDetail(){
	var row = listBind.rowIdxData($(this).index()); //그리드의 ROW값
	$("#divDetail #PGM_ID").prop("readonly", true);
	$("#NEW_DATA").prop("checked", false);
	jsonAutoMapping(row, "divDetail");	
}

function setData(){
	var bCheckNew = $("#NEW_DATA").prop("checked");
	var param = new Map();	
	var validation = new Validation("divDetail");
	
	if(!validation.check()){
		return false;
	}
	
	setAreaParamData(param, "divDetail");
	
	if(bCheckNew){
		sendJsonAjax("/pgm/insPgm.ajax", param, setDataCallBack);	
	}else{
		sendJsonAjax("/pgm/updPgm.ajax", param, setDataCallBack);
	}
}

function setDataCallBack(json){
	initForm('divDetail');
	alert("저장되었습니다.");
	getDataList();
}

function delData(){
	var param = new Map();	
	setAreaParamData(param, "divDetail");
	
	sendJsonAjax("/pgm/delPgm.ajax", param, delDataCallBack);
}

function delDataCallBack(json){
	initForm('divDetail');
	alert("삭제되었습니다.");
	getDataList();
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
						<h3>프로그램목록
							<span class="fr">
								<button class="btn btn-sm btn-default" onclick="initForm('divSearch');">초기화</button>
								<button class="btn btn-sm btn-info" onclick="getDataList();">조회</button>
							</span>
						</h3>
						
						<table id="divSearch" class="table table-bordered table-condensed">
							<tr>
								<th width="15%">프로그램ID</th>
								<td width="35%"><input type="text" id="PGM_ID" name="PGM_ID" class="form-control input-sm" value="" /></td>
								<th width="15%">프로그램명</th>
								<td width="35%"><input type="text" id="PGM_NAME" name="PGM_NAME" class="form-control input-sm" value="" /></td>
							</tr>										
						</table>		
									
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="20%">프로그램ID</th>
									<th width="60%">프로그램명</th>
									<th width="20%">사용여부</th>
								</tr>
							</thead>
							<tbody id="gridList">
								<tr class="curser-pointer">
									<td>{PGM_ID}</td>
									<td>{PGM_NAME}</td>
									<td>{USE_YN}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo"></div>	
					</div>
					
					<div class="col-lg-6">
						<h3>프로그램정보
							<span class="fr">
								<input type="checkbox" id="NEW_DATA" name="NEW_DATA" /><label for="NEW_DATA" class="h5 curser-pointer">신규등록</label>
								<button class="btn btn-sm btn-primary" onclick="setData();">저장</button>
								<button class="btn btn-sm btn-danger" onclick="delData();">삭제</button>
							</span>			
						</h3>
						
						<div id="divDetail">
							<table class="table table-bordered">
							<tr>
								<th width="25%">프로그램ID</th>
								<td width="75%"><input type="text" id="PGM_ID" name="PGM_ID" data-label="프로그램ID" data-required="requird" class="form-control input-sm" value="" readonly="readonly"/></td>
							</tr>
							<tr>
								<th>프로그램명</th>
								<td><input type="text" id="PGM_NAME" name="PGM_NAME" data-label="프로그램명" data-required="requird" class="form-control input-sm" value="" /></td>
							</tr>
							<tr>
								<th>URL</th>
								<td><input type="text" id="PGM_URL" name="PGM_URL" data-label="URL" data-required="requird" class="form-control input-sm" value="" /></td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td>
									<input type="radio" id="USE_YN" name="USE_YN" data-label="사용여부" data-required="requird" value="Y" />예 
									<input type="radio" name="USE_YN" value="N" />아니오					
								</td>
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