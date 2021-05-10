<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<link rel="stylesheet" href="css/course.css">
<link rel="stylesheet" href="css/loader.css">
<link href='lib/main.css' rel='stylesheet' />
<script src='lib/main.js'></script>
<style type="text/css">
.main_body {
	text-align: center;
}

.choose{
font-size:30px;
}
.courseButton{
 background-color:	#ECF5FF;
border-radius: 20%;
margin:20px;
padding:-20px;
border: none;

}
.courseImage{
	width: 300px;
        height: 300px;
        opacity: 90%;
        margin: 5px;
         border-radius: 50%;
         
}
.courseBackground{

margin:0 auto;
width: 1200px;
background-color:#F3F3FA;
 border-radius:10px;
}
.centered {        
     position: relative;
    top: -30px;
    font-size: 50px;
     margin-top:20px;
   margin-bottom:-40px;
    color:white;
    font-weight:bold;
    -webkit-text-stroke: 1px black;
    
    }
#calendar{
width: 1200px;
margin:0 auto;
}
</style>
<script type="text/javascript">
function transformdate(d){
	let d1=parseInt(d.substring(8));
	let month=parseInt(d.substring(5,7));
	let year=parseInt(d.substring(0,4));
	
	if(month==1||month==3||month==5||month==7||month==8||month==10||month==12) {
		if(d1>31) {
			if(month>12) {
				year=year+1;
				month=1;
			}else {
				month=month+1;
			}
			d1=d1-31;
		}
	}else {
		
		if(month==2) {
			if(d1>28) {
				month=month+1;
				d1=d1-28;
			}
		}else {
			if(d1>30) {
				month=month+1;
				d1=d1-30;
			}
		}	
	}
	
	if(month<10) {
		convertDate=year+"-0"+month+"-"+d1;
	}else {
		convertDate=year+"-"+month+"-"+d1;
	}
	return convertDate;
}


var DateDiff = function (sDate1, sDate2) { // sDate1 和 sDate2 是 2016-06-18 格式
	  var oDate1 = new Date(sDate1);
	  var oDate2 = new Date(sDate2);
	  var iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 / 24); // 把相差的毫秒數轉換為天數
	  return iDays;
	};

document.addEventListener('DOMContentLoaded', function() {
    
  });
