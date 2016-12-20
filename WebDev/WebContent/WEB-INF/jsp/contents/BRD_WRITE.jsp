<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">
var request = new Request();
var listBind02 = new ListBind("gridList02", false);

$(document).ready(function() {
	getDataList();
});

function getDataList(){
	var param = new Map();
	param.put("BRD_SEQ", request.getParameter("BRD_SEQ"));
	
	//본문조회
	sendJsonAjax("/common/brd/detail/selBrdDetail.ajax", param, getDataListCallBack);
	
	//첨부파일 목록  조회
	listBind02.setParam(param);	
	listBind02.controller("/brd/selBrdAttachList.ajax");
	listBind02.sendAjax();	
}

function getDataListCallBack(json){
	jsonAutoMapping(json.data, "");
	$("#BRD_CONTENTS").html(json.data.BRD_CONTENTS);
}
</script>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="/contents/BRD_LIST.do?BRD_KINDCD=001">공지사항<span class="glyphicon glyphicon-list-alt"></span></a></li>
				<li><a href="/contents/BRD_LIST.do?BRD_KINDCD=002">자유게시판<span class="glyphicon glyphicon-list-alt"></span></a></li>
				<li><a href="/contents/BRD_LIST.do?BRD_KINDCD=003">QnA<span class="glyphicon glyphicon-list-alt"></span></a></li>
			</ul>
		</div>
	</div>
</nav>
<div class="container-fluid">

	<div class="row">
		
		<!-- 컨텐츠 START -->
		<h4 class="page-header" id="BRD_KINDCD_NM"></h4>
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th width="15%">작성자</th>
					<td width="35%" id="INS_ID"></td>
					<th width="15%">등록일자</th>
					<td width="35%" id="INS_DATE"></td>
				</tr>
				<tr>
					<th width="15%">제목</th>
					<td colspan="3" id="BRD_SUBJECT"></td>
				</tr>
				<tr>
					<th width="15%">첨부파일</th>
					<td colspan="3">
						<ul id="gridList02">
							<li>
								<a href="/download.do?uuid={COL_NAME_FILE_UUID}&name={COL_NAME_FILE_ORI_NAME}">
									<span style="cursor: pointer;" class="glyphicon glyphicon-floppy-disk"></span>{COL_NAME_FILE_ORI_NAME}
								</a>					
							</li>
						</ul>					
					</td>
				</tr>				
				<tr>
					<td colspan="4" id="BRD_CONTENTS"></td>
				</tr>				
			</tbody>
		</table>
		<div class="text-center">
			<button class="btn btn-sm btn-info" onclick="">목록</button>
			<button class="btn btn-sm btn-info" onclick="">수정</button>	
			<button class="btn btn-sm btn-info" onclick="">삭제</button>
		</div>			
		<!-- 컨텐츠 END -->
		
	</div>
	
</div>
</body>
</html>