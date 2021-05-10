<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>teacherMain</title>
 <link rel="stylesheet" href="css/teacher.css">
     <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
     <link  rel="stylesheet" href="css/course.css">
<style type="text/css">
table{
margin-top:30px;
margin-left: auto;
margin-right: auto;
}
.main_body{

text-align:center;
}
</style>
</head>
<body>

<div class="main_body">

<c:import url="../headerM.jsp" />
<div class="course">管理老師<hr></div>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
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
	</div>
<script type="text/javascript">
$(".update").on("click",function(){
	let id=this.id;
	 let xhr=new XMLHttpRequest();
		xhr.open("GET","/sport/teacherUpdate?teacherId="+id,true);
		 xhr.send();
		 xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
			let response=xhr.responseText;
			 $("body").empty();
		     $("body").append(response);
			}
		 }
});
$(".insert").on("click",function(){
	 let xhr=new XMLHttpRequest();
		xhr.open("GET","/sport/teacherInsert",true);
		 xhr.send();
		 xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
			let response=xhr.responseText;
			 $("body").empty();
		     $("body").append(response);
			}
		 }	
});
$(".delete").on("click",function(){
	
	if(confirm("確定要刪除嗎")){
		let id=this.id;
		let xhr=new XMLHttpRequest();
	xhr.open("GET","/sport/teacherDelete?teacherId="+id,true);
	 xhr.send();
	 xhr.onreadystatechange=function(){
		if(xhr.readyState==4&&xhr.status==200){
		let response=xhr.responseText;
		 $("body").empty();
	     $("body").append(response);
		}
	 }	
	}
	
	
});
</script>
</body>
</html>