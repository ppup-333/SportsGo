<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
<style>
	#error,#resetBtnMessage{
		color:red;
		font-size:2px;
	}
	
.sp {
		color: darkgrey;
		font-size: 1px;
	}
	
.d1{
		font-size:15px;
		height:auto;
		width:500px;
		margin:auto;
		margin-top:40px;	
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
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet">
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<link rel="stylesheet" href="jqueryui/style.css">
</head>
<body>
<c:import url="../header.jsp"/>

		<div class='d1'>
			<form action='verifyEmail' method="post" id='verifyForm'>
			<input style="display:none" type="text" name="checkAccount" value="${checkAccount}"/>
			<table>
				<tr>
					<td>輸入四位認證碼:&nbsp;&nbsp;&nbsp;</td>
					<td>
						<input type="text" name="verifyCode"/>&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<input id="submitBtn" type='submit' value='送出'/>&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><span class="sp">驗證碼需區分大小寫</span></td>
				</tr>
				<tr>
					<td>
						<input id="resetCodeBtn" type="button" value="重設驗證碼" onclick="resetVerifyCode();" />
					</td>
					<td>
						<span id="resetBtnMessage"></span>
					</td>
				</tr>
			</table>
<%-- 				<input style="display:none" type="text" name="checkAccount" value="${checkAccount}"/> --%>
<!-- 				輸入四位認證碼: <input type="text" name="verifyCode"/> -->
<!-- 				<input id="submitBtn" type='submit' value='確定'/> -->
<%-- 				<input type="text" style="display:none" name="error" value="error"/><span id="error">${error }</span><br> --%>
<!-- 				<span class="sp">驗證碼需區分大小寫</span> -->
<%-- 			</form> --%>
<!-- 			<input id="resetCodeBtn" type="button" value="重設驗證碼" onclick="resetVerifyCode();" /> -->
			
<!-- 			<span id="resetBtnMessage"></span> -->
			
<%-- 			<form action="Logout" method="post" id="form1"> --%>
<!-- 				<input type="button" value="登出" onclick="form1.submit()"> -->
<%-- 			</form> --%>
		</div>

</body>
</html>