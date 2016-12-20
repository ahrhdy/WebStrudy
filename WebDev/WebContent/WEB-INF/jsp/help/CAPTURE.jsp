<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SAMPLE</title>
<%@ include file="/include/IncHeaderPop.jsp"%>
<script type="text/javascript">
var comboBind = new ComboBind("ERR_KINDCD");

$(document).ready(function() {
	$("#CAP_IMG").attr("src", "/capture.do?uuid="+document.location.hash.replace("#",""));
	$("#IMG_INFO").val(document.location.hash.replace("#",""));
	$("#ERR_URL").val(parent.document.URL);
	comboBind.setCodeSection("CD001");
});

function setData(){
	
	var valid = new Validation("divDetail");
	if(!valid.check()){
		return false;
	}	

	var param = new Map();
	setAreaParamData(param, "divDetail");
	param.put("FILE_UUID", $("#CAP_IMG").attr("src"));
	sendJsonAjax("/common/err/insert/insErr.ajax", param, setDataCallBack);

}

function setDataCallBack(json){
	alert("처리되었습니다.");
}
</script>
</head>
<body style="padding-top : 0px;">
<h3>오류신고</h3>
<table id="divDetail" class="table">
<tr>
	<td colspan="4">
		<img id="CAP_IMG" width="100%" src="" title="캡쳐이미지" class="img-thumbnail" />
	</td>
</tr>
<tr>
	<th width="30%">오류종류</th>
	<td width="70%">
		<select id="ERR_KINDCD" name="ERR_KINDCD" data-required="requird" data-label="오류종류" class="form-control input-sm" >
		</select>
	</td>
</tr>	
<tr>
	<th>URL</th>
	<td colspan="3">
		<input type="text" id="ERR_URL" name="ERR_URL" data-label="URL" data-required="requird" class="form-control input-sm" readonly />
	</td>
</tr>
<tr>
	<th>내용</th>
	<td colspan="3">
		<textarea id="ERR_CONTENTS" name="ERR_CONTENTS" data-label="내용" data-required="requird" class="form-control input-sm" rows="5"></textarea>
	</td>
</tr>
													
</table>
<div class="text-center">
	<button class="btn btn-sm btn-primary" onclick="setData();">보내기</button>
</div>
</body>
</html>