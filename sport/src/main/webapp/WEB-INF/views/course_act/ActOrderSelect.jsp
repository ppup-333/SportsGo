<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="../newheader.jsp"/>
<c:choose>
<c:when test="${result=='0'}">
<h1>目前沒有付款完成的課程</h1>
</c:when>
<c:otherwise>
<h1>已付款完成的課程</h1>

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
</body>
</html>