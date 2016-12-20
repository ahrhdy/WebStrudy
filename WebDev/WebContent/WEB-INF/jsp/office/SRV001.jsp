<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>설문조사관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind01 = new ListBind("gridList01", false);
var listBind02 = new ListBind("gridList02", false);
var listBind03 = new ListBind("gridList03", false);
var comboBind = new ComboBind("SRV_KINDCD");

$(document).ready(function() {	
	getDataList();
	comboBind.setCodeSection("CD006");		
	
	$('#divTab a:first').tab('show');
	$('#divTab a').click(function (e) {
		e.preventDefault();
		$(this).tab('show');
	});	
	
	$("#gridList01").on("click","tr", getDetail01);
	$("#gridList02").on("click","tr", getDetail02);
	
	//보기 수정 클릭
	$("#gridList03").on("click", ".glyphicon-pencil", function( event ) {					
		var idx = $(".glyphicon-pencil").index(this);
		listBind03.rowEdit(idx);			
	});
	
	//보기 저장 클릭
	$("#gridList03").on("click", ".glyphicon-floppy-disk", function( event ) {
		
		if(!confirm("보기내용을 저장하시겠습니까?")){
			return false;
		}
		
		var idx = $(".glyphicon-floppy-disk").index(this);			
		var param = new Map();
		param.setJson(listBind03.rowSave(idx));
		sendJsonAjax("/common/brd/update/updBrd03.ajax", param, replySaveCallBack);
	});	
	
	//보기 삭제 클릭
	$("#gridList03").on("click", ".glyphicon-remove", function( event ) {			
		
		if(!confirm("보기를 삭제하시겠습니까?")){
			return false;
		}
		
		var idx = $(".glyphicon-remove").index(this);
		var param = new Map();
		param.setJson(listBind03.rowIdxData(idx));
		sendJsonAjax("/common/brd/delete/delBrd03.ajax", param, replySaveCallBack);	//업데이트 컨트롤러 호출.
	});	
});

