<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
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
				<table class='table' id='table1'>
					<tr>
						<td colspan="2">
							<h6 style="color:Tomato;">※請輸入註冊的帳號與相關資料</h6>
						</td>
					</tr>
					<tr>
						<td>帳號：</td>
						<td>
							<form:input path="account" id='userAct' />
						</td>
					</tr>
					<tr>
						<td>身分證字號：</td>
						<td>
							<form:input path="id" id='userId' />
						</td>
					</tr>
					<tr>
						<td>E-Mail：</td>
						<td>
							<form:input path="email" id='userEmail' />
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
		<input type='button' class="btn btn-info" value='送出' onclick='form1.submit()'>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="btn btn-secondary" value='回首頁' onclick='location.href="<c:url value='../'/> "'><br><br>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="btn btn-danger" value='一鍵輸入' id='clickInput'>&nbsp;&nbsp;
	</div>
	
<script>

$("#clickInput").click(function(){
	$("input[id='userAct']").val("test1001")
	$("input[id='userId']").val("a123456789")
	$("input[id='userEmail']").val("test1001@gmail.com")
});

</script>
</body>
</html>