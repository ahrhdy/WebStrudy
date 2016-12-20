<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>도움말</title>
<%@ include file="/include/IncHeaderPop.jsp"%>
<script type="text/javascript">

$(document).ready(function() {
	var param = new Map();
	param.put("PGM_URL", document.location.hash.replace("#",""));
	sendJsonAjax("/common/hlp/list/selHlpList.ajax", param, fnBindContents);
});

function fnBindContents(json){
	$("#CONTENTS").html(json.data[0].CONTENTS);
}
	
</script>
</head>
<body style="padding-top:0px;">
<div class="container-fluid">

	<div class="row">
		
		<h3>도움말
			<span class="fr">				
				<span class="btn glyphicon glyphicon-remove" onclick="window.close();"></span>
			</span>		
		</h3>
		
		<div id="CONTENTS" style="overflow-y :scroll;height:530px;">
		</div>
		
	</div>
</div>

</body>
</html>