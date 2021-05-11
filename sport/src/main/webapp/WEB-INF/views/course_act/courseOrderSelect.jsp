<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<meta charset="UTF-8">
<title>courseOrderSelect</title>
<style type="text/css">
table{
border:1px solid #FFF8D7;
text-align:center;
margin-top:20px;
margin-left: auto;
margin-right: auto;
}
th{
padding:10px;
background-color:#FFD500;
border-left:1px solid #FFF8D7;
}
td{
color:	#6C6C6C;
background-color:#FFFFDF;
padding:10px;
}
.course{
width:400px;
margin-left:200px;
margin-top:50px;
font-size:50px;
}
.apply{
	 background-color:#FFD500;
  border: none;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  cursor: pointer;
  margin-top:20px;
  margin-left:auto;
   margin-right:auto;
	
}

.main_body {
	text-align: center;
}
</style>
</head>
<body>
<c:import url="../newheader.jsp"/>
<div class="main_body">

<c:choose>
<c:when test="${result=='0'}">

<div class="course">目前沒有付款完成的課程<hr></div>
</c:when>
<c:otherwise>
	<div class="course">已付款完成的課程<hr></div>
<table class='courseTable' border='1' style='border-collapse:collapse; border:2px solid #D0D0D0; border-right:1px solid #D0D0D0; margin-left: auto; margin-right:auto;'>

<tr><th width='70'>課程名稱</th><th width='70'>費用</th><th width='70'>上課時間</th><th width='70'>下課時間</th><th width='100'>開始日期</th><th width='100'>結束日期</th></tr>

<c:forEach var="item1" items="${resultList}" varStatus="status">
			<tr>
	<c:forEach var="item2" items="${item1}" varStatus="status2">
	 		<td>${item2}	
	</c:forEach> 
</c:forEach> 
</table>
</c:otherwise>
</c:choose>
<button type="button" class="apply" onclick="window.location.href='/sport/'">回首頁</button>
</div>
</body>
</html>