function getDataList(){
	var param = new Map();	//파라메터 변수
	
	listBind01.controller("/common/srv/list/selSrvList.ajax");	//컨트롤러 url
	listBind01.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind01.setHeaderFix(true, 150);
	listBind01.setGridPageInfo("divGridInfo01"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind01.sendAjax();	//컨트롤러 호출
}

function getDetail01(){
	initForm("divDetail");
	var row = listBind01.rowIdxData($(this).index()); //그리드의 ROW값
	jsonAutoMapping(row, "divDetail");
	
	var param = new Map();	//파라메터 변수	
	param.put("SRV_SEQ", row.SRV_SEQ);
	listBind02.controller("/common/srv/list/selSrv02List.ajax");	//컨트롤러 url
	listBind02.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind02.setHeaderFix(true, 330);
	listBind02.setGridPageInfo("divGridInfo02"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind02.sendAjax();	//컨트롤러 호출	
}

function getDetail02(){
	initForm("divSrvList");
	var row = listBind02.rowIdxData($(this).index()); //그리드의 ROW값
	jsonAutoMapping(row, "divSrvList");
	
	var param = new Map();	//파라메터 변수	
	param.put("SRV_SEQ", row.SRV_SEQ);
	param.put("QUE_SER", row.QUE_SER);
	listBind03.controller("/common/srv/list/selSrv03List.ajax");	//컨트롤러 url
	listBind03.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind03.setHeaderFix(true, 120);
	listBind03.setGridPageInfo("divGridInfo02"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind03.sendAjax();	//컨트롤러 호출
}

function setData(){
	var param = new Map();	
	var validation = new Validation("divDetail");
	
	if(!validation.check()){
		return false;
	}
	
	setAreaParamData(param, "divDetail");
	sendJsonAjax("/common/srv/insert/insSrv01.ajax", param, setDataCallBack);	
}

function setData02(){
	var param = new Map();	
	var validation = new Validation("divSrvList");
	
	if(!validation.check()){
		return false;
	}
	
	setAreaParamData(param, "divSrvList");
	param.put("SRV_SEQ", $("#SRV_SEQ").val());
	sendJsonAjax("/common/srv/insert/insSrv02.ajax", param, setDataCallBack);	
}

function setData03(){
	var param = new Map();	
	var validation = new Validation("divSrvList");
	
	if(!validation.check()){
		return false;
	}
	
	setAreaParamData(param, "divSrvList");
	param.put("SRV_SEQ", $("#SRV_SEQ").val());
	param.put("QUE_SER", $("#QUE_SER").val());
	sendJsonAjax("/common/srv/insert/insSrv03.ajax", param, setDataCallBack);	
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
                
					<div class="col-lg-5">
						<h3>설문조사목록</h3>
									
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="50%">제목</th>
									<th width="25%">시작일자</th>
									<th width="25%">종료일자</th>
								</tr>
							</thead>
							<tbody id="gridList01">
								<tr class="curser-pointer">
									<td>{SRV_NAME}</td>
									<td>{VW_ST_DAY}</td>
									<td>{VW_ED_DAY}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo01"></div>			
					</div>
					
					<div class="col-lg-7">
						<h3>설문조사정보 입력</h3>
						
						<div id="divDetail">
							<table class="table table-bordered">
							<tr>
								<th>제목</th>
								<td colspan="3">
									<input type="hidden" id="SRV_SEQ" name="SRV_SEQ" value="" />
									<input type="text" id="SRV_NAME" name="SRV_NAME" data-label="제목" data-required="requird" class="form-control input-sm" value="" />
								</td>
							</tr>
							<tr>
								<th>시작일자</th>
								<td>
									<input type="text" id="VW_ST_DAY" name="VW_ST_DAY" data-datepicker="yy-mm-dd" data-label="시작일자" data-required="requird dateFormat:yyyy-mm-dd" class="form-control input-sm" value="" />
								</td>
								<th>종료일자</th>
								<td>
									<input type="text" id="VW_ED_DAY" name="VW_ED_DAY" data-datepicker="yy-mm-dd" data-label="종료일자" data-required="requird dateFormat:yyyy-mm-dd" class="form-control input-sm" value="" />
								</td>					
							</tr>				
							<tr>
								<th>사용유무</th>
								<td colspan="3">
									<input type="radio" id="USE_YN" name="USE_YN" data-label="사용여부" data-required="requird" value="Y" />예 
									<input type="radio" name="USE_YN" value="N" />아니오						
								</td>					
							</tr>																				
							</table>	
							<div class="text-center">
								<button class="btn btn-sm btn-primary" onclick="setData();">저장</button>					
							</div>				
						</div>			
			
					</div>
				</div>

				<div class="row">
		
					<div class="col-lg-12">
						<ul id="divTab" class="nav nav-tabs nav-justified">
							  <li role="presentation"><a href="#divSrvList" aria-controls="divSrvList" role="tab">설문조사 항목 관리</a></li>
							  <li role="presentation"><a href="#divSrvChart" aria-controls="divSrvChart" role="tab">설문조사 통계</a></li>
						</ul>	
								
						<div class="tab-content">
							<div id="divSrvList" role="tabpanel" class="tab-pane">
							
								<div class="col-md-5">
								<h4 class="page-header"></h4>
							 	<table class="table table-hover table-condensed table-striped">
									<thead>
										<tr>
											<th width="30%">질문종류</th>
											<th width="70%">질문내용</th>
										</tr>
									</thead>
									<tbody id="gridList02">
										<tr class="curser-pointer">
											<td>{SRV_KINDCD_NM}</td>
											<td>{SRV_CONTENTS}</td>
										</tr>
									</tbody>
								</table>
								<div id="divGridInfo02"></div>	
												
								</div>
								
								<div class="col-md-7">
								<h4 class="page-header"></h4>
								<table class="table table-bordered">
								<tr>
									<th>질문제목</th>
									<td>
										<input type="hidden" id="QUE_SER" name="QUE_SER" value="" />
										<input type="text" id="SRV_CONTENTS" name="SRV_CONTENTS" data-label="제목" data-required="requird" class="form-control input-sm" value="" />
									</td>
								</tr>				
								<tr>
									<th>질문종류</th>						
									<td>
										<select id="SRV_KINDCD" name="SRV_KINDCD" class="form-control input-sm" data-label="질문종류" data-required="requird">
										</select>								
									</td>					
								</tr>																				
								</table>
								<div class="text-center">
									<button class="btn btn-sm btn-primary" onclick="setData02();">저장</button>					
								</div>						
								
								<h4 class="page-header"></h4>
							 	<table class="table table-hover table-condensed table-striped">
									<thead>
										<tr>
											<th width="75%">내용</th>						
											<th width="25%"></th>						
										</tr>
									</thead>
									<tbody id="gridList03">
										<tr>
											<td data-input="text" data-class="form-control input-sm" data-column="QUE_CONTENTS">{QUE_CONTENTS}</td>
											<td>
												<span style="cursor: pointer;" class="glyphicon glyphicon-pencil"></span>
												<span style="cursor: pointer;" class="glyphicon glyphicon-floppy-disk"></span>
												<span style="cursor: pointer;" class="glyphicon glyphicon-remove"></span>									
											</td>						
										</tr>
									</tbody>
								</table>
								
								<table class="table table-bordered table-condensed">
									<tr>								
										<td width="90%">
											<input type="text" id="QUE_CONTENTS" name="QUE_CONTENTS" data-label="보기내용" data-required="requird" class="form-control input-sm" value="" />
										</td>
										<td>
											<button class="btn btn-sm btn-info" onclick="setData03();">등록</button>
										</td>						
									</tr>
								</table>
													
								</div>
							
							</div>
							
							<div id="divSrvChart" role="tabpanel" class="tab-pane">
							
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