<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시글관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var editor;
var listBind01 = new ListBind("gridList01", true);
var listBind02 = new ListBind("gridList02", false);
var listBind03 = new ListBind("gridList03", false);
var comboBind = new ComboBind("BRD_KINDCD");

$(document).ready(function() {
	getDataList();
	comboBind.setComboName("BRD_KINDCD");
	comboBind.setCodeSection("CD003");	
	editor = new Editor({"id":"CONTENTS", "toolbar":true, "mode":true, "vertical":true});
	
	$("#NEW_DATA").on("click", setNewCheck);
	$("#gridList01").on("click","tr", getDetail);
	
	$('#divTab a:first').tab('show');
	$('#divTab a').click(function (e) {
		e.preventDefault();
		$(this).tab('show');
	});	
	
	//첨부파일 + 버튼 클릭
	var divFileForm = $("#divFileForm").html();
	$("#btn_file_plus").on("click", function(){
		$("#divFileForm").append(divFileForm);
	});
		
	//첨부파일 - 버튼 클릭
	$("#divFileForm").on("click", ".glyphicon-minus", function(){
		$(this).parent().remove();
	});
	
	//댓글 수정 클릭
	$("#gridList02").on("click", ".glyphicon-pencil", function( event ) {					
		var idx = $(".glyphicon-pencil").index(this);
		listBind02.rowEdit(idx);			
	});
	
	//댓글 저장 클릭
	$("#gridList02").on("click", ".glyphicon-floppy-disk", function( event ) {
		
		if(!confirm("댓글을 저장하시겠습니까?")){
			return false;
		}
		
		var idx = $(".glyphicon-floppy-disk").index(this);			
		var param = new Map();
		param.setJson(listBind02.rowSave(idx));
		sendJsonAjax("/common/brd/update/updBrd03.ajax", param, replySaveCallBack);
	});	
	
	//댓글 삭제 클릭
	$("#gridList02").on("click", ".glyphicon-remove", function( event ) {			
		
		if(!confirm("댓글을 삭제하시겠습니까?")){
			return false;
		}
		
		var idx = $(".glyphicon-remove").index(this);
		var param = new Map();
		param.setJson(listBind02.rowIdxData(idx));
		sendJsonAjax("/common/brd/delete/delBrd03.ajax", param, replySaveCallBack);	//업데이트 컨트롤러 호출.
	});
	
	//기존에 등록된 첨부파일 삭제
	$("#gridList03").on("click", ".glyphicon-minus", function(){
		var idx = $(".glyphicon-minus").index(this);
		listBind03.rowDeleteIndex(idx);
	});
	
	//저장버튼 클릭시 유효성검사
	var validation = new Validation("MyForm");	
	$("#MyForm").submit(function(){	
		if(!validation.check()){	
			return false;	
		}
	});		
});

function setNewCheck(){
	if($(this).prop("checked")){
		listBind03.clear();
		initForm('divDetail');
		editor.clear();
		$(this).prop("checked", true);
	}
}

function inputFileName(){
	$("input[type='file']").each(function(i){
		var inputName = $(this).attr("name");
		$(this).attr("name",inputName+i);
	});
}

function replySaveCallBack(json){
	alert("처리되었습니다.");
	listBind02.sendAjax();
}


