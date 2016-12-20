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
var listBind01 = new ListBind("gridList01", false);
var listBind02 = new ListBind("gridList02", false);

$(document).ready(function() {
	getDataList();
});

function getDataList(){
	var param = new Map();
	param.put("BRD_SEQ", request.getParameter("BRD_SEQ"));
	
	//본문조회
	sendJsonAjax("/common/brd/detail/selBrdDetail.ajax", param, getDataListCallBack);
	
	//댓글 목록 조회
	listBind01.setParam(param);	
	listBind01.controller("/brd/selBrdReplyList.ajax");
	listBind01.setGridPageInfo("divGridInfo01");
	listBind01.sendAjax();
	
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
								<a href="/download.do?uuid={FILE_UUID}&name={FILE_ORI_NAME}">
									<span style="cursor: pointer;" class="glyphicon glyphicon-floppy-disk"></span>{FILE_ORI_NAME}
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
		
		<h4 class="page-header">댓글목록</h4>
	 	<table class="table table-hover table-condensed table-striped">
			<tbody id="gridList01">
				<tr>
					<td width="70%" data-input="text" data-class="form-control input-sm" data-column="RP_CONTENTS">{RP_CONTENTS}</td>
					<td width="15%">{INS_DATE}</td>
					<td width="10%">{INS_ID}</td>
					<td width="5%">
						<span style="cursor: pointer;" class="glyphicon glyphicon-pencil"></span>
						<span style="cursor: pointer;" class="glyphicon glyphicon-floppy-disk"></span>
						<span style="cursor: pointer;" class="glyphicon glyphicon-remove"></span>									
					</td>						
				</tr>
			</tbody>
		</table>
		<div id="divGridInfo01"></div>			
		<!-- 컨텐츠 END -->
		
	</div>
	
</div>
</body>
</html>