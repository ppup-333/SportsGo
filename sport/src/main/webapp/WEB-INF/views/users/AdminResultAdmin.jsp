<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
<style>

	td {
		height: 40px;
		width: auto;
		
	}

	.div1 {
		width: 1000px;
		height: 100px;
		max-width: 1000px;
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
	
</style>
<meta charset="UTF-8">
<title>管理者資料管理</title>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet">
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<link rel="stylesheet" href="jqueryui/style.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
</head>
<body>
<fieldset>
	<legend>管理者資料查詢</legend>
	<form:form method="POST" modelAttribute="users" enctype='multipart/form-data' >
		<div >
			<table>
				<tr>
					<td>帳號：&nbsp;</td>
					<td><form:input path="account" id="account"/>&nbsp;&nbsp;</td>
					<td><button id='search'>查詢</button></td>
				</tr>
			</table>
		</div>
	</form:form>
</fieldset>
		<div><br></div>
		<div>
			<button id='create'>新增管理者</button>
			<button id='delete'>刪除管理者</button>
			<input type='button' value='回上一頁' onclick='location.href="adminUserHomePage"'>
		</div><br>
		<div>
			<br>
		</div>
		<div id='searchResultDiv' ></div>

<script>

	var alink = document.getElementById("search");
	alink.onclick = function() {
		select1();
	};
	

// function select1(){
// // 	window.alert("123")
// 	var account = document.getElementById("account");
	
// 	if(account.value == ""){
// 		alert("請輸入查詢的帳號");
// 	} else {

// 		var account = document.getElementById("account").value;
		
// 		var xhr = new XMLHttpRequest();
// 		xhr.open("POST", "<c:url value='/admin/.....' />", true);
// 		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		
// 		xhr.send("account=" + account);
// 		xhr.onreadystatechange = function() {
// 			if (xhr.readyState == 4 && xhr.status == 200) {
// 				var content = "<table border='1'>";
// 					content += "<tr align='center'><th>帳號</th><th>最後修改時間</th></tr>";
// 				var adminRs = JSON.parse(xhr.responseText);
// 				for (var i = 0; i < adminRs.length; i++) {
// 					var dateTime = new Date(adminRs[i].ver).toLocaleString("zh-TW"); 
// 					content += "<tr><td align='center' >" + adminRs[i].account + "</td>"
// 							+ "<td align='center'>" + dateTime + "</td>"
// 				}
// 				content += "</table>";
// 				var divs = document.getElementById("searchResultDiv");
// 				divs.innerHTML = content;
// 			}
// 		}
// 	}
// }

</script>
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script> -->
</body>
</html>