function sport(s){
	$("#animation").addClass("loader");		
	let xhr=new XMLHttpRequest();
	xhr.open("GET","/sport/courseMain?sport="+s,true);
	xhr.send();
	xhr.onreadystatechange=function(){
		if(xhr.readyState==4&&xhr.status==200){
			var result = JSON.parse(xhr.responseText);
			console.log(result);
			
			let context="[";
			for(let i=0;i<result.length;i++){
				DateStart=result[i].DateStart;
				DateEnd=result[i].DateEnd;

				var GetDateDiff1 = DateDiff(DateStart,DateEnd); 			
				if(i!=(result.length-1)){
					
					DateStart=result[i].DateStart;
					tempDateStart=DateStart;
					for(let j=0;j<=GetDateDiff1;j+=7){						
						
						if(j==0){
							context+="{\"groupId\":\""+result[i].courseId+"\","
							context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
							context+="\"start\":\""+result[i].DateStart+"\","
							context+="\"url\":\"/sport/courseApply?id="+result[i].courseId+"&type=first\","
							context+="\"constraint\":\"businessHours\"},"	
							
						}else{

							let tempDate=tempDateStart.substring(8);
							let intdate=parseInt(tempDate, 10);
							let date=intdate+7;
							let ym=tempDateStart.substring(0,8);
							let d=ym+date;
							completeDate=transformdate(d);
							tempDateStart=completeDate;
							console.log(completeDate);
							context+="{\"groupId\":\""+result[i].courseId+"\","
							context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
							context+="\"start\":\""+tempDateStart+"\","
							context+="\"url\":\"/sport/courseApply?id="+result[i].courseId+"&type=first\","
							context+="\"constraint\":\"businessHours\"},"	
						}
										
					}
					
				}else{
					
					DateStart=result[i].DateStart;
					tempDateStart=DateStart;
					for(let j=0;j<=GetDateDiff1;j+=7){
						
							let tempDate=tempDateStart.substring(8);
							let intdate=parseInt(tempDate, 10);
							let date=intdate+7;
							let ym=tempDateStart.substring(0,8);
							let d=ym+date;
							completeDate=transformdate(d);
							tempDateStart=completeDate;
							console.log(completeDate);
						if(j==0){
							if(GetDateDiff1==0){
								context+="{\"groupId\":\""+result[i].courseId+"\","
								context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
								context+="\"start\":\""+result[i].DateStart+result[i].courseKind+"\","
								context+="\"url\":\"/sport/courseApply?id="+result[i].courseId+"&type=first\","
								context+="\"constraint\":\"businessHours\"}"
							}else{
								context+="{\"groupId\":\""+result[i].courseId+"\","
								context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
								context+="\"start\":\""+result[i].DateStart+"\","
								context+="\"url\":\"/sport/courseApply?id="+result[i].courseId+"&type=first\","
								context+="\"constraint\":\"businessHours\"},"
							}
												
						}else if(j==GetDateDiff1){							
							context+="{\"groupId\":\""+result[i].courseId+"\","
							context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
							context+="\"start\":\""+tempDateStart+"\","
							context+="\"url\":\"/sport/courseApply?id="+result[i].courseId+"&type=first\","
							context+="\"constraint\":\"businessHours\"}"	
						}else{
							context+="{\"groupId\":\""+result[i].courseId+"\","
							context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
							context+="\"start\":\""+tempDateStart+"\","
							context+="\"url\":\"/sport/courseApply?id="+result[i].courseId+"&type=first\","
							context+="\"constraint\":\"businessHours\"},"	
						}
										
					}
				}
				
		      }
			context+="]";
			console.log(context);
			
			let eventCal=JSON.parse(context);
			$("#animation").removeClass("loader");
			var calendarEl = document.getElementById('calendar');
			
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		      headerToolbar: {
		        left: 'prev,next today',
		        center: 'title',
		        right: 'dayGridMonth'
		    //    right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
		      },
		      initialDate: result[0].DateStart,
		      navLinks: true, // can click day/week names to navigate views
		      businessHours: true, // display business hours
		      editable: true,
		      selectable: true,
		      locale: 'zh-tw',
		      events: eventCal
		      
		      /*events: [
		        {
		          title: 'Business Lunch',
		          start: '2020-09-03T13:00:00',
		          constraint: 'businessHours'
		        },
		        {
		          title: 'Meeting',
		          start: '2020-09-13T11:00:00',
		          constraint: 'availableForMeeting', // defined below
		          color: '#257e4a'
		        },
		        {
		          title: 'Conference',
		          start: '2020-09-18',
		          end: '2020-09-20'
		        },
		        {
		          title: 'Party',
		          start: '2020-09-29T20:00:00'
		        },

		        // areas where "Meeting" must be dropped
		        {
		          groupId: 'availableForMeeting',
		          start: '2020-09-11T10:00:00',
		          end: '2020-09-11T16:00:00',
		          display: 'background'
		        },
		        {
		          groupId: 'availableForMeeting',
		          start: '2020-09-13T10:00:00',
		          end: '2020-09-13T16:00:00',
		          display: 'background'
		        },

		        // red areas where no events can be dropped
		        {
		          start: '2020-09-24',
		          end: '2020-09-28',
		          overlap: false,
		          display: 'background',
		          color: '#ff9f89'
		        },
		        {
		          start: '2020-09-06',
		          end: '2020-09-08',
		          overlap: false,
		          display: 'background',
		          color: '#ff9f89'
		        }
		      ]*/
		    });
		    
		    
		   // $('#calendar').fullCalendar( 'renderEvent',eventCal, true);
		    calendar.render();

		/*	for(let i=0;i<result.length;i++){
				
			}*/
			//$('#sport').html(result);
		}
	}
	
	/* $.ajax({
	     url: "/sport/courseMain?sport="+s,
	     context: document.body,
	    success: function(response){
	      $('#sport').html(response);
	    }
	  });*/
		
}
</script>

</head>
<body>
	<c:import url="../header.jsp" />
	<div id="sport">
	
	<div class="course">課程總攬<hr></div>

	<div class="main_body">
		
		<div class="choose">請選擇課程</div>
		<div class="courseBackground">
		<button type='button' onclick='sport(1)' class='courseButton'>
			<img class='courseImage' src='images/badminton.jpg'>
			<div class="centered">羽球</div>
		</button>		
	<button type='button' onclick='sport(2)' class='courseButton'>
			<img class='courseImage' src='images/tableTennis.jpg'>
			<div class="centered">桌球</div>
		</button>
		
	
		<button type='button' onclick='sport(3)' class='courseButton'>
			<img class='courseImage' src='images/baseketball.jpg'>
			<div class="centered">籃球</div>
		</button>
		
		</div>
		
	</div>
	<div id="animation"></div>
	 <div id="calendar"></div>

</div>

</body>
</html>