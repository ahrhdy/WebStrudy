<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>샘플 소스 관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var editor;
var listBind = new ListBind("gridList", false);

$(document).ready(function() {
	getDataList();
	
	editor = new Editor({"id":"CONTENTS", "toolbar":true, "mode":true, "vertical":true});

	$("#gridList").on("click","tr", getDetail);
	$("#NEW_DATA").on("click", setSampleCheck);
});

function setSampleCheck(){
	var $url = $("#URL");
	
	if($(this).prop("checked")){
		$url.prop("readonly", false);
		initForm('divDetail');
	}else{
		$url.prop("readonly", true);
	}
}

function getDataList(){
	var param = new Map();	//파라메터 변수

	listBind.controller("/common/smp/list/selSampleList.ajax");	//컨트롤러 url
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
	editor.pasteHtml(row.SOURCE);
}

function setData(){
	var bCheckNew = $("#NEW_DATA").prop("checked");
	var param = new Map();	
	var validation = new Validation("divDetail");
	
	if(!validation.check()){
		return false;
	}
	
	param.put("URL", $("#URL").val());
	param.put("SAMPLE_NAME", $("#SAMPLE_NAME").val());
	param.put("SOURCE", editor.getContents());
	
	if(bCheckNew){
		sendJsonAjax("/common/smp/insert/insSample.ajax", param, setDataCallBack);		
	}else{
		sendJsonAjax("/common/smp/update/updSample.ajax", param, setDataCallBack);
	}	
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
						<h3>샘플소스 관리</h3>
								
						<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="100%">샘플소스명</th>
								</tr>
							</thead>
							<tbody id="gridList">
								<tr style="cursor:pointer;">
									<td>{SAMPLE_NAME}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo"></div>
					</div>		
					
					<div class="col-lg-8">
						<h3>소스코드 입력
							<span class="fr">
								<input type="checkbox" id="NEW_DATA" name="NEW_DATA" /><label for="NEW_DATA" class="h5 curser-pointer">신규등록</label>
								<button class="btn btn-sm btn-primary" onclick="setData();">저장</button>
							</span>			
						</h3>		
						<div id="divDetail">
							<table class="table table-bordered">
								<tr>
									<th width="15%">샘플소스명</th>
									<td width="25%">																		
										<input type="text" id="SAMPLE_NAME" name="SAMPLE_NAME" data-label="샘플소스명" data-required="requird" class="form-control input-sm" value="" />
									</td>
									<th width="15%">샘플소스URL</th>
									<td width="55%">
										<input type="text" id="URL" name="URL" data-label="샘플소스URL" data-required="requird" class="form-control input-sm" value="" readonly />
									</td>					
								</tr>
								<tr>
									<td colspan="4">
										<textarea name="CONTENTS" id="CONTENTS" rows="10" cols="100" style="display:none;"></textarea>					
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