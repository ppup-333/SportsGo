<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
<meta charset="UTF-8">
<title>後台會員管理</title>
</head>
<body>
<h2>會員管理</h2>

<div>
		<form action="Logout" method="post" id="form1">
			
			<input type="button" value="會員資料查詢／異動" onclick="location.href='resultAllUsers'">
			<input type="button" value="管理員查詢／異動" onclick="location.href='resultAllAdmins'">
			<input type='button' value='回首頁' onclick='location.href="<c:url value='/'/> "'>
			<input type="button" value="登出" onclick="form1.submit()">
		</form>
	</div>
</body>
</html>