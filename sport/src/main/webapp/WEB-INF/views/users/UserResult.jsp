<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>

<c:import url="../headerScript.jsp"/>
<style>

 	.f1{ 
 	font-size:14px; 
   	width:500px; 
/*    	margin:auto; */
  	margin-left:550px;
 	margin-top:50px;
 	} 

 	.d1{ 
 	
 	width:500px;
 	margin-left:650px;
 	margin-top:20px;
/*  	margin:20px 600px;  */
 	}
 	
 	#table1 td{
 	padding:8px;
/*   	text-align: justify; */
 	} 

</style>
<meta charset="UTF-8">
<title>會員資料</title>
</head>
<body>
<c:import url="../newheader.jsp"/>
	<fieldset class='f1'>
		<legend>會員資料</legend>
		<div>
			<table class='table table-striped table-hover' id='table1' >
				<tr>
					<td>帳號：&nbsp;</td>
<!-- 					<td>&nbsp;&nbsp;</td> -->
					<td>${user.account}</td>
				</tr>
				<tr>
					<td>姓名：&nbsp;</td>
<!-- 					<td>&nbsp;</td> -->
					<td>${user.name}</td>
				</tr>
				<tr>
					<td>身分證字號：&nbsp;&nbsp;</td>
<!-- 					<td>&nbsp;</td> -->
					<td>${user.id}</td>
				</tr>
				<tr>
					<td>性別：&nbsp;</td>
<!-- 					<td>&nbsp;</td> -->
					<td>${user.gender}</td>
				</tr>
				<tr>
					<td>生日：&nbsp;</td>
<!-- 					<td>&nbsp;</td> -->
					<td>${user.birthday}</td>
				</tr>
				<tr>
					<td>E-Mail：&nbsp;</td>
<!-- 					<td>&nbsp;</td> -->
					<td>${user.email}</td>
				</tr>
				<tr>
					<td>城市：&nbsp;</td>
<!-- 					<td>&nbsp;</td> -->
					<td>${userCity.city}</td>
				</tr>
				<tr>
					<td>鄉鎮市區：&nbsp;</td>
<!-- 					<td>&nbsp;</td> -->
					<td>${userDistrict.district}</td>
				</tr>
				<tr>
					<td>地址：&nbsp;</td>
<!-- 					<td>&nbsp;</td> -->
					<td>${user.address}</td>
				</tr>
				<tr>
					<td>室內電話：&nbsp;</td>
<!-- 					<td>&nbsp;</td> -->
					<td>${user.tel}</td>
				</tr>
				<tr>
					<td>行動電話：&nbsp;</td>
<!-- 					<td>&nbsp;</td> -->
					<td>${user.mobile}</td>
				</tr>
				
			</table>
		</div>
	</fieldset>
		<div class='d1'>
			<input type='button' class="btn btn-danger" value='修改資料' onclick='location.href="userUpdate"'>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type='button' class="btn btn-secondary" value='回上一頁' onclick='location.href="loginHomePage"'>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- 			<input type='button' value='回上一頁' onclick='location.href="loginHomePage"'> -->
			<input type='button' class="btn btn-secondary" value='回首頁' onclick='location.href="<c:url value='../'/> "'>
		</div>
</body>
</html>