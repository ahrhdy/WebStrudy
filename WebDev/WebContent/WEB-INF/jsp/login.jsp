<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>
<%@ include file="/include/IncHeader.jsp"%>
<link href="/css/signin.css" rel="stylesheet">
<script type="text/javascript">
var flag = "<%=request.getParameter("flag") %>";

	$(document).ready(function() {
		if(flag=="y"){
			alert("아이디/비밀번호를 확인해주세요.");
		}
		localStorage.clear();
	});
</script>
</head>
<body>
	<div class="container">
      <form class="form-signin" method="POST" action="/login.do">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="USERID" class="sr-only">Id</label>
        <input type="text" id="USERID" name="USERID" value="admin" class="form-control" placeholder="id" required autofocus>
        <label for="PASSWORD" class="sr-only">Password</label>
        <input type="password" id="PASSWORD" name="PASSWORD" value="adminadmin" class="form-control" placeholder="password" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>
    </div> <!-- /container -->
</body>
</html>