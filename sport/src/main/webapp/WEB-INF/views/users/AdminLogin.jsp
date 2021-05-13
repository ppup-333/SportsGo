<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

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
   	width:360px; 
   	margin:auto;
   	margin-bottom: 15px;
/*   	margin-left:550px; */
/*  	margin-top:50px; */
 	padding-top: 15px;
 	border: 1px solid gray;
 	box-shadow: 0 0 3px gray;
 	border-radius: 15px;
 	background-color: rgb(245,245,245);
 	} 

 	.d1{ 
 	text-align: center;
/*  	width:500px; */
/*  	margin-left:700px; */
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
<!-- <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet"> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script> -->
<!-- <link rel="stylesheet" href="jqueryui/style.css"> -->
</head>
<body>
<c:import url="../newheader.jsp"/>
<h2>管理者登入</h2>
<fieldset class='f1'>
<!-- <legend>管理者登入</legend> -->
	<form:form method="POST" modelAttribute="adminLogin" enctype='multipart/form-data' id="form2">
		<div>
			<table class='table' id='table1'>
				<tr>
					<td class="border-top-0" style="padding-left:25px">管理者帳號：</td>
					<td class="border-top-0"><form:input path="account" id='adminAct' />
<!-- 						<span class="sp">8~16位英文字母和數字的組合(不區分大小寫)</span><br/> -->
<%-- 						<form:errors path='account' cssClass="error"/> --%>
					</td>
				</tr>
				<tr>
					<td style="padding-left:25px">管理者密碼：</td>
		  				<td><form:input path='password' type='password' id='adminPwd'/>
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
<br><br>
<c:import url="../footer.jsp"/>
</body>
</html>