<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>activityCheckSignUp</title>
<style type="text/css">
table{
 border-collapse:collapse;
 border:2px solid #D0D0D0;
 border-right:1px solid #D0D0D0;
 margin-top:30px;
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
.main_body{
text-align:center;
}
</style>

</head>
<body>
<c:import url="../header.jsp"/>
<div class="main_body">
<h1>${activity.actName}</h1>
<table>
<tr><tr><th>活動時間<th>活動開始日期<th>活動結束日期<th>活動地點<th>活動費用
	<tr><td>${timeList[0]}~${timeList[1]}<td>${timeList[2]}<td>${timeList[3]}<td><td>${activity.actCost}
</table>

<h2>活動介紹</h2>
${activity.actIntroduce}
<br>
<button id="back" onclick="window.location.href='/sport/activityMain'" style="margin:20px">返回</button>
<button class="apply" id="${activity.actId}">報名</button>

</div>

<script type="text/javascript">
$(document).ready(function(){
/*	$("#back").on("click",function(){
		$.ajax({
			url:"/springsport/activityMain",
		    context: document.body,
		    success: function(result){
		    	$("#sport").empty();
		    	
		    	var content2="";
		    	for(let i=0;i<result.length;){
		    		
		    		for(let j=0;j<10;i++,j++){
		    					    			
		    			if(i==0||(i%10)==0){
		    					
		    			var content = "<button style='margin:20px' id='activityButton'  onclick='activity("+result[i]+")' >";
		    						    			
		    			}else if(i==1||i%10==1){		    				
		    				content+="<img  src='data:image/png;base64,"+result[i]+"'  width='300px' height='300px'/>"
		    				
		    			}else if(i==5||i%10==5){
		    				content+="<div>"+result[i]+"</div>"
		    				content+="</button><br>";
		    				content2+=content;
		    			}		    					    		
		    		//	if(i%5==0){
		    			//	$("#sport").append("<img id='img"+i+"' src='' />");
		    			//	document.getElementById("img"+i).src = "data:image/png;base64," + result[i];
		    		//	}else{
		    			//		$("#sport").append(result[i]);
		    		//	}
		    			
		    		}
		    	}
		    	
		    		$("#sport").append(content2);
		    	

		   }
		});	
	});*/
	
	
	$(".apply").on("click",function(){
		let actName=$("h1").eq(0).text();
		let actTime=$("td").eq(0).text();
		let actDateStart=$("td").eq(1).text();
		let actDateEnd=$("td").eq(2).text();
		let actPlace=$("td").eq(3).text();
		let actCost=$("td").eq(4).text();
		let id=this.id;
		
		if(actCost==0){
			console.log("hello");
		}else{
			$.ajax({
				url:"/springsport/confirmActivityApply?actId="+id+"&actName="+actName+"&actTime="+actTime+"&actDateStart="+actDateStart+"&actDateEnd="+actDateEnd+"&actPlace="+actPlace+"&actCost="+actCost,
			    context: document.body,
			    success: function(result){
			    	$("#sport").empty();
			    	$("#sport").html(result);
			   }
			});	
		}
		
	
		
	});
});
</script>
</body>
</html>