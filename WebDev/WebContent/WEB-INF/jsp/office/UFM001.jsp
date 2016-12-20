<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>업로드파일관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", true);
var listBind02 = new ListBind("gridList02", false);

$(document).ready(function() {	
	getDataList();	
	getFileNotExistList();
	
	$("#gridList").on("click","tr", getDetail);
	
	$('#divTab a:first').tab('show');
	$('#divTab a').click(function (e) {
		e.preventDefault();
		$(this).tab('show');		
	});		
});


function getDataList(){
	var param = new Map();	//파라메터 변수
	
	//divSearch영역의 폼태그의 value값을 읽어와 파라메터를 생성한다.		
	setAreaParamData(param, "divSearch");
	
	listBind.controller("/common/ufm/paging/selUfmPaging.ajax");	//컨트롤러 url
	listBind.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind.setRowCount(10);	//그리드에 보여줄 row의 수 (기본 :10)
	listBind.setPageId("divPage");	// 페이징 보여줄 태그 id
	listBind.setGridPageInfo("divGridInfo"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind.sendAjax();	//컨트롤러 호출
}

function getDetail(){
	var row = listBind.rowIdxData($(this).index()); //그리드의 ROW값
	jsonAutoMapping(row, "divDetail");
	
	var param = new Map();
	param.put("FILE_UUID", row.FILE_UUID);
	sendJsonAjax("/ufm/selFileExist.ajax", param, getDetailCallBack);
}

function getDetailCallBack(json){	
	var fileHtml = "";
	if(json.data.FILE_EXIST == "Y"){
		fileHtml = "<a href=\"/ufm/Download.do?uuid="+json.data.FILE_UUID+" \">[ <span class=\"glyphicon glyphicon-ok\"></span>다운로드 ]</a>";
	}else{
		fileHtml = "<a href=\"javascript:setDelete('"+json.data.FILE_UUID+"');\">[ <span class=\"glyphicon glyphicon-remove\"></span>정보삭제 ]</a>";
	}
	
	$("#FILE_EXIST").html(fileHtml);
}

function setDelete(fileUUid){	
	
	if(confirm("파일정보를 삭제하시겠습니까?")){
		
		var param = new Map();
		param.put("FILE_UUID", fileUUid);
		sendJsonAjax("/ufm/delUfm01.ajax", param, setDeleteCallBack);
	}	

}

function setDeleteCallBack(json){
	alert("삭제처리 되었습니다.");
	initForm('divDetail');
	$("#FILE_EXIST").html("");
	getDataList();
}

function getFileNotExistList(){
	var param = new Map();	//파라메터 변수

	listBind02.controller("/common/ufm/list/selUfmScheduleList.ajax");	//컨트롤러 url
	listBind02.setHeaderFix(true);
	listBind02.setParam(param);	//컨트롤러로 넘길 조회 파라메터	
	listBind02.setGridPageInfo("divGridInfo02"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
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
						<h3>업로드파일목록
							<span class="fr">
								<button class="btn btn-sm btn-default" onclick="initForm('divSearch');">초기화</button>
								<input type="button" class="btn btn-sm btn-info" value="조회" onclick="getDataList();"/>
							</span>
						</h3>
						
						<table id="divSearch" class="table table-bordered table-condensed">
							<tr>
								<th width="15%">UUID</th>
								<td width="35%"><input type="text" id="FILE_UUID" name="FILE_UUID" class="form-control input-sm" value="" /></td>
								<th width="15%">파일명</th>
								<td width="35%"><input type="text" id="FILE_ORI_NAME" name="FILE_ORI_NAME" class="form-control input-sm" value="" /></td>
							</tr>										
						</table>		
									
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="40%">FILE_UUID</th>
									<th width="40%">파일명</th>
									<th width="20%">등록일자</th>
								</tr>
							</thead>
							<tbody id="gridList">
								<tr class="curser-pointer">
									<td>{FILE_UUID}</td>
									<td>{FILE_ORI_NAME}</td>
									<td>{INS_DATE}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo"></div>
						<div id="divPage" class="form-inline text-center"></div>	
					</div>
					
					<div class="col-lg-6">
					
						<ul id="divTab" class="nav nav-tabs nav-justified">
							  <li role="presentation"><a href="#divDetail" aria-controls="divDetail" role="tab">파일상세정보</a></li>
							  <li role="presentation"><a href="#divExist" aria-controls="divExist" role="tab">파일미존재목록</a></li>
						</ul>
						
						<div class="tab-content">
							<div id="divDetail" role="tabpanel" class="tab-pane">
								<h4 class="page-header"></h4>
								<table class="table table-bordered">
								<tr>
									<th width="25%">FILE_UUID</th>
									<td width="75%">
										<input type="text" id="FILE_UUID" name="FILE_UUID" class="form-control input-sm" value="" readonly />
									</td>
								</tr>
								<tr>
									<th>FILE_ORI_NAME</th>
									<td>
										<input type="text" id="FILE_ORI_NAME" name="FILE_ORI_NAME" class="form-control input-sm" value="" readonly />
									</td>
								</tr>
								<tr>
									<th>FILE_SIZE</th>
									<td>
										<input type="text" id="FILE_SIZE" name="FILE_SIZE" class="form-control input-sm" value="" readonly />
									</td>
								</tr>
								<tr>
									<th>FILE_PATH</th>
									<td>
										<input type="text" id="FILE_PATH" name="FILE_PATH" class="form-control input-sm" value="" readonly />
									</td>
								</tr>
								<tr>
									<th>등록일자</th>
									<td>
										<input type="text" id="INS_DATE" name="INS_DATE" class="form-control input-sm" value="" readonly />
									</td>
								</tr>
								<tr>
									<th>사용자ID</th>
									<td>
										<input type="text" id="INS_ID" name="INS_ID" class="form-control input-sm" value="" readonly />
									</td>
								</tr>
								<tr>
									<th>물리적파일 존재여부</th>
									<td id="FILE_EXIST">
									</td>
								</tr>				
								</table>			
							</div>
							
							<div id="divExist" role="tabpanel" class="tab-pane">
								<h4 class="page-header"></h4>
								
							 	<table class="table table-hover table-condensed table-striped">
									<thead>
										<tr>
											<th width="50%">FILE_UUID</th>
											<th width="30%">파일명</th>
											<th width="20%">등록일자</th>
										</tr>
									</thead>
									<tbody id="gridList02">
										<tr class="curser-pointer">
											<td>{FILE_UUID}</td>
											<td>{FILE_ORI_NAME}</td>
											<td>{INS_DATE}</td>
										</tr>						
									</tbody>
								</table>	
								<div id="divGridInfo02"></div>						
							</div>
						
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