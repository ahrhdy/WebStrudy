<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>레이어팝업관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var editor;
var listBind = new ListBind("gridList", false);
var comboBind = new ComboBind("PGM_ID");

$(document).ready(function() {	
	getDataList();
	
	editor = new Editor({"id":"CONTENTS", "toolbar":true, "mode":true, "vertical":true});
	
	$("#gridList").on("click","tr", getDetail);	//사용자정보 그리드 row클릭 이벤트
});

function getDataList(){
	var param = new Map();	//파라메터 변수
	
	//divSearch영역의 폼태그의 value값을 읽어와 파라메터를 생성한다.		
	setAreaParamData(param, "divSearch");
	
	listBind.controller("/common/lnt/list/selPgmList.ajax");	//컨트롤러 url
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
	
	setAreaParamData(param, "divDetail");
	param.put("CONTENTS", editor.getContents());
	sendJsonAjax("/lnt/insLnt.ajax", param, setDataCallBack);	
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
						<h3>레이어팝업목록</h3>
									
					 	<table class="table table-hover table-condensed table-striped">
							<thead>
								<tr>
									<th width="30%">프로그램</th>
									<th width="50%">제목</th>
									<th width="20%">작성여부</th>
								</tr>
							</thead>
							<tbody id="gridList">
								<tr class="curser-pointer">
									<td>{PGM_ID}</td>
									<td>{LNT_NAME}</td>
									<td>{PROC_YN}</td>
								</tr>
							</tbody>
						</table>
						<div id="divGridInfo"></div>			
					</div>
					
					<div class="col-lg-8">
						<h3>레이어팝업 입력</h3>
						
						<div id="divDetail">
							<table class="table table-bordered">
							<tr>
								<th>제목</th>
								<td colspan="3">
									<input type="text" id="LNT_NAME" name="LNT_NAME" data-label="제목" data-required="requird" class="form-control input-sm" value="" />
								</td>
							</tr>
							<tr>
								<th width="15%">x좌표</th>
								<td>
									<input type="text" id="POS_X" name="POS_X" data-label="x좌표" data-required="requird number" class="form-control input-sm" value="" />
								</td>
								<th width="15%">y좌표</th>
								<td>
									<input type="text" id="POS_Y" name="POS_Y" data-label="y좌표" data-required="requird number" class="form-control input-sm" value="" />
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
								<td>
									<input type="radio" id="USE_YN" name="USE_YN" data-label="사용여부" data-required="requird" value="Y" />예 
									<input type="radio" name="USE_YN" value="N" />아니오						
								</td>
								<th>프로그램</th>
								<td>
									<input type="text" id="PGM_ID" name="PGM_ID" data-label="프로그램" data-required="requird" class="form-control input-sm" value="" readonly />
								</td>					
							</tr>				
							<tr>
								<td colspan="4">
									<textarea name="CONTENTS" id="CONTENTS" rows="10" cols="100" style="display:none;"></textarea>
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