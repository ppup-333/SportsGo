<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>teacherMain</title>
 <link rel="stylesheet" href="css/teacher.css">

</head>
<body>

<table>

<tr><th>老師姓名<th>性別<th>電話<th>薪水<th>雇用日期<th><th>
<c:forEach var="teacher" items="${teacherList}" varStatus="status">
<c:choose>
<c:when test="${teacher.gender=='1'}">
<c:set var="gender" value="男"></c:set>
</c:when>
<c:otherwise>
<c:set var="gender" value="女"></c:set>
</c:otherwise>
</c:choose>
<tr><td>${teacher.teacherName}
	<td>${gender}
	<td>${teacher.phone}
	<td>${teacher.salary}
	<td>${teacher.hireDate}
	<td><button class="update" id="${teacher.teacherId}">修改</button>
	<td><button class="delete" id="${teacher.teacherId}">刪除</button>
</c:forEach>
</table>
	<button  class="insert">新增</button>
<script type="text/javascript">
$(".update").on("click",function(){
	let id=this.id;
	 $.ajax({		 
	     url: "/springsport/teacherUpdate?teacherId="+id,
	     context: document.body,
	    success: function(response){
	      $('#sport').html(response);
	    }
	  });
});
$(".insert").on("click",function(){
	let id=this.id;
	 $.ajax({		 
	     url: "/springsport/teacherInsert",
	     context: document.body,
	    success: function(response){
	      $('#sport').html(response);
	    }
	  });
});
$(".delete").on("click",function(){
	
	if(confirm("確定要刪除嗎")){
		let id=this.id;
	 $.ajax({		 
	     url: "/springsport/teacherDelete?teacherId="+id,
	     context: document.body,
	    success: function(response){
	      $('#sport').html(response);
	    }
	  });
	}
	
	
});
</script>
</body>
</html>