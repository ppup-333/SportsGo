<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>manageCourseSelect</title>
<style type="text/css">
table{
 border-collapse:collapse;
 border:2px solid #D0D0D0;
 border-right:1px solid #D0D0D0;
 margin-left: auto;
 margin-right: auto;
 
}
th{
	padding:20px;
	background-color:#AAAAFF;
	border-right:1px solid #D0D0D0;
}
td{
	padding:20px;
	background-color:#66B3FF;
	border-right:1px solid #D0D0D0;
}
</style>
<script type="text/javascript">
function courseApply(id){
	
	 $.ajax({
	     url: "/springsport/courseUpdate?id="+id,
	     context: document.body,
	    success: function(response){
	      $('#sport').html(response);
	    }
	  });
}

	
</script>

</head>
<body>
  <table class='courseTable' border='1' style='border-collapse:collapse; border:2px solid #D0D0D0; border-right:1px solid #D0D0D0; margin-left: auto; margin-right:auto;'>

<tr><th width='70'>課程名稱</th><th width='70'>課程代號</th><th width='70'>費用</th><th width='70'>上課時間</th><th width='70'>下課時間</th><th width='100'>開始日期</th><th width='100'>結束日期</th><th width='70'>按下去</th></tr>

<c:forEach var="item1" items="${resultList}" varStatus="status">
		<tr>	
	<c:forEach var="item2" items="${item1}" varStatus="status2">
		<c:choose>
		<c:when test="${status2.last}">
			<td><button  onclick="courseApply(${item2})">修改</button></td>
		</c:when>
		<c:otherwise>
			<td>${item2}
		</c:otherwise>
		</c:choose>
		
	</c:forEach> 
</c:forEach> 
</table>
</body>
</html>