<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
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
 	width:300px; 
 	margin:auto;
 	margin-top:100px;
 	} 

 	.d1{ 
 	margin:20px 810px; 
 	} 
	
</style>
<script>
</script>
<meta charset="UTF-8">
<title>後臺管理者登入</title>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet">
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<link rel="stylesheet" href="jqueryui/style.css">
</head>
<body>
<c:import url="../header.jsp"/>
<fieldset class='f1'>
	<form:form method="POST" modelAttribute="adminLogin" enctype='multipart/form-data' id="form2">
		<div>
			<table>
				<tr>
					<td>管理者帳號:<br>&nbsp;</td>
					<td><form:input path="account"  /><br>&nbsp;
<!-- 						<span class="sp">8~16位英文字母和數字的組合(不區分大小寫)</span><br/> -->
						<form:errors path='account' cssClass="error"/></td>
				</tr>
				<tr>
					<td>管理者密碼：<br>&nbsp;</td>
		  				<td width='360'><form:input path='password' type='password' /><br>&nbsp;	
<!-- 		     				<span class="sp">8~16位英文字母和數字的組合(區分大小寫)</span><br/></td> -->
				</tr>
				<tr>
					<td></td>
					<td><form:errors path='password' cssClass="error" /></td>
				</tr>

			</table>
		</div>
		
	</form:form>
</fieldset>
		<div class='d1'>
			<input type='button' value='登入' onclick='form2.submit()'>
<%-- 			<input type='button' value='回上一頁' onclick='location.href="<c:url value='../'/> "'> --%>
		</div>
</body>
</html>