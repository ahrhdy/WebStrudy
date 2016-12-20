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
var listBind01 = new ListBind("gridList01", true);

$(document).ready(function() {
	getDataList();
});

function getDataList(){
	var param = new Map();	//파라메터 변수
	var brdKindCd = request.getParameter("BRD_KINDCD");
	$("#BRD_KINDCD_NM").text(getCodeValue("CD003", brdKindCd));
	
	//divSearch영역의 폼태그의 value값을 읽어와 파라메터를 생성한다.		
	param.put("BRD_KINDCD", brdKindCd);
	param.put($("#BRD_SERACH_TYPE").val(), $("#BRD_KEYWORD").val());
	
	listBind01.controller("/brd/selBrdPaging.ajax");	//컨트롤러 url
	listBind01.setParam(param);	//컨트롤러로 넘길 조회 파라메터
	listBind01.setRowCount(30);	//그리드에 보여줄 row의 수 (기본 :10)
	listBind01.setPageId("divPage");	// 페이징 보여줄 태그 id
	listBind01.setGridPageInfo("divGridInfo01"); //그리드의 페이징정보, 현재페이지 정보 보여줄 id
	listBind01.sendAjax();	//컨트롤러 호출
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
	 	<table class="table table-hover table-condensed table-striped">
			<thead>
				<tr>
					<th width="65%">제목</th>											
					<th width="15%">사용자</th>
					<th width="20%">등록일자</th>
				</tr>
			</thead>
			<tbody id="gridList01">
				<tr class="curser-pointer">
					<td>
						<a href="/contents/BRD_VIEW.do?BRD_SEQ={BRD_SEQ}&BRD_KINDCD={BRD_KINDCD}">
						{BRD_SUBJECT}
						</a>
					</td>
					<td>{INS_ID}</td>
					<td>{INS_DATE}</td>
				</tr>
			</tbody>
		</table>	
		<div id="divGridInfo01"></div>
		<div id="divPage" class="form-inline text-center"></div>
			
		<table id="divSearch" class="table table-bordered table-condensed">
			<tr>
				<th width="15%">
					<select id="BRD_SERACH_TYPE" name="BRD_SERACH_TYPE" class="form-control input-sm">
						<option value="BRD_SUBJECT">제목</option>
						<option value="BRD_CONTENTS">내용</option>
						<option value="INS_ID">작성자</option>
					</select>				
				</th>
				<td width="75%">
					<input type="text" id="BRD_KEYWORD" name="BRD_KEYWORD" class="form-control input-sm" value="" />					
				</td>
				<td><button class="btn btn-sm btn-info" onclick="getDataList();">검색</button></td>
			</tr>												
		</table>
		<!-- 컨텐츠 END -->
		
	</div>
	
</div>
</body>
</html>