<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<meta charset="UTF-8">
<title>courseDetail</title>
<link rel="stylesheet" href="css/course.css">
<!--  <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<style>

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
.main_body {
	text-align: center;
}
</style>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	let times=document.getElementById("times");
	let date=$("#date").text();
	let d=new Date(date);
	let Day=d.getDay();
	console.log(Day);
	let week=["日","一","二","三","四","五","六"];
	for(let i=0;i<week.length;i++){
		if(Day==i){
			times.innerHTML=week[i];
		}
	}
	
	$("#checkLogin").on("click",function(){
		let xhr=new XMLHttpRequest();
		xhr.open("GET","/sport/courseSessionCheck",true);
		 xhr.send();
		 xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				var result = xhr.responseText;
				if(result=='success'){
					let courseId=$("#courseId").text();
					self.location.href='/sport/courseApply?id='+courseId+'&type=second';
				}else if(result=='login'){
					Swal.fire({
		    		    toast: true,
		    		    position: 'center',
		    		    showConfirmButton: false,
		    		    timer: 2500,
		    		    icon: 'error',
		    		    title: '尚未登入',
		    		    text: "請先登入再報名!",    
		    		})
				}
				
			}
		 }
		
	});
	
})
</script>
</head>
<body>
<c:import url="../newheader.jsp"/>
<div class="main_body">
<div class="course">${course.courseName}${course.courseKind}<hr></div>
  <!--  <button type="button" class="apply"  onclick="window.location.href='/sport/courseApply?id=${course.courseId}&type=second'">立刻報名</button>-->
<button type="button" class="apply" id='checkLogin'>立刻報名</button>
<table>
	<tr><th>課程代號<th>上課時間<th>每週<th>開課日期<th>結束日期<th>上課地點<th>班級最大人數<th>目前人數
	<tr><td id='courseId'>${course.courseId}
		<td>${timeList[0]}~${timeList[1]}
		<td id="times">
		<td id="date">${timeList[2]}
		<td>${timeList[3]}
		<td>${fieldName}
		<td>${course.studentMaxNum}
		<td>${course.studentCurrentNum}
</table>
<div class="border_course">
<div class="small_course">課程內容</div>
<div>${course.courseIntroduce}</div>
<div class="small_course">課程費用</div>
<div>NT${course.courseCost}$</div>
<div class="small_course">老師資訊</div>
<div>老師姓名:${teacherName}</div>
</div>
    <button type="button" onclick="window.location.href='/sport/NewCourseMain'">上一步</button>

</div>
</body>
</html>