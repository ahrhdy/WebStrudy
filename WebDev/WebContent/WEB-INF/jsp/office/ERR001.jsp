<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>오류신고관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", true);
var comboBind = new ComboBind("ERR_KINDCD");

$(document).ready(function() {
	getDataList();
	comboBind.setCodeSection("CD001");
	
	$("#gridList").on("click","tr", getDetail);
	$("#CAP_IMG").on("click", function(){
		var img = $(this).attr("src");
		var imgTmp = new Image(); 
		imgTmp.src = img; 		
		var imgWin = window.open("","gImgWin","width="+imgTmp.width+",height="+imgTmp.height+",status=no,toolbar=no,scrollbars=no,resizable=no");
		imgWin.document.write("<html><title>미리보기</title>" 
			+"<body topmargin=0 leftmargin=0 marginheight=0 marginwidth=0>" 
			+"<a href='javascript:self.close()'><img src='"+img+"' width="+imgTmp.width+" height="+imgTmp.height+" border=0></a>" 
			+"</body></html>"); 		
	});
});


function getDataList(){
	var param = new Map();	//파라메터 변수
	
	//divSearch영역의 폼태그의 value값을 읽어와 파라메터를 생성한다.		
	setAreaParamData(param, "divSearch");
	
	listBind.controller("/common/err/paging/selErrList.ajax");	//컨트롤러 url
	listBind.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind.setRowCount(10);	//그리드에 보여줄 row의 수 (기본 :10)
	listBind.setPageId("divPage");	// 페이징 보여줄 태그 id
	listBind.setGridPageInfo("divGridInfo"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind.sendAjax();	//컨트롤러 호출
}

function getDetail(){
	var row = listBind.rowIdxData($(this).index()); //그리드의 ROW값
	$("#CAP_IMG").attr("src", row.FILE_UUID);
	jsonAutoMapping(row, "divDetail");	
}

function setData(){
	var param = new Map();	
	var validation = new Validation("divDetail");
	
	if(!validation.check()){
		return false;
	}
	
	setAreaParamData(param, "divDetail");
	sendJsonAjax("/common/err/update/updErr.ajax", param, setDataCallBack);	
}

function setDataCallBack(){
	alert("처리되었습니다.");
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
                
					<div class="col-lg-7">
						<h3>오류신고목록
							<span class="fr">
								<button class="btn btn-sm btn-default" onclick="initForm('divSearch');">초기화</button>
								<input type="button" class="btn btn-sm btn-info" value="조회" onclick="getDataList();"/>
							</span>
						</h3>
						
						<table id="divSearch" class="table table-bordered table-condensed">
							<tr>
								<th width="15%">오류종류</th>
								<td width="35%">
									<select id="ERR_KINDCD" name="ERR_KINDCD" class="form-control input-sm">
									</select>
								</td>
								<th width="15%">오류내용</th>
								<td width="35%">
									<input type="text" id="ERR_CONTENTS" name="ERR_CONTENTS" class="form-control input-sm" value="" />
								</td>
							</tr>
							<tr>
								<th width="15%">URL</th>
								<td width="35%">
									<input type="text" id="ERR_URL" name="ERR_URL" class="form-control input-sm" value="" />
								</td>
								<th width="15%">처리여부</th>
								<td width="35%">
									<select id="PROC_YN" name="PROC_YN" class="form-control input-sm">
										<option value="">전체</option>
										<option value="Y">처리</option>
										<option value="N">미처리</option>
									</select>					
								</td>
							</tr>													
						</table>		
									
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="50%">URL</th>						
									<th width="30%">오류내용</th>
									<th width="20%">오류종류</th>
								</tr>
							</thead>
							<tbody id="gridList">
								<tr class="curser-pointer">
									<td>{ERR_URL}</td>
									<td>{DISP_CONTENTS}</td>
									<td>{ERR_KINDVAL}</td>
								</tr>
							</tbody>
						</table>	
						<div id="divGridInfo"></div>
						<div id="divPage" class="form-inline text-center"></div>			
					</div>
					
					<div class="col-lg-5">
						<h3>오류상세정보</h3>
						
						<div id="divDetail">
							<table class="table table-bordered">
							<tr>
								<th width="25%">등록자</th>
								<td width="75%">
									<input type="hidden" id="ERR_SEQ" name="ERR_SEQ" data-label="오류목록" data-required="requird" value="" />
									<span id="INS_ID"></span>&nbsp;&nbsp;
									<span id="INS_DATE"></span>
								</td>
							</tr>				
							<tr>
								<th width="25%">URL</th>
								<td width="75%" id="ERR_URL"></td>
							</tr>
							<tr>
								<th>오류종류</th>
								<td id="ERR_KINDVAL"></td>
							</tr>				
							<tr>
								<td colspan="2">
									<div>
										<img id="CAP_IMG" width="100%" src="" title="캡쳐이미지" class="img-thumbnail curser-pointer" />
									</div>					
									<div id="ERR_CONTENTS"></div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<textarea name="ERR_REPLY" id="ERR_REPLY" rows="10" class="form-control input-sm"></textarea>
								</td>
							</tr>																	
							</table>	
							<div class="text-center">
								<button class="btn btn-sm btn-primary" onclick="setData();">저장</button>
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