<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>首頁(登入)</title>
</head>
<body>
	<h2>TEST LOGIN HOME PAGE</h2>
	<!-- 	<a href="/Spring_Sport">回首頁</a> -->

	<div>
		<!-- 		<a href="Logout"><button>登出</button></a> -->

		<form action="Logout" method="post" id="form1">
			<input type="button" value="管理帳號資料" onclick="location.href='userResult'">
			<input type="button" value="變更密碼" onclick="">
			<input type="button" value="登出" onclick="form1.submit()">
		</form>
		<!-- 		<a href="user/Login">登入</a>  -->
		<!-- 		<a href="user/RegisterEdit">註冊</a>  -->
		<!-- 		<a href="user/...">忘記密碼</a> -->
		<!-- 		<a href="user/AdminLogin">管理者登入</a> -->
	</div>
</body>
</html>