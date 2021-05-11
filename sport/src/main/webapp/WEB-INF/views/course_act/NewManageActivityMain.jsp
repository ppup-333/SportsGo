<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理活動</title>
<c:import url="../headerScript.jsp"/>
<!--  <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
 <link rel="stylesheet" href="css/course.css">
 <link rel="stylesheet" href="css/loader.css">
 <link href='lib/main.css' rel='stylesheet' />
<script src='lib/main.js'></script>
<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function() {
	$("#animation").addClass("loader");	
	let xhr=new XMLHttpRequest();
	xhr.open("GET","/sport/activity",true);
	xhr.send();
	xhr.onreadystatechange=function(){
		if(xhr.readyState==4&&xhr.status==200){
		/*	var result = JSON.parse(xhr.responseText);
			console.log(result);
			let context="<table border='1'>";
				context+="<tr><th>活動編號<th>活動名稱<th>活動費用<th>開始時間<th>結束時間<th>開始日期<th>結束日期<th>活動最大人數<th>目前活動人數<th>活動照片<th><th>"
			for(let i=0;i<result.length;i++){
				context+="<tr>";
				context+="<td>"+result[i].actId+"<td>"+result[i].actName+"<td>"+result[i].actCost+
					  	"<td>"+result[i].TimeStart+"<td>"+result[i].TimeEnd+"<td>"+result[i].DateStart+
					  	"<td>"+result[i].DateEnd+"<td>"+result[i].actMaxNum+"<td>"+result[i].actCurrentNum+
					  	"<td>"+"<img  src='data:image/png;base64,"+result[i].actPicture+"' width='100px' height='100px'/>"+
						"<td><button id='"+result[i].actId+"' onclick='update()'>修改</button>"+
						"<td><button id='"+result[i].actId+"' onclicl='delete()'>刪除</button>";
			}
			context+="</table>"
			$("#actList").append(context);*/
			
			var result = JSON.parse(xhr.responseText);
			console.log(result);			
			let context="[";

					for(let i=0;i<result.length;i++){												
						if(i==(result.length-1)){
							context+="{\"id\":\""+result[i].actId+"\","
							context+="\"title\":\""+result[i].actName+"\","
							context+="\"start\":\""+result[i].DateStart+"T"+result[i].TimeStart+"\","
							context+="\"end\":\""+result[i].DateEnd+"T"+result[i].TimeEnd+"\"}"								
						}else{
							context+="{\"id\":\""+result[i].actId+"\","
							context+="\"title\":\""+result[i].actName+"\","
							context+="\"start\":\""+result[i].DateStart+"T"+result[i].TimeStart+"\","
							context+="\"end\":\""+result[i].DateEnd+"T"+result[i].TimeEnd+"\"},"					
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
		      },
		      initialDate: result[0].DateStart,
		      navLinks: true, 
		      businessHours: true, 
		      editable: true,
		      selectable: true,
		      timeZone: 'UTC+8',
		      locale: 'zh-tw',
		      eventClick:  function(info) {		    	  	
		    	  	console.log(info.event.id);
		    	  	 xhr.open("GET","/sport/actUpdate?id="+info.event.id,true);
						xhr.send();
						xhr.onreadystatechange=function(){
							if(xhr.readyState==4&&xhr.status==200){
								let response=xhr.responseText;
							$('#modalTitle').html("修改活動");
							$('#modalBody').html(response);
							$('#calendarModal').modal();
							}
						}
		      },
		        select: function(info) {

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
					$('#modalBody').html("過去不復返，請選擇今天以後的活動");
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
		        	
		        	
		        	xhr.open("GET","/sport/activityInsert?ymd="+ymd,true);
					 xhr.send();
					 xhr.onreadystatechange=function(){
						if(xhr.readyState==4&&xhr.status==200){
							let response=xhr.responseText;
						$('#modalTitle').html("新增活動");
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
			        	
			        	
			        	xhr.open("GET","/sport/activityInsert?ymd="+ymd,true);
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

		        },
		      events:   eventCal 	  
		    	  /*[
		    	  {
		           title: 'Conference',
		           start: '2021-04-18',
		           end: '2021-04-20'
		            },
		    	  {
		    	 id:2061,
		    	  title: '桌球比賽',
		    	  start: '2021-04-29T09:00',
		    	  end: '2021-04-30T17:00'
		    	  },
		    	  {
		    	   id:2062,
		    	   title:'羽球比賽',
		    	   start:'2021-05-03',
		    	   end:'2021-05-03'
		    	   }
		    	  ]*/
		       

		    });

		    calendar.render();
	
		}
	}
		
			
});
</script>
<style type="text/css">
table{
margin-right:auto;
margin-left:auto;
text-align:center;
}
.main_body{
text-align:center;
}
#insert{
	margin:20px;
}
</style>
</head>
<body>
<c:import url="../newheaderM.jsp" />
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
<div class="course">管理活動<hr></div>
<div id="animation"></div>
<div class="main_body">
	<div id="actList"></div>
	 <div id="calendar"></div>
</div>
</body>
</html>