<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理課程</title>
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
 background-color:#AAAAFF	;
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
background-color:#F1E1FF;
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
.modal-title{

margin-right:300px;
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
		
		if(d1<10){
			convertDate=year+"-0"+month+"-0"+d1;
		}else{
			convertDate=year+"-0"+month+"-"+d1;
		}

	}else {
		if(d1<10){
			convertDate=year+"-"+month+"-0"+d1;
		}else{
			convertDate=year+"-"+month+"-"+d1;
		}
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
					console.log("第一個List:"+GetDateDiff1);
					for(let j=0;j<=GetDateDiff1;j+=7){						
						
						if(j==0){
							context+="{\"id\":\""+result[i].courseId+"\","
							context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
							context+="\"start\":\""+result[i].DateStart+"\","
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
							context+="{\"id\":\""+result[i].courseId+"\","
							context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
							context+="\"start\":\""+tempDateStart+"\","
							context+="\"constraint\":\"businessHours\"},"	
						}
										
					}
					
				}else{
					console.log("後面的List:"+GetDateDiff1);
					
					DateStart=result[i].DateStart;
					tempDateStart=DateStart;
					for(let j=0;j<=GetDateDiff1;j+=7){
						
							
						if(j==0){
							if(GetDateDiff1==0){
								context+="{\"id\":\""+result[i].courseId+"\","
								context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
								context+="\"start\":\""+result[i].DateStart+"\","
								context+="\"constraint\":\"businessHours\"}"
							}else{
								context+="{\"id\":\""+result[i].courseId+"\","
							context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
							context+="\"start\":\""+result[i].DateStart+"\","
							context+="\"constraint\":\"businessHours\"},"
							}
															
						}else if(j==GetDateDiff1){
							
							
							let tempDate=tempDateStart.substring(8);
							let intdate=parseInt(tempDate, 10);
							let date=intdate+7;
							let ym=tempDateStart.substring(0,8);
							let d=ym+date;
							completeDate=transformdate(d);
							tempDateStart=completeDate;
						
							context+="{\"id\":\""+result[i].courseId+"\","
							context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
							context+="\"start\":\""+tempDateStart+"\","
							context+="\"constraint\":\"businessHours\"}"	
						}else{
							let tempDate=tempDateStart.substring(8);
							let intdate=parseInt(tempDate, 10);
							let date=intdate+7;
							let ym=tempDateStart.substring(0,8);
							let d=ym+date;
							completeDate=transformdate(d);
							tempDateStart=completeDate;

							context+="{\"id\":\""+result[i].courseId+"\","
							context+="\"title\":\""+result[i].courseName+result[i].courseKind+"\","
							context+="\"start\":\""+tempDateStart+"\","
							context+="\"constraint\":\"businessHours\"},"	
						}
										
					}
				}
				
		      }
			context+="]";
			console.log(context);
			
			let eventCal=JSON.parse(context);
			context="";
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
		      timeZone: 'UTC+8',
		      locale: 'zh-tw',
		      eventClick:  function(info) {
		    	  //	var id=event.extendedProps.myid;
		    	  	
		    	  	console.log(info.event.id);
		    	  	 xhr.open("GET","/sport/courseUpdate?id="+info.event.id,true);
						xhr.send();
						xhr.onreadystatechange=function(){
							if(xhr.readyState==4&&xhr.status==200){
								let response=xhr.responseText;
							$('#modalTitle').html("修改課程");
							$('#modalBody').html(response);
							$('#calendarModal').modal();
							}
						}
		           // $('#modalBody').html(event.description);
		           // $('#eventUrl').attr('href',event.url);

		        },
		        select: function(info) {
		        //  var title = prompt('Event Title:');
				let today=calendar.formatDate(new Date(), {
	        	  month: 'long',
	        	  year: 'numeric',
	        	  day: 'numeric',
	        	  timeZoneName: 'short',
	        	  timeZone: 'UTC+8',
	        	  locale: 'zh-tw'
	        	});
		        let choose=calendar.formatDate(info.start, {
		        	  month: 'long',
		        	  year: 'numeric',
		        	  day: 'numeric',
		        	  timeZoneName: 'short',
		        	  timeZone: 'UTC+8',
		        	  locale: 'zh-tw'
		        	});
		        let year=today.substring(0,4);
		        
		        let mc=choose.lastIndexOf("月");
		        let mt=today.lastIndexOf("月");
		        let monthChooseInt=parseInt(choose.substring(5,mc));
		        let monthTodayInt=parseInt(today.substring(5,mt));
		        
		        let dd=choose.lastIndexOf("日");
		        let ds=today.lastIndexOf("日");
		        let chooseInt=parseInt(choose.substring(7,dd));
		        let todayInt=parseInt(today.substring(7,dd));
		        
		        
				console.log(info);
		        if(monthChooseInt<monthTodayInt){
		         	$('#modalTitle').html("");
					$('#modalBody').html("過去不復返，請選擇今天以後的課程");
					$('#calendarModal').modal();		        	
		        }else if(monthChooseInt>monthTodayInt){

		        	let ymd;
		        	if(monthChooseInt<10){
			        	if(chooseInt<10){
			        		ymd=year+"-0"+monthChooseInt+"-0"+chooseInt;
			        	}else{
			        		ymd=year+"-0"+monthChooseInt+"-"+chooseInt;
			        	}
			        }else{
			        	if(chooseInt<10){
			        		ymd=year+"-"+monthChooseInt+"-0"+chooseInt;
			        	}else{
			        		ymd=year+"-"+monthChooseInt+"-"+chooseInt;
			        	}
			        	
			        }
		        	
		        	
		        	xhr.open("GET","/sport/courseInsert?ymd="+ymd,true);
					 xhr.send();
					 xhr.onreadystatechange=function(){
						if(xhr.readyState==4&&xhr.status==200){
							let response=xhr.responseText;
						$('#modalTitle').html("新增課程");
						$('#modalBody').html(response);
						$('#calendarModal').modal();
						}
					 }		        	
		        }else{
		        	
		        	if(chooseInt<todayInt){
		        	$('#modalTitle').html("");
					$('#modalBody').html("過去不復返，請選擇今天以後的課程");
					$('#calendarModal').modal();
		        	}else{
		        		let ymd;
			        	if(monthChooseInt<10){
				        	if(chooseInt<10){
				        		ymd=year+"-0"+monthChooseInt+"-0"+chooseInt;
				        	}else{
				        		
				        	}ymd=year+"-0"+monthChooseInt+"-"+chooseInt;
				        }else{
				        	if(chooseInt<10){
				        		ymd=year+"-"+monthChooseInt+"-0"+chooseInt;
				        	}else{
				        		ymd=year+"-"+monthChooseInt+"-"+chooseInt;
				        	}
				        	
				        }
			        	
			        	
			        	xhr.open("GET","/sport/courseInsert?ymd="+ymd,true);
						 xhr.send();
						 xhr.onreadystatechange=function(){
							if(xhr.readyState==4&&xhr.status==200){
								let response=xhr.responseText;
							$('#modalTitle').html("新增課程");
							$('#modalBody').html(response);
							$('#calendarModal').modal();
							}
						 }		   
		        		
		        	}
		        	
		          }		        	
		        
		       
		        	
				/* 
	            if(check<today) {
	            	
	            }else{
	            	
	            }*/
				
          		 // $('#modalBody').html(event.description);
		           // $('#eventUrl').attr('href',event.url);

		          //calendar.unselect()
		        },
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
	<c:import url="../headerM.jsp" />
	 
	 
	<div id="calendarModal" class="modal fade">
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
        	<h4 id="modalTitle" class="modal-title"></h4>
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span> <span class="sr-only">close</span></button>
            
        </div>
        <div id="modalBody" class="modal-body"> </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
    </div>
</div>
</div>
	
	<div id="sport">
	
	<div class="course">管理課程<hr></div>

	<div class="main_body">
		
		<div class="choose">請選擇要管理的課程</div>
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