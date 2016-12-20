<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ERROR</title>
<%@ include file="/include/IncHeader.jsp"%>
<script type="text/javascript">

</script>
</head>
<body>
<div class="container-fluid">

	<div class="row">
	
		<!-- 컨텐츠 START -->
		<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		
		<h4>
		<span class="glyphicon glyphicon-info-sign"></span>
		<%=request.getAttribute("errorMessage") %>
		</h4>
		
		</div>
		<!-- 컨텐츠 END -->
		
	</div>
	
</div>
</body>
</html>