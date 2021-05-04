<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="../header.jsp"/>
<h2>場地、預約管理</h2>
<hr>
<ul>	
	<li>前台
	<ul>
		<li><a href="/sport/fieldOrder/createPage">預約場地(一般會員)</a>
		<li><a href="/sport/fieldOrder/searchForMemberPage">查詢目前訂單、歷史訂單</a>
		<li><a href="/sport/fieldOrder/cancelForMemberPage">取消訂單</a>
	</ul>
	<li>後台
	<ul>
		<li><a href="/sport/field_GetAllFields">場地管理</a>
		<li><a href="/sport/fieldOrder/searchPage">預約訂單管理</a>
	</ul>
</ul>
<a href="/sport/field_GetAllFields">場地</a>
<a href="/sport/fieldOrder/home">訂單</a>
<input type="checkbox">


</body>
</html>