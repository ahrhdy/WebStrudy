<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>도움말 관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var editor;
var listBind = new ListBind("gridList", false);

$(document).ready(function() {
	getDataList();
	
	editor = new Editor({"id":"CONTENTS", "toolbar":true, "mode":true, "vertical":true});

	$("#gridList").on("click","tr", getDetail);
});

function getDataList(){
	var param = new Map();	//파라메터 변수

	listBind.controller("/hlp/selPgmList.ajax");	//컨트롤러 url
	listBind.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind.setHeaderFix(true);
	listBind.setGridPageInfo("divGridInfo"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind.sendAjax();	//컨트롤러 호출
}

function getDetail(){
	initForm("divDetail");
	var row = listBind.rowIdxData($(this).index()); //그리드의 ROW값
	jsonAutoMapping(row, "divDetail");
	editor.clear();
	editor.pasteHtml(row.CONTENTS);
}

function setData(){
	var param = new Map();	
	var validation = new Validation("divDetail");
	
	if(!validation.check()){
		return false;
	}
	
	param.put("PGM_ID", $("#PGM_ID").val());
	param.put("CONTENTS", editor.getContents());
	sendJsonAjax("/hlp/insHlp.ajax", param, setDataCallBack);	
}

function setDataCallBack(json){
	alert("저장되었습니다.");
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
		
					<div class="col-lg-4">
						<h3>도움말 관리</h3>
								
						<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="30%">프로그램ID</th>
									<th width="50%">프로그램명</th>
									<th width="20%">작성여부</th>
								</tr>
							</thead>
							<tbody id="gridList">
								<tr style="cursor:pointer;">
									<td>{PGM_ID}</td>
									<td>{PGM_NAME}</td>
									<td>{PGM_YN}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo"></div>
					</div>		
					
					<div class="col-lg-8">
						<h3>도움말 입력</h3>		
						<div id="divDetail">
							<table class="table table-bordered">
								<tr>
									<th width="15%">프로그램ID</th>
									<td width="25%">																		
										<input type="text" id="PGM_ID" name="PGM_ID" data-label="프로그램ID" data-required="requird" class="form-control input-sm" value="" readonly />
									</td>
									<th width="15%">프로그램명</th>
									<td width="55%" id="PGM_NAME"></td>					
								</tr>
								<tr>
									<td colspan="4">
										<textarea name="CONTENTS" id="CONTENTS" rows="10" cols="100" style="display:none;"></textarea>					
									</td>
								</tr>
							</table>		
						</div>
						<div class="form-inline text-center">
							<button class="btn btn-sm btn-primary" onclick="setData();">저장</button>			
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