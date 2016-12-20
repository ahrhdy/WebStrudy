<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시댓글 관리</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var listBind = new ListBind("gridList", false);
var comboBind = new ComboBind("BRD_KINDCD");

$(document).ready(function() {
	getDataList();
	comboBind.setCodeSection("CD003");
	
	//댓글 수정 클릭
	$("#gridList").on("click", ".glyphicon-pencil",function( event ) {					
		var idx = $(".glyphicon-pencil").index(this);
		listBind.rowEdit(idx);			
	});
	
	//댓글 저장 클릭
	$("#gridList").on("click", ".glyphicon-floppy-disk",function( event ) {
		
		if(!confirm("댓글을 저장하시겠습니까?")){
			return false;
		}
		
		var idx = $(".glyphicon-floppy-disk").index(this);			
		var param = new Map(); 
		param.setJson(listBind.rowSave(idx));
		sendJsonAjax("/common/brd/update/updBrd03.ajax", param, replySaveCallBack);
	});	
	
	//댓글 삭제 클릭
	$("#gridList").on("click", ".glyphicon-remove",function( event ) {			
		
		if(!confirm("댓글을 삭제하시겠습니까?")){
			return false;
		}
		
		var idx = $(".glyphicon-remove").index(this);
		var param = new Map(); 
		param.setJson(listBind.rowIdxData(idx));
		sendJsonAjax("/common/brd/delete/delBrd03.ajax", param, replySaveCallBack);	//업데이트 컨트롤러 호출.
	});			
});

function replySaveCallBack(json){
	alert("처리되었습니다.");
	listBind.sendAjax();
}


/**
 * 댓글 조회
 */
function getDataList(){
	var param = new Map();	//파라메터 변수
	
	//divSearch영역의 폼태그의 value값을 읽어와 파라메터를 생성한다.		
	setAreaParamData(param, "divSearch");
	
	listBind.controller("/brd/selBrdReplyList.ajax");	//컨트롤러 url
	listBind.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind.setHeaderFix(true);
	listBind.setPageId("divPage");	// 페이징 보여줄 태그 id
	listBind.setGridPageInfo("divGridInfo"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id	
	listBind.sendAjax();	//컨트롤러 호출
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

					<h3>댓글 목록
						<span class="fr">
							<button class="btn btn-sm btn-default" onclick="initForm('divSearch');">초기화</button>
							<button class="btn btn-sm btn-info" onclick="getDataList()">조회</button>
						</span>
					</h3>
						
					<table id="divSearch" class="table table-bordered table-condensed">
						<tr>
							<th width="10%">게시판종류</th>
							<td width="20%">
								<select id="BRD_KINDCD" name="BRD_KINDCD" class="form-control input-sm" >
								</select>				
							</td>
							<th width="10%">내용</th>
							<td width="60%"><input type="text" id="RP_CONTENTS" name="RP_CONTENTS" class="form-control input-sm" value="" /></td>
						</tr>						
					</table>		
				
				 	<table class="table table-hover table-condensed table-striped">
						<thead data-headersort="gridList">
							<tr>
								<th width="10%" data-column="BRD_KINDCD_NM">게시판 명</th>
								<th width="50%" data-column="RP_CONTENTS">내용</th>
								<th width="15%" data-column="INS_DATE">등록일자</th>
								<th width="10%" data-column="INS_ID">사용자</th>
								<th width="15%">편집</th>
							</tr>
						</thead>
						<tbody id="gridList">			
							<tr>
								<td>{BRD_KINDCD_NM}</td>
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
					<div id="divGridInfo"></div>		
		
		
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