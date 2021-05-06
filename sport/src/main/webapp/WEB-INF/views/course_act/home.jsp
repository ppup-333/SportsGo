<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="tw">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首頁</title>
 <!--     <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />--> 
  	<link rel="stylesheet" href="css/home1_grid.css">
    <link rel="stylesheet" href="css/header1.css">
  <!--   <link rel="stylesheet" href="css/header1_grid.css"> -->
    <link rel="stylesheet" href="css/home_main.css">
    <link rel="stylesheet" href="css/course.css">
     <link rel="stylesheet" href="css/loader.css">
    
    <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
  <!--   <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
    
    <script src="scripts/header.js"></script>  
    <style type="text/css">

    </style>
<script type="text/javascript">
$(document).ready(function(){
	$("#courseOrder").on("click",function(){
		$("#sport").empty();
		$("#animation").addClass("loader");		
		$.ajax({
			url:"/sport/order",
		    context: document.body,
		    success: function(result){		
		    	$("#animation").removeClass("loader");
		    	$("#sport").html(result);
		    
		   }
		});
	});
	$("#actOrder").on("click",function(){
		$.ajax({
			url:"/sport/orderAct",
		    context: document.body,
		    success: function(result){		  
		    	$("#sport").html(result);
		   }
		});
	});
	
	
	$(".activity_hide:eq(0)").on("click",function(){
		$(".main_Title").empty();
		$(".main_Title").append("活動總覽");
		$.ajax({
			url:"/sport/activityMain",
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
	});
	
	$(".activity_hide:eq(1)").on("click",function(){
		$(".main_Title").empty();
		$(".main_Title").append("課程總覽");
		$("#sport").empty();
		$("#sport").append("<button type='button' onclick='sport(1)' class='courseButton' ><img class='courseImage'    src='images/badminton.jpg'></button><button type='button'  onclick='sport(2)' class='courseButton'><img class='courseImage' src='images/tableTennis.jpg'></button><button type='button' onclick='sport(3)'  class='courseButton'><img class='courseImage' src='images/baseketball.jpg'></button>");		

	});
	$(".activity_hide:eq(2)").on("click",function(){
		$(".main_Title").empty();
		$(".main_Title").append("管理活動");
		$.ajax({
			url:"/sport/activityInsert",
		    context: document.body,
		    success: function(result){
		    	$("#sport").html(result);
		  
		   }
		});
	});
	$(".activity_hide:eq(3)").on("click",function(){
		$(".main_Title").empty();
		$(".main_Title").append("管理課程");
		$("#sport").empty();
		$("#sport").append("<button type='button' onclick='manageSport(1)' class='courseButton' ><img class='courseImage'    src='images/badminton.jpg'></button><button type='button'  onclick='manageSport(2)' class='courseButton'><img class='courseImage' src='images/tableTennis.jpg'></button><button type='button' onclick='manageSport(3)'  class='courseButton'><img class='courseImage' src='images/baseketball.jpg'></button>");		
		$("#sport").append("<br>");
		$("#sport").append("<button onclick='insertCourse()'>新增課程</button>");
	});
	
	$(".activity_hide:eq(4)").on("click",function(){
		$(".main_Title").empty();
		$(".main_Title").append("管理老師");
		$.ajax({
			url:"/sport/teacherHome",
		    context: document.body,
		    success: function(result){
		    	$("#sport").html(result);
		  
		   }
		});
	});
	
/*	$(".activity_hide:eq(3)").on("click",function(){
				$.ajax({
					url:"/springsport/courseInsert",
				    context: document.body,
				    success: function(result){
				    	$("#sport").html(result);
				  
				   }
				});
	});*/
	
})

/*function insideSport(){
	console.log("hello");
}*/
function insertCourse(){
	$.ajax({
		url:"/sport/courseInsert",
	    context: document.body,
	    success: function(result){
	    	$("#sport").html(result);
	  
	   }
	});
}

function activity(a){	
	 $.ajax({
	     url: "/sport/activityApply?actId="+a,
	     context: document.body,
	    success: function(response){
	      $('#sport').html(response);
	    }
	  });
}
function manageSport(s){
	
	 $.ajax({
	     url: "/sport/manageCourseMain?sport="+s,
	     context: document.body,
	    success: function(response){
	      $('#sport').html(response);
	    }
	  });
}
function sport(s){
	
	 $.ajax({
	     url: "/sport/courseMain?sport="+s,
	     context: document.body,
	    success: function(response){
	      $('#sport').html(response);
	    }
	  });

/*	let xhr=new XMLHttpRequest();
	xhr.open("GET","/springsport/courseMain?sport="+s,true);
	xhr.send();
		xhr.onreadystatechange=function(){
		if(xhr.readyState==4&&xhr.status==200){
			var result = JSON.parse(xhr.responseText);
		
	
			$("#sport").empty();
			var content = "<table class='courseTable' border='1' style='border-collapse:collapse; border:2px solid #D0D0D0; border-right:1px solid #D0D0D0; margin-left: auto; margin-right:auto;'>";
			content += "<tr><th width='70'>課程名稱</th><th width='70'>課程代號</th><th width='70'>費用</th><th width='70'>上課時間</th><th width='70'>下課時間</th><th width='100'>開始日期</th><th width='100'>結束日期</th><th width='70'>場地</th><th width='70'>老師</th><th width='100'>尚可報名人數</th><th width='70'>按下去</th></tr>";
				for(let i=0;i<result.length;i++){
					content+="<tr><td>"+result[i].courseName+"</td>"+
							"<td>"+result[i].courseKind+"</td>"+
							"<td>"+result[i].courseCost+"</td>"+
							"<td>"+result[i].time+"</td>"+
							"<td>"+result[i].studentCurrentNum+"</td>"+
							"<td><button id='"+result[i].courseId+"'  onclick='courseApply("+result[i].courseId+")'>我要報名</button></td>"+
							"</tr>";
			}
				content+="</table>";
				$("#sport").append(content);
				$("#sport").append("<button onclick='courseMain()' style='margin:20px'>返回</button>");
				
		
		}
	}*/
}
</script>
    <style>
   .courseButton{
   	margin:20px;
   }
    </style>
</head>
<body>
    <div class="container">
        <div class="div_Header" style="z-index:2">
            <div class="div_HeaderLogo">
                <a href=""><img src="Images/logo.svg" alt="" class="headerLogo"></a>
            </div>
            <div class="div_HeaderTop">
          
                <a href="">回首頁</a>
                <a href="">網頁導覽</a>
                <a href="">交通指引</a>
                <a href="">聯絡我們</a>
            </div>

            <div class="div_UL">
                <div class="ul_1">
                    <ul class="ul_list" id="aboutUs">
                        <li class="ul_head">關於我們</li>
                        <li class="aboutUs_hide"></li>
                    </ul>
                </div>
                <div class="ul_2">
                    <ul class="ul_list" id="introduce">
                        <li class="ul_head">場館介紹</li>
                        <li class="introduce_hide">5F-健身房</li>
                        <li class="introduce_hide">4F-排球</li>
                        <li class="introduce_hide">3F-壁球、桌球</li>
                        <li class="introduce_hide">2F-籃球</li>
                        <li class="introduce_hide">1F-羽毛球</li>
                        <li class="introduce_hide">B1-游泳池</li>
                    </ul>
                </div>
                <div class="ul_3">
                    <ul class="ul_list" id="announcement">
                        <li class="ul_head" onclick='badmin()'>優惠與公告</li>
                        <li class="announcement_hide">(優惠資訊)</li>
                        <li class="announcement_hide">公告</li>
                        <li class="announcement_hide">活動/課程異動</li>
                        <li class="announcement_hide">123</li>
                        <li class="announcement_hide"></li>
                    </ul>
                </div>
                <div class="ul_4">
                    <ul class="ul_list" id="activity">
                        <li class="ul_head" >活動與課程</li>
                        <li class="activity_hide">活動總覽</li>
                      <!--  <a href="<c:url value='/courseMain'/>"> 課程總覽</a> --> 
                        <li class="activity_hide">課程總覽</li>
                        <li class="activity_hide">管理活動</li>
                        <li class="activity_hide">管理課程</li>
                        <li class="activity_hide">管理老師</li>
                    </ul>
                </div>
                <div class="ul_5">
                    <ul class="ul_list" id="reservation">
                        <li class="ul_head">場地預約</li>
                        <li class="reservation_hide">剩餘場地查詢</li>
                        <li class="reservation_hide">我要預約</li>
                    </ul>
                </div>
                <div class="ul_6">
                    <ul class="ul_list" id="store">
                        <li class="ul_head">購物商城</li>
                        <li class="store_hide">123</li>
                    </ul>
                </div>
                <div class="ul_7">
                    <ul class="ul_list" id="bbs">
                        <li class="ul_head">討論區</li>
                        <li class="bbs_hide">321</li>
                    </ul>
                </div>                
            </div>
            <div class="div_HeaderLogin">
            	<button id="courseOrder">課程訂單確認</button>
            	<button id="actOrder">活動訂單確認</button>
                <a class="spLogin" href="">登入</a>
                <div style="display: inline-block; width: 10px;"></div>
                <a href="">註冊</a>
            </div>
        </div>
        <div class="div_SideL">

        </div>
        <div class="div_SideR">

        </div>
        <div class="div_Main" style="z-index:0;">
            
            <h1 class="main_Title">｜ 標題標題標題</h1>
<!--      -->
		<div >
			<div id="animation" style="text-align:center;margin:0px auto;"></div>
		</div>
	
		<div id="sport" style="text-align:center;"></div>
		
        </div>
        <div class="div_Footer">

        </div>
    </div>

</body>


</html>