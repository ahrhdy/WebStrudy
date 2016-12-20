<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
<h1>레포트 양식 - 01</h1>
<div>&nbsp;</div>
<table border="1">
<tr>
	<th width="10%">이름</th>
	<td width="40%">
		{FIRST_NAME}
	</td>
	<th width="10%">사번</th>
	<td width="40%">
		{EMPLOYEE_ID}
	</td>
</tr>	
<tr>
	<th>직업</th>
	<td>
		{JOB_ID}
	</td>
	<th>입사일</th>
	<td>
		{HIRE_DATE}
	</td>
</tr>
<tr>
	<th>이메일</th>
	<td>
		{EMAIL}
	</td>
	<th>전화번호</th>
	<td>
		{PHONE_NUMBER}
	</td>
</tr>
<tr>
	<th>연봉</th>
	<td>
		{SALARY}
	</td>
	<th>부서</th>
	<td>
		{DEPARTMENT_NAME}
	</td>
</tr>
<tr>
	<th>우편번호</th>
	<td>
		{POSTAL_CODE}
	</td>
	<th>도로명</th>
	<td>
		{STREET_ADDRESS}
	</td>
</tr>													
</table>
</body>
</html>