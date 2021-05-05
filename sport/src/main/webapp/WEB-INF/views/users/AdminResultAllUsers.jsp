<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<style>
td{
padding : 5px 15px;
}
</style>
<script>
// window.onload = function(){
// 	var userTime = document.getElementById("time").value;
// 	var time = new date(userTime).toLocaleString('zh-TW');
	
// 	var showTime = document.getElementById("temp");
// 	showTime.innerHTML = time;
// }
</script>
<meta charset="UTF-8">
<title>會員資料</title>
</head>
<body>
	<fieldset>
		<legend >會員資料</legend>
		<div>
			<c:choose>
				<c:when test="${empty users}">
	    		沒有任何會員資料<br> 
				</c:when>
				<c:otherwise>
					<table>
						<tr>
							<th>帳號</th>
							<th>姓名</th>
							<th>身分證字號</th>
							<th>性別</th>
							<th>生日</th>
							<th>E-Mail</th>
							<th>城市</th>
							<th>鄉鎮市區</th>
							<th>地址</th>
							<th>市內電話</th>
							<th>行動電話</th>
							<th>帳號狀態</th>
							<th>最後更新時間</th>
						</tr>
						<c:forEach var='users' items='${users}' varStatus='i'>
							<tr>
								<td>${users.account}</td>
								<td>${users.name}</td>
								<td>${users.id}</td>
								<td>${users.gender}</td>
								<td>${users.birthday}</td>
								<td>${users.email}</td>
								<td>${userCity[i.index].city}</td>
								<td>${userDistrict[i.index].district }</td>
								<td>${users.address}</td>
								<td>${users.tel}</td>
								<td>${users.mobile}</td>
								<td>${userStatus[i.index].status}</td>
								<td>${users.ver}</td>
<!-- 								<td id='temp'></td> -->
<%-- 								<input type='hidden' value='${users.ver}' id='time'> --%>
<!-- 								<td><input type='button' value='修改帳號狀態' onclick='location.href="XXX"'></td> -->
							</tr>
						</c:forEach>
					</table>
				</c:otherwise>
			</c:choose>
		</div>
	</fieldset>
<!-- 		<input type='button' value='修改資料' onclick='location.href="userUpdate"'> -->
		<input type='button' value='修改帳號狀態' onclick='location.href="XXX"'>
		<input type='button' value='回上一頁' onclick='location.href="adminUserHomePage"'>
</body>
</html>