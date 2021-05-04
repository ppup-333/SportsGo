<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>報名訂單</title>
<style>
    .st1{
        border-bottom: 3px dashed gray;
        margin: 20px;
        padding-bottom: 10px;
        width: 500px;
        
        
    }   
    .sub{
        margin: 20px;
        text-align: center;
        width: 450px;
    }
    .t1 {
        width: 100px;
        float: left;
        text-align: right;
    }
    .st1 input,textarea{
        background-color: rgb(216, 215, 215);
        border-radius: 6px;
        border: white;
        margin-left: 30px;
        
    }
    fieldset{
        width: 600px;
        margin: 20px;
        border: 1px dashed green;
    }
    legend{
        color: blue;
    }
    select{
        margin-left: 30px;
    }
    
    .fl2{
        float: left ;
    }
    </style>
    
</head>
<body>

<form  id="courseApply" method="post" action="../springsport/confirmCourseApply">
<fieldset>
            <legend>報名資料確認</legend>
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
            <label for="account" class="t1">上課次數: </label><span>每周一次</span>
            <input name="count" value="${count}" style="display:none;"/>
        </div>
           <div class="st1">
            <label for="account" class="t1">老師: </label><span>${teacherName}</span>
            <input name="teacherName" value="${teacherName}" style="display:none;"/>
        </div>
        <div class="st1">
            <label for="account" class="t1">開課日期: </label><span> ${timeList[2]}</span>
            <input name="DateStart" value="${timeList[2]}" style="display:none;"/>
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
	
    <button type="button" class="back" id="${course.courseName}">上一步</button>
     <button type="button" class="confirm">確認報名</button>
<script type="text/javascript">
$(".back").on("click",function(){
	let id=this.id;confirm
	 $.ajax({
		 
	     url: "/springsport/courseMain?sport="+id,
	     context: document.body,
	    success: function(response){
	      $('#sport').html(response);
	    }
	  });
});
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