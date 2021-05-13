<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<html>
<head>

<c:import url="../headerScript.jsp"/>

<style>
	#error,#resetBtnMessage{
		color:red;
		font-size:2px;
	}
	
.sp {
		color: darkgrey;
		font-size: 1px;
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
</style>
<script>
	var time = 60;
	function resetVerifyCode(){
		$.ajax({
			url:'resetVerifyCode',
			type:"get",
			success: toggleBtn()
		})
	}

	
	function toggleBtn(){
		if(time==0){
		    $("#resetCodeBtn").attr("disabled",false);
		    time = 60;
		    $("#resetBtnMessage").empty();
		    return false;//清除定时器
		   }else{
		    $("#resetCodeBtn").attr("disabled",true);
		    $("#resetBtnMessage").text(time + "秒後可重新發送驗證碼");
		    time--;
		    setTimeout(function(){toggleBtn()},1000);
		   }
	}
</script>
<meta charset="UTF-8">
<title>email確認</title>
<!-- <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet"> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script> -->
<link rel="stylesheet" href="jqueryui/style.css">
</head>
<body>
<c:import url="../newheader.jsp"/>

		<div class='f1'>
			<form action='verifyEmail' method="post" id='verifyForm'>
			<input style="display:none" type="text" name="checkAccount" value="${checkAccount}"/>
			<table class='table'>
				<tr>
					<td>輸入四位認證碼:&nbsp;&nbsp;&nbsp;</td>
					<td>
						<input type="text" name="verifyCode"/>&nbsp;&nbsp;&nbsp;
						<input id="submitBtn" class="btn btn-info" type='submit' value='送出'/>&nbsp;&nbsp;&nbsp;<br>
						<span class="sp">驗證碼需區分大小寫</span>
					</td>
				</tr>
				<tr>
					<td>
						<input id="resetCodeBtn" class="btn btn-danger" type="button" value="重設驗證碼" onclick="resetVerifyCode();" />
					</td>
					<td>
						<span id="resetBtnMessage"></span>
					</td>
				</tr>
			</table>

			</form>

		</div>
<c:import url="../footer.jsp"/>
</body>
</html>