<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>

<script type='text/javascript'>
$(document).ready(function() {
    $('#deletelink').click(function() {
    	if (confirm('確定刪除公告? ')) {
            submit();
    	} 
    	return false;
        
    });
})
</script>
<body>

<div align='center'>
	<tr>
		<!-- 公告標題 -->
		<td><h2>${bulletin.title }</h2><br>
		<!-- 公告內容 -->
		<td>${bulletin.contents }<br>
	</tr>
</div>
<div align="center">
	<a href="<c:url value='/bulletin/update/${bulletin.id}'/> " >更新公告</a>
	<form action="<c:url value='/'/>bulletin/delete/${bulletin.id}" method='POST'>
		<input type='hidden' name='_method' value='delete'>
		<button type="submit" id='deletelink'>刪除公告</button>
	</form>
	
<%-- 	<a class='deletelink' href="<c:url value='/'/>Bulletin/delete/${bulletin.id}" >刪除公告</a> --%>
	<a href="<c:url value='/bulletin/showAllBulletin'/> " >回前頁</a>
</div>

</body>
</html>