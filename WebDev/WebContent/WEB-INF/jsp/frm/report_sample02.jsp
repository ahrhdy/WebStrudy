<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
<h1>레포트 양식 - 02</h1>
<div>&nbsp;</div>
<table>
<tr>
	<th width="5%">이름</th>
	<td width="45%">
		{NAME}
	</td>
	<th width="5%">연락처</th>
	<td width="45%">
		{PHONE}
	</td>
</tr>										
</table>

<table border="1">
	<thead>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>휴대전화</th>
			<th>전화</th>
			<th>이메일</th>						
		</tr>
	</thead>
	<tbody>
	{LIST_START}
		<tr>
			<td>{USER_ID}</td>
			<td>{USER_NAME}</td>
			<td>{MOBILE}</td>
			<td>{TEL}</td>
			<td>{EMAIL}</td>						
		</tr>
	{LIST_END}
	</tbody>	
</table>
</body>
</html>