function getDataList(){
	var param = new Map();	//파라메터 변수
	
	//divSearch영역의 폼태그의 value값을 읽어와 파라메터를 생성한다.		
	setAreaParamData(param, "divSearch");
	
	listBind01.controller("/brd/selBrdPaging.ajax");	//컨트롤러 url
	listBind01.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind01.setRowCount(10);	//그리드에 보여줄 row의 수 (기본 :10)
	listBind01.setPageId("divPage");	// 페이징 보여줄 태그 id
	listBind01.setGridPageInfo("divGridInfo01"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind01.sendAjax();	//컨트롤러 호출
}

function getDetail(){
	var row = listBind01.rowIdxData($(this).index()); //그리드의 ROW값
	jsonAutoMapping(row, "divDetail");
	editor.clear();
	editor.pasteHtml(row.BRD_CONTENTS);
	$("#NEW_DATA").prop("checked", false);
	
	var param = new Map();
	param.put("BRD_SEQ", row.BRD_SEQ);
	
	//댓글 목록 조회
	listBind02.setParam(param);	
	listBind02.controller("/brd/selBrdReplyList.ajax");
	listBind02.setHeaderFix(true, 400);
	listBind02.setGridPageInfo("divGridInfo02");
	listBind02.sendAjax();
	
	//첨부파일 목록  조회
	listBind03.setParam(param);	
	listBind03.controller("/brd/selBrdAttachList.ajax");
	listBind03.sendAjax();	
	
	
}

function setData(){
	if(!confirm("게시글을 저장하시겠습니까?")){
		return false;
	}
	
	inputFileName(); //input file name 재정의	
	var param = new Map();
	setAreaParamData(param, "divDetail");
	param.put("BRD_CONTENTS", editor.getContents());
	param.put("FILE_LIST", listBind03.getJsonStringData());	
	sendFormAjax("MyForm", param, "/brd/insBrd01.fileup", setDataCallBack);	
}

function setDataCallBack(){
	alert("처리되었습니다.");
	initForm('divDetail');
	listBind03.clear();
	editor.clear();
	getDataList();	
}

function setDelete(){
	if(!confirm("게시글을 삭제하시겠습니까?")){
		return false;
	}
	
	var param = new Map();
	param.put("BRD_SEQ", $("#BRD_SEQ").val());
	sendJsonAjax("/brd/delBrd01.ajax", param, setDataCallBack);	//업데이트 컨트롤러 호출.
}

function setReplayData(){
	var param = new Map();
	
	var brd_seq = $("#BRD_SEQ").val();
	var contents = $("#RP_CONTENTS").val();
	
	if(brd_seq == ""){
		alert("게시글을 선택해 주세요.");
		return false;
	}
	
	if(contents == ""){
		alert("댓글내용을 입력해주세요.");
		return false;
	}
	
	param.put("BRD_SEQ", brd_seq);
	param.put("RP_CONTENTS", contents);
	
	sendJsonAjax("/common/brd/insert/insBrd03.ajax", param, setReplayDataCallBack);
}

function setReplayDataCallBack(json){
	alert("등록되었습니다.");
	
	listBind02.sendAjax();	
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
						<h3>게시글 목록
							<span class="fr">
								<button class="btn btn-sm btn-default" onclick="initForm('divSearch');">초기화</button>
								<input type="button" class="btn btn-sm btn-info" value="조회" onclick="getDataList();"/>
							</span>
						</h3>
						
						<table id="divSearch" class="table table-bordered table-condensed">
							<tr>
								<th width="15%">게시판종류</th>
								<td width="35%">
									<select id="BRD_KINDCD" name="BRD_KINDCD" class="form-control input-sm">
									</select>
								</td>
								<th width="15%">제목</th>
								<td width="35%">
									<input type="text" id="BRD_SUBJECT" name="BRD_SUBJECT" class="form-control input-sm" value="" />
								</td>
							</tr>
							<tr>
								<th width="15%">글내용</th>
								<td width="35%">
									<input type="text" id="BRD_CONTENTS" name="BRD_CONTENTS" class="form-control input-sm" value="" />
								</td>
								<th width="15%">사용자</th>
								<td width="35%">
									<input type="text" id="INS_ID" name="INS_ID" class="form-control input-sm" value="" />
								</td>
							</tr>													
						</table>		
									
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="60%">제목</th>						
									<th width="20%">게시판명</th>
									<th width="20%">사용자</th>
								</tr>
							</thead>
							<tbody id="gridList01">
								<tr class="curser-pointer">
									<td>{BRD_SUBJECT}</td>
									<td>{BRD_KINDCD_NM}</td>
									<td>{INS_ID}</td>
								</tr>
							</tbody>
						</table>	
						<div id="divGridInfo01"></div>
						<div id="divPage" class="form-inline text-center"></div>	
					</div>
		
					<div class="col-lg-6">
						
						<ul id="divTab" class="nav nav-tabs nav-justified">
							  <li role="presentation"><a href="#divDetail" aria-controls="divDetail" role="tab">게시글</a></li>
							  <li role="presentation"><a href="#divReply" aria-controls="divReply" role="tab">댓글</a></li>
						</ul>	
								
						<div class="tab-content">
						
							<div id="divDetail" role="tabpanel" class="tab-pane">
								<form enctype="multipart/form-data" id="MyForm" name="MyForm" method="post">
									<h4></h4>
									<div>
										<span class="fr">
											<input type="checkbox" id="NEW_DATA" name="NEW_DATA" /><label for="NEW_DATA" class="h5 curser-pointer">신규등록</label>							
										</span>							
									</div>
									<table class="table table-bordered">
									<tr>
										<th width="20%">사용자</th>
										<td width="30%">
											<input type="hidden" id="BRD_SEQ" name="BRD_SEQ" value="" />
											<input type="text" id="INS_ID" name="INS_ID" class="form-control input-sm" value="" readonly />
										</td>
										<th width="20%">등록일자</th>
										<td width="30%">
											<span id="INS_DATE"></span>
										</td>					
									</tr>				
									<tr>
										<th>제목</th>
										<td colspan="3">
											<input type="text" id="BRD_SUBJECT" name="BRD_SUBJECT" data-label="제목" data-required="requird" class="form-control input-sm" value="" />
										</td>
									</tr>
									<tr>
										<th>게시판종류</th>
										<td colspan="3">
											<select id="BRD_KINDCD" name="BRD_KINDCD" class="form-control input-sm" data-label="게시판종류" data-required="requird">
											</select>						
										</td>
									</tr>
									<tr>
										<th>
											첨부파일
											<span id="btn_file_plus" style="cursor: pointer;" class="glyphicon glyphicon-plus"></span>
										</th>
										<td colspan="3">
											<ul id="gridList03">
												<li>
													<a href="/download.do?uuid={FILE_UUID}&name={FILE_ORI_NAME}">{FILE_ORI_NAME}</a>
													<span style="cursor: pointer;" class="glyphicon glyphicon-minus"></span>
												</li>
											</ul>
											<div id="divFileForm">
												<div>
													<input type="file" name="fileUp" class="fl" />&nbsp;
													<span style="cursor: pointer;" class="glyphicon glyphicon-minus"></span>
												</div>
											</div>
										</td>
									</tr>				
									<tr>
										<td colspan="4">
											<textarea name="CONTENTS" id="CONTENTS" rows="10" class="form-control input-sm" style="display:none;"></textarea>
										</td>
									</tr>																	
									</table>	
									<div class="text-center">
										<input type="submit" value="저장" class="btn btn-primary btn-sm" onclick="setData();" />
										<button class="btn btn-sm btn-danger" onclick="setDelete()">삭제</button>
									</div>
								</form>			
							</div>
							
							<div id="divReply" role="tabpanel" class="tab-pane">
								<h4></h4>
							 	<table class="table table-hover table-condensed table-striped">
									<thead>
										<tr>
											<th width="50%">내용</th>						
											<th width="20%">등록일자</th>
											<th width="15%">사용자</th>
											<th width="15%"></th>						
										</tr>
									</thead>
									<tbody id="gridList02">
										<tr>
											<td data-input="text" data-class="form-control input-sm" data-column="RP_CONTENTS">{RP_CONTENTS}</td>
											<td>{INS_DATE}</td>
											<td>{INS_ID}</td>
											<td>
												<span style="cursor: pointer;" class="glyphicon glyphicon-pencil"></span>
												<span style="cursor: pointer;" class="glyphicon glyphicon-floppy-disk"></span>
												<span style="cursor: pointer;" class="glyphicon glyphicon-remove"></span>									
											</td>						
										</tr>
									</tbody>
								</table>	
								<div id="divGridInfo02"></div>	
								
								<table class="table table-bordered table-condensed">
									<tr>								
										<td width="90%">
											<input type="text" id="RP_CONTENTS" name="RP_CONTENTS" data-label="댓글" data-required="requird" class="form-control input-sm" value="" />
										</td>
										<td>
											<button class="btn btn-sm btn-info" onclick="setReplayData();">등록</button>
										</td>						
									</tr>
								</table>		
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