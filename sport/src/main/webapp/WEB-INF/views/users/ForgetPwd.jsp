<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<style>
	td {
		height: auto;
		width: auto;
		
	}
	.div {
		width: 100%;
		height: 800px;
		max-width: 700px;
		box-shadow: 0px 0px 3px 1px #00000078;
		padding: 10px;
		box-sizing: border-box;
		margin: 0 auto;
		border: 1px solid white;
	}

	.sp {
		color: darkgrey;
		font-size: 1px;
	}


	span.error {
		color: red;
		display: inline-block;
		font-size: 13pt;
	}
	
	.f1{ 
 	font-size:15px; 
/*  	width:550px;  */
 	margin-left:620px; 
 	margin-top:50px;
 	} 

 	.d1{ 
 	margin:20px 620px; 
 	} 
</style>
<meta charset="UTF-8">
<title>忘記密碼</title>
<!-- <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet"> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script> -->
<link rel="stylesheet" href="jqueryui/style.css">
</head>
<body>
<c:import url="../newheader.jsp"/>
	<fieldset class='f1'>
		<legend>忘記密碼</legend>
		<form:form method="POST" modelAttribute="forgetPwd" enctype='multipart/form-data' id="form1">
			<div>
				<table>
					<tr>
						<td colspan="2">
							<h6 style="color:Tomato;">※請輸入註冊的帳號與相關資料</h6>
						</td>
					</tr>
					<tr>
						<td>帳號：<br>&nbsp;</td>
						<td><form:input path="account"  /><br>&nbsp;
							<br/>
						</td>
					</tr>
					<tr>
						<td>身分證字號：<br>&nbsp;</td>
						<td><form:input path="id"  /><br>&nbsp;
							<br/>
						</td>
					</tr>
					<tr>
						<td>E-Mail：<br>&nbsp;</td>
						<td><form:input path="email"  /><br>&nbsp;
							<br/>
						</td>
					</tr>
					<tr>
					<td>&nbsp;</td>
					<td><form:errors path='account' cssClass="error" /></td>
					</tr>
				</table>
			</div>
		</form:form>
	</fieldset>
	<div class='d1'>
		<input type='button' value='送出' onclick='form1.submit()'>&nbsp;&nbsp;
		<input type='button' value='回首頁' onclick='location.href="<c:url value='../'/> "'>
	</div>
</body>
</html>