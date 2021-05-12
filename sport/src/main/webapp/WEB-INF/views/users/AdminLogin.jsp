<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
<style>

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
 	font-size:14px; 
   	width:500px; 
/*    	margin:auto; */
  	margin-left:550px;
 	margin-top:50px;
 	} 

 	.d1{ 
 	
 	width:500px;
 	margin-left:700px;
/*  	margin-top:20px; */
/*  	margin:20px 600px;  */
 	}
 	
 	#table1 td{
 	padding:8px;
/*   	text-align: justify; */
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
<legend>管理者登入</legend>
	<form:form method="POST" modelAttribute="adminLogin" enctype='multipart/form-data' id="form2">
		<div>
			<table class='table' id='table1'>
				<tr>
					<td>管理者帳號：</td>
					<td><form:input path="account" id='adminAct' />
<!-- 						<span class="sp">8~16位英文字母和數字的組合(不區分大小寫)</span><br/> -->
<%-- 						<form:errors path='account' cssClass="error"/> --%>
					</td>
				</tr>
				<tr>
					<td>管理者密碼：</td>
		  				<td width='360'><form:input path='password' type='password' id='adminPwd'/>
<!-- 		     				<span class="sp">8~16位英文字母和數字的組合(區分大小寫)</span><br/> -->
		     			</td>
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
			<input type='button' class="btn btn-info" value='登入' onclick='form2.submit()'>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type='button' class="btn btn-secondary" value='回首頁' onclick='location.href="<c:url value='../'/> "'><br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type='button' class="btn btn-danger" value='一鍵輸入' id='clickInput'>
		</div>
		
		
<script>

$("#clickInput").click(function(){
	$("input[id='adminAct']").val("test1001")
	$("input[id='adminPwd']").val("test1001")
});


</script>
</body>
</html>