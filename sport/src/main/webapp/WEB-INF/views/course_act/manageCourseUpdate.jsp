<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>更改課程</title>
<style>
    .st1{
        border-bottom: 3px dashed gray;
        padding-bottom: 10px;
        width: 400px;
        margin:10px;
     
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
    .st1{
        background-color: rgb(216, 215, 215);
        border-radius: 6px;
        border: white;
   
        
    }
    fieldset{
        width: 600px;
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

<form  id="update" method="post" action="../sport/courseUpdateImpl">
<fieldset>
            <legend>修改課程資料</legend>
         <input name="courseId" value="${course.courseId}" style="display:none"/>
        <div class="st1">
            <label for="account" class="t1">課程種類: </label><span id="CN">${course.courseName}</span>
        </div>
         <div class="st1">
            <label for="account" class="t1">上課時段: </label><select name="courseKind" id="CK">
            			<option value="${course.courseKind} ${timeList[0]}~${timeList[1]}">${course.courseKind} ${timeList[0]}~${timeList[1]}</option>
						<option value="A 08:00~09:00">A 08:00~09:00</option>
						<option value="B 09:00~10:00">B 09:00~10:00</option>
						<option value="C 10:00~11:00">C 10:00~11:00</option>
						<option value="D 11:00~12:00">D 11:00~12:00</option>
						<option value="E 13:00~14:00">E 13:00~14:00</option>
						<option value="F 14:00~15:00">F 14:00~15:00</option>
						<option value="G 15:00~16:00">F 15:00~16:00</option>
						<option value="H 16:00~17:00">F 16:00~17:00</option>
				</select>
        </div>
        <div class="st1">
            <label for="account" class="t1">課程費用: </label><input id="cost" name="courseCost" value="${course.courseCost}"/>
            <span id="spcost" style="display:none;">輸入資料有誤</span>
        </div>
        
        <div class="st1">
            <label for="account" class="t1">上課次數: </label><select name="freq" id="to">
						<option value="${count}">${count}</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
				</select>
        </div>
        <div class="st1">
            <label for="account" class="t1">開課日期: </label><span id="courseDate">${timeList[2]}</span>
        </div>
        <div class="st1">
            <label for="account" class="t1">修改日期: </label><input type="date" id="from" name="from">
        </div>
        <div class="st1">
            <label for="account" class="t1">修改場地: </label>
            <c:forEach var="item1" items="${fieldList}" varStatus="status">
						<option value="${item1.id}">${item1.name}</option>
						</c:forEach>
        </div>
            <div class="st1">
            <label for="account" class="t1">老師: </label><select name="teacherId" id="to">
						<option value="${teacher.teacherId}">${teacher.teacherName}</option>
						<c:forEach var="item1" items="${teacherList}" varStatus="status">
						<option value="${item1.teacherId}">${item1.teacherName}</option>
						</c:forEach>
				</select>
        </div>
        
          <div class="st1">
            <label for="account" class="t1">最大學生數量: </label><input type="text" id="SMN" name="studentMaxNum" value="${course.studentMaxNum}">
             <span id="spSMN" style="display:none;">輸入資料有誤</span>
        </div>
         <div class="st1">
           <label for="account" class="t1">課程介紹: </label>
            <textarea rows="10" cols="30" name="courseIntroduce">${course.courseIntroduce}</textarea>
        </div>
    </fieldset> 
    
</form>
   <!--   <button type="button" class="back" id="${course.courseName}">上一步</button>-->
    <button id="updateValue">修改</button>
<script type="text/javascript">
/*$(".back").on("click",function(){
	let id=this.id;
	 $.ajax({
		 
	     url: "/springsport/manageCourseMain?sport="+id,
	     context: document.body,
	    success: function(response){
	      $('#sport').html(response);
	    }
	  });
});*/

$("#updateValue").on("click",function(){
	let isNull=true;
	let re=new RegExp("^[0-9]*$");
	let cost=document.getElementById("cost").value;
	console.log(re.test(cost));
	if(cost==""){
		isNull=false;
		$("#spcost").css("display", "inline");
		$("#spcost").css("visibility", "visible");
		$("#spcost").html("請輸入值");
	}
	
	if(re.test(cost)){
		
	}else{
		isNull=false;
		$("#spcost").css("display", "inline");
		$("#spcost").css("visibility", "visible");
		$("#spcost").html("請輸入數字");
	}
	
	if($("#SMN").val()==""){
		isNull=false;
		$("#spSMN").css("display", "inline");
		$("#spSMN").css("visibility", "visible");
		$("#spSMN").html("請輸入值");
	}
	
	
	if(re.test($("#SMN").val())){
		
	}else{
		isNull=false;
		$("#spSMN").css("display", "inline");
		$("#spSMN").css("visibility", "visible");
		$("#spSMN").html("請輸入數字");
	}
	
	console.log($("#courseDate").text());
	if($("#from").val()==""){	
		let y=$("#courseDate").text().substring(0,4);
		let m=$("#courseDate").text().substring(5,7);	
		let d=$("#courseDate").text().substring(8);
		document.getElementById("from").value =(y+"-"+m+"-"+d);
	//	($("#from").val())="2021-07-19";
		console.log($("#from").val());
	}
	
	let input=document.createElement("input");
	let courseName=$("#CN").text();
	input.setAttribute("name","courseName");
	input.setAttribute("value",courseName);
	input.style.display="none";
	$("#CN").append(input);
	
	if(isNull){
		if(confirm("確認資料無誤即將送出")){
				$("#update").submit();
		}
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