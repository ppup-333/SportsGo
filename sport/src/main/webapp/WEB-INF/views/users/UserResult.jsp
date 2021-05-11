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
 	font-size:15px; 
/*  	width:550px;  */
 	margin-left:780px; 
 	margin-top:50px;
 	} 

 	.d1{ 
 	margin:20px 780px; 
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
			<table>
				<tr>
					<td>帳號：&nbsp;<br><br></td>
					<td>${user.account}<br><br></td>
				</tr>
				<tr>
					<td>姓名：&nbsp;<br><br></td>
					<td>${user.name}<br><br></td>
				</tr>
				<tr>
					<td>身分證字號：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br></td>
					<td>${user.id}<br><br></td>
				</tr>
				<tr>
					<td>性別：&nbsp;<br><br></td>
					<td>${user.gender}<br><br></td>
				</tr>
				<tr>
					<td>生日：&nbsp;<br><br></td>
					<td>${user.birthday}<br><br></td>
				</tr>
				<tr>
					<td>E-Mail：&nbsp;<br><br></td>
					<td>${user.email}<br><br></td>
				</tr>
				<tr>
					<td>城市：&nbsp;<br><br></td>
					<td>${userCity.city}<br><br></td>
				</tr>
				<tr>
					<td>鄉鎮市區：&nbsp;<br><br></td>
					<td>${userDistrict.district}<br><br></td>
				</tr>
				<tr>
					<td>地址：&nbsp;<br><br></td>
					<td>${user.address}<br><br></td>
				</tr>
				<tr>
					<td>室內電話：&nbsp;<br><br></td>
					<td>${user.tel}<br><br></td>
				</tr>
				<tr>
					<td>行動電話：&nbsp;<br><br></td>
					<td>${user.mobile}<br><br></td>
				</tr>
				
			</table>
		</div>
	</fieldset>
		<div class='d1'>
			<input type='button' value='修改資料' onclick='location.href="userUpdate"'>&nbsp;&nbsp;
<!-- 			<input type='button' value='回上一頁' onclick='location.href="loginHomePage"'> -->
			<input type='button' value='回首頁' onclick='location.href="<c:url value='../'/> "'>
		</div>
</body>
</html>