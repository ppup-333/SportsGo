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
   	width:380px; 
	margin:auto;
/*   	margin-left:550px; */
 	margin-bottom:15px;
 	
 	border: 1px solid gray;
 	border-radius: 15px;
 	background-color: rgb(245,245,245);
 	box-shadow: 0 0 3px gray;
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
<h2>忘記密碼</h2>
	<fieldset class='f1'>
<!-- 		<legend>忘記密碼</legend> -->
		<form:form method="POST" modelAttribute="forgetPwd" enctype='multipart/form-data' id="form1">
			<div>
				<table class='table' id='table1'>
					<tr>
						<td class="border-top-0" style="padding-left:30px" colspan="2">
							<h6 style="color:Tomato;">※請輸入註冊的帳號與相關資料</h6>
						</td>
					</tr>
					<tr>
						<td style="padding-left:30px">帳號：</td>
						<td>
							<form:input path="account" id='userAct' />
						</td>
					</tr>
					<tr>
						<td style="padding-left:30px">身分證字號：</td>
						<td>
							<form:input path="id" id='userId' />
						</td>
					</tr>
					<tr>
						<td style="padding-left:30px">E-Mail：</td>
						<td>
							<form:input path="email" id='userEmail' />
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 					<td>&nbsp;</td> -->
<%-- 					<td><form:errors path='account' cssClass="error" /></td> --%>
<!-- 					</tr> -->
				</table>
				<p style="text-align: center;"><form:errors path='account' cssClass="error" /></p>
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
	$("input[id='userAct']").val("beyond1000")
	$("input[id='userId']").val("A161627871")
	$("input[id='userEmail']").val("beyond780412@gmail.com")
});

</script>
<c:import url="../footer.jsp"/>
</body>
</html>