<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>報名訂單</title>
<style>
.main_body {
	text-align: center;
}
    .st1{
        border-bottom: 1px solid gray;
        margin: 20px;
        padding-bottom: 10px;
        
    }   
     .fs{
        margin-right:auto;
         margin-left:auto;
           margin-top:10px;
           margin-bottom:20px;
  		 width:800px;
  		 background-color:#FFFFCE;
    }
   .t1 {
        width: 100px;
        float: left;
        text-align: right;
    }
    .course{
width:200px;
margin-left:200px;
margin-top:50px;
font-size:50px;
}
.block{
height:200px;
}
    </style>
    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
    	let times=document.getElementById("times");
    	let date=$("#date").val();
    	let d=new Date(date);
    	let Day=d.getDay();
    	console.log(Day);
    	let week=["日","一","二","三","四","五","六"];
    	for(let i=0;i<week.length;i++){
    		if(Day==i){
    			times.innerHTML=week[i];
    		}
    	}
    	
    })
    </script>
</head>
<body>
<c:import url="../header.jsp" />
 <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
 <div class="main_body">
 
 

<form  id="courseApply" method="post" action="../sport/confirmCourseApply">
<div class="course">報名資料確認</div>
<fieldset class="fs">
            
         <input name="courseId" value="${course.courseId}" style="display:none"/>
        <div class="st1">
            <label for="account" class="t1">帳號: </label><span> ${account}</span>
             <input name="account" value="${account}" style="display:none;"/>
        </div>
        <div class="st1">
            <label for="account" class="t1">課程名稱: </label><span> ${course.courseName} ${course.courseKind}</span>
             <input name="courseName" value="${course.courseName}" style="display:none;"/>
             <input name="courseKind" value="${course.courseKind}" style="display:none;"/>
        </div>
        <div class="st1">
            <label for="account" class="t1">課程費用: </label><span> ${course.courseCost}</span>
             <input name="courseCost" value="${course.courseCost}" style="display:none;"/>
        </div>       
         <div class="st1">
            <label for="account" class="t1">上課時間: </label><span> ${timeList[0]}</span>
            <input name="TimeStart" value="${timeList[0]}" style="display:none;"/>
        </div>
        <div class="st1">
            <label for="account" class="t1">下課時間: </label><span> ${timeList[1]}</span>
             <input name="TimeEnd" value="${timeList[1]}" style="display:none;"/>
        </div>
        <div class="st1">
            <label for="account" class="t1">每周: </label><span id="times"></span>
            <input name="count" value="${count}" style="display:none;"/>
        </div>
           <div class="st1">
            <label for="account" class="t1">老師: </label><span>${teacherName}</span>
            <input name="teacherName" value="${teacherName}" style="display:none;"/>
        </div>
        <div class="st1">
            <label for="account" class="t1">開課日期: </label><span> ${timeList[2]}</span>
            <input name="DateStart" id="date" value="${timeList[2]}" style="display:none;"/>
        </div>
        <div class="st1">
            <label for="account" class="t1">結訓日期: </label><span> ${timeList[3]}</span>
             <input name="DateEnd" value="${timeList[3]}" style="display:none;"/>
        </div>
         <div>
            <label for="account" class="t1">備註(如氣喘，心臟病等其他需老師注意事項或要求):</label><textarea name="remark" rows="4" cols="50"></textarea>         
        </div>
    </fieldset> 
    
</form>
	
    <button type="button" onclick="window.location.href='/sport/courseApply?id=${course.courseId}&type=first'">上一步</button>
     <button type="button" class="confirm">確認報名</button>
     <div class="block"></div>
     </div>
<script type="text/javascript">
$(".confirm").on("click",function(){
	if(confirm("確認報名")){
		$("#courseApply").submit();
	}
});
    
    
    
 /*   $(".back").on("click",function(){
    	let id=this.id;
    	let xhr=new XMLHttpRequest();
    	xhr.open("GET","/springsport/courseMain?sport="+id,true);
    	xhr.send();
    		xhr.onreadystatechange=function(){
    		if(xhr.readyState==4&&xhr.status==200){
    			var result = JSON.parse(xhr.responseText);
    		
    	
    			$("#sport").empty();
    			var content = "<table border='1' >";
    			content += "<tr><th width='70'>課程名稱</th><th width='70'>課程代號</th><th width='70'>費用</th><th width='70'>上課時間</th><th width='70'>下課時間</th><th width='100'>開始日期</th><th width='100'>結束日期</th><th width='70'>場地</th><th width='70'>老師</th><th width='100'>尚可報名人數</th><th width='70'>按下去</th></tr>";
    				for(let i=0;i<result.length;i++){
    					content+="<tr><td>"+result[i].courseName+"</td>"+
    							"<td>"+result[i].courseKind+"</td>"+
    							"<td>"+result[i].courseCost+"</td>"+
    							"<td>"+result[i].courseTimeStart.substring(0,5)+"</td>"+
    							"<td>"+result[i].courseTimeEnd.substring(0,5)+"</td>"+
    							"<td>"+result[i].courseDateStart+"</td>"+
    							"<td>"+result[i].courseDateEnd+"</td>"+
    							"<td>"+result[i].coursePlace+"</td>"+
    							"<td>"+result[i].teacherId+"</td>"+
    							"<td>"+result[i].studentCurrentNum+"</td>"+
    							"<td><button id='"+result[i].courseId+"'  onclick='courseApply("+result[i].courseId+")'>我要報名</button></td>"+
    							"</tr>";
    			}
    				content+="</table>";
    				$("#sport").append(content);
    				$("#sport").append("<button onclick='courseMain()' style='margin:20px'>返回</button>");
    				
    		
    		}
    	}
    });*/
    
    </script>
</body>
</html>