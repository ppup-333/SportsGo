<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<meta charset="UTF-8">
<title>SportsGo!</title>
<link rel="stylesheet" href="css/course.css">
<style type="text/css">


/*table{
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
}*/

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

.main_body{
text-align:center;
}
</style>

</head>
<body>
<c:import url="../newheader.jsp"/>
<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<div class="main_body">
<div class="course">${activity.actName}</div>
<input id="actId" value='${activity.actId}' style="display:none;">
<button class="apply">報名</button>
<table class="activitytable">
<tr><tr><th>活動時間<th>活動開始日期<th>活動結束日期<th>活動地點<th>活動費用
	<tr><td>${timeList[0]}~${timeList[1]}<td>${timeList[2]}<td>${timeList[3]}<td>${fieldName}<td>${activity.actCost}
</table>

<br>
<div class="border_course">
<div class="small_course">活動介紹</div>
<div>${activity.actIntroduce}</div>
</div>
<button id="back" onclick="window.location.href='/sport/activityMain'" >返回</button>


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
		let xhr=new XMLHttpRequest();
		xhr.open("GET","/sport/ActSessionCheck",true);
		 xhr.send();
		 xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				var result = xhr.responseText;
				if(result=='success'){
					Swal.fire({
						title:'確定報名嗎?',
						icon:'question',
				      	showCancelButton: true, 
				      	confirmButtonColor: '#3085d6',
				      	cancelButtonColor: '#d33',
				      	confirmButtonText: '確定',
				      	cancelButtonText:'取消',
					}).then(result => {
						if(result.value){
							let actName=$(".course").eq(0).text();
							let actTime=$(".activitytable tr td").eq(0).text();
							let actDateStart=$(".activitytable tr td").eq(1).text();
							let actDateEnd=$(".activitytable tr td").eq(2).text();
							let actPlace=$(".activitytable tr td").eq(3).text();
							let actCost=$(".activitytable tr td").eq(4).text();
							let actId=$("#actId").val();
							console.log(actTime);
							let id=this.id;
							
							if(actCost==0){
								console.log("hello");
							}else{
								$.ajax({
									url:"/sport/confirmActivityApply?actId="+actId+"&actName="+actName+"&actTime="+actTime+"&actDateStart="+actDateStart+"&actDateEnd="+actDateEnd+"&actPlace="+actPlace+"&actCost="+actCost,
								    context: document.body,
								    success: function(result){			    	
								    	console.log(result);
								    	$(".main_body").empty();
								    	$(".main_body").html(result);
								   }
								});	
							}
							
						}
					})
					
					
					
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
});
</script>
<c:import url="../footer.jsp"/>
</body>
</html>