<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>場地、預約管理</h2>
<hr>
<ul>
	<li>前台
	<ul>
		<li><a href="fieldOrderCreatePage">預約場地(一般會員)</a>
		<li><a href="fieldOrderSearchForMemberPage">查詢目前訂單、歷史訂單</a>
		<li><a href="fieldOrderCancelForMemberPage">取消訂單</a>
	</ul>
	<li>後台
	<ul>
		<li><a href="field_GetAllFields">場地管理</a>
		<li><a href="fieldOrderSearchPage">預約訂單管理</a>
	</ul>
</ul>
<a href="field_GetAllFields">場地</a>
<a href="fieldOrderHome">訂單</a>
<input type="checkbox">


</body>
</html>