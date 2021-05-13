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
		font-size: 5pt;
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
<title>輸入新密碼</title>
<!-- <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet"> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script> -->
<link rel="stylesheet" href="jqueryui/style.css">
</head>
<body>
	<h2>變更密碼</h2>
	<c:import url="../newheader.jsp"/>
	<fieldset class='f1'>
		<legend>輸入新密碼</legend>
		<form:form method="POST" modelAttribute="updatePwd" enctype='multipart/form-data' action='UpdatePwd' id="form1">
			<div>
				<table class='table' id='table1'>
					<tr>
						<td colspan="2">
							<h6 style="color:Tomato;">※請輸入新密碼，修改完成後請用新密碼重新登入</h6>
						</td>
					</tr>
					<tr>
						<form:hidden path="account" />
					</tr>
					<tr>
	      				<td>新密碼：</td>
		  				<td><form:input path='password' type='password' id='newPwd'/><br>
		     				<span class="sp">8~16位英文字母和數字的組合(區分大小寫)</span><br/>
		     				<form:errors path='password' cssClass="error"/>
		     			</td>
		     		</tr>
		     		<tr>
	      				<td>確認新密碼：</td>
		  				<td><form:input path='dbChkPwd' type='password' id='chkNewPwd'/><br>	
		     				<span class="sp">必須與密碼相同</span><br/>
		     				<form:errors path='dbChkPwd' cssClass="error"/>
		     			</td>
		     		</tr>
				</table>
			</div>
		</form:form>
	</fieldset>
	<div class='d1'>
		<input type='button' class="btn btn-info" value='送出' onclick='dataSubmit()'>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="btn btn-secondary" value='回首頁' onclick='location.href="<c:url value='../'/> "'><br><br>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class="btn btn-danger" value='一鍵輸入' id='clickInput'>
	</div>
	
<script>

$("#clickInput").click(function(){
	$("input[id='newPwd']").val("beyond1000")
	$("input[id='chkNewPwd']").val("beyond1000")
});



function dataSubmit(){
	Swal.fire({
		icon: "question",
		showCancelButton: true,
		confirmButtonText: "確定",
		cancelButtonText: "取消",
		title: "確定修改新密碼?"
	}).then((result) => {
		if (result.isConfirmed) {
			$("#form1").submit();
		}
	});
}

</script>
<c:import url="../footer.jsp"/>

</body>
</html>