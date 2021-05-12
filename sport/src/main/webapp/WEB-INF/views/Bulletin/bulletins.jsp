<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="zh-Hant-TW">
<head>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<title>公告欄</title>

<style>
	div{
		border:1px solid red;
		align:center;
		text-align:center;
	}
	.container{
		align:center;
	}
</style>
</head>


<script>
	window.onload = function(){
		var updateTime = document.getElementById("updateTime").value;
		var time = new Date(updateTime);
		var showTime = document.getElementById("showTime");
		showTime.innerHTML = time;
	}

</script>


<body>
<!-- 	<div class=""> -->
<!-- 		<div class="allBulletins"> -->
		
<!-- 		</div> -->
<!-- 		<div class="container"> -->
<!-- 			<ul class="pagination"> -->
<!-- 				<li class="page-item"><a class="page-link" href="#">Previous</a></li> -->
<!-- 				<li class="page-item"><a class="page-link" href="#">Next</a></li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
<!-- 	</div> -->



		<div align='center' id="showAllBulletin">
			<h3>公告欄</h3>
			<a href='add'>新增公告</a> &nbsp;&nbsp;&nbsp;<a href="<c:url value='/'/> ">回前頁</a>
			<hr>
			<c:choose>
				<c:when test="${empty bulletins}">
		    	目前沒有任何公告
		    <br>
				</c:when>
				<c:otherwise>
					<table align="center" border='1' cellpadding="3" cellspacing="1">
						<tr>
							<th>公告類型</th>
							<th>公告標題</th>
							<th>公告時間</th>
						</tr>
						<c:forEach var='bulletin' items='${bulletins}'>
							<tr>
								<td style="text-align: center">${bulletin.class_id.name}</td>
								<td><a href="<c:url value='/' />Bulletin/showBulletinContent/${bulletin.id}">${bulletin.title}</a></td>
								<td id="showTime"></td>
								<input id='updateTime' type='hidden' value='${bulletin.update_time }'>
<%-- 								<td id="time">${bulletin.update_time}</td> --%>
							</tr>
						</c:forEach>
					</table>
				</c:otherwise>
			</c:choose>
			<hr>
		</div>
		<c:import url="../footer.jsp"/>	
</body>
</html>