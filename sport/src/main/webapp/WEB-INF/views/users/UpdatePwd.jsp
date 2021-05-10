<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<style>
	td {
		height: 50px;
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
		font-size: 5pt;
	}
	
	.f1{
	font-size:15px;
	width:450px;
	margin:auto;
	}

	.d1{
	margin:20px 715px;
	}
</style>
<meta charset="UTF-8">
<title>輸入新密碼</title>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet">
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<link rel="stylesheet" href="jqueryui/style.css">
</head>
<body>
	<fieldset class='f1'>
		<legend>輸入新密碼</legend>
		<form:form method="POST" modelAttribute="updatePwd" enctype='multipart/form-data' action='UpdatePwd' id="form1">
			<div>
				<table>
					<tr>
						<td colspan="2">
							<h4>※請輸入新密碼，修改完成後請用新密碼重新登入</h4>
						</td>
					</tr>
					<tr>
						<form:hidden path="account" />
					</tr>
					<tr>
	      				<td>新密碼：<br>&nbsp;</td>
		  				<td width='360'><form:input path='password' type='password' /><br>&nbsp;	
		     				<span class="sp">8~16位英文字母和數字的組合(區分大小寫)</span><br/>
		     				<form:errors path='password' cssClass="error"/></td>
		     		</tr>
		     		<tr>
	      				<td>確認新密碼：<br>&nbsp;</td>
		  				<td width='360'><form:input path='dbChkPwd' type='password'/><br>&nbsp;	
		     				<span class="sp">必須與密碼相同</span><br/>
		     				<form:errors path='dbChkPwd' cssClass="error"/></td>
		     		</tr>
				</table>
			</div>
		</form:form>
	</fieldset>
	<div class='d1'>
		<input type='button' value='送出' onclick='dataSubmit()'>
		<input type='button' value='返回登入頁面' onclick='location.href="Login"'>
	</div>
	
<script>

function dataSubmit(){
	if(confirm("確定要修改密碼？")){
		$('#form1').submit();
	}
}

</script>
	

</body>
</html>