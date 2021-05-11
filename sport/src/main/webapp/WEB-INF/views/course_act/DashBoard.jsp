<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<meta charset="UTF-8">
<title>DashBoard</title>
<link rel="stylesheet" href="css/course.css">
<link rel="stylesheet" href="css/loader.css">
<!--  <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
<style type="text/css">
.main_body{
text-align:center;
}

.situation{
	 background-color:#008CBA;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  cursor: pointer;
  margin:20px;
  height:150px;
	
}
.cost{
display:none;
}
.count{
display:none;
}
</style>
<script type="text/javascript">
//var table = new google.visualization.Table(document.getElementById('table_div'));



	
function drawVisualization() {
	let badmintonCount=$("#badmintonCount").text();
	let badmintonCountInt=parseInt(badmintonCount);
	let tennisBallCount=$("#tennisBallCount").text();
	let tennisBallCountInt=parseInt(tennisBallCount);
	let basketballCount=$("#basketballCount").text();
	let basketballCountInt=parseInt(basketballCount);
	  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
	  var data = google.visualization.arrayToDataTable([
		  ['Task', 'Hours per Day'],
	      ['羽球',     badmintonCountInt],
	      ['桌球',     tennisBallCountInt],
	      ['籃球',     basketballCountInt],	 
	  ]);
	  var options = {
			    title: '運動種類占比'
			  };
	  chart.draw(data, options);

	}
/*
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	let badmintonCount=$("#badmintonCount").text();
	let badmintonCountInt=parseInt(badmintonCount);
	let tennisBallCount=$("#tennisBallCount").text();
	let tennisBallCountInt=parseInt(tennisBallCount);
	let basketballCount=$("#basketballCount").text();
	let basketballCountInt=parseInt(basketballCount);
	
  var data = google.visualization.arrayToDataTable([
	  ['Task', 'Hours per Day'],
      ['羽球',     badmintonCountInt],
      ['桌球',     tennisBallCountInt],
      ['籃球',     basketballCountInt],
 

  ]);

  var options = {
    title: '運動種類占比'
  };

  var chart = new google.visualization.PieChart(document.getElementById('piechart'));

  chart.draw(data, options);
}
*/



$(document).ready(function(){
		
	$("#MyPieChart").on("click",function(){
		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawVisualization);
	});
	
	$("#course").on("click",function(){
	console.log("hello");
	let xhr=new XMLHttpRequest();
	xhr.open("GET","/sport/OrderController/courseDetail",true);
	xhr.send();
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				var result = JSON.parse(xhr.responseText);
				console.log(result);
			}
			
		}
			
	});
	$("#act").on("click",function(){
		console.log("hello");
		let xhr=new XMLHttpRequest();
		xhr.open("GET","/sport/OrderController/actDetail",true);
		xhr.send();
			xhr.onreadystatechange=function(){
				if(xhr.readyState==4&&xhr.status==200){
					var result = JSON.parse(xhr.responseText);
					console.log(result);
					console.log(result.length);
					console.log(result[0]);
					
				}
				
			}
				
		});
});

</script>
</head>
<body>
<c:import url="../newheaderM.jsp" />

<div class="course">DashBoard<hr></div>
<div class="main_body">
<h1>本月累積總業績</h1>
<h2>${total}</h2>
<div>
<c:forEach var="item1" items="${sportMap['羽球']}" varStatus="status">
<div class='cost'>${item1}</div>
<c:if test="${status.last}">
<div class='count' id="badmintonCount">${status.count}</div>
</c:if>

</c:forEach>
<c:forEach var="item1" items="${sportMap['桌球']}" varStatus="status">
<div class='cost'>${item1}</div>
<c:if test="${status.last}">
<div class='count' id="tennisBallCount">${status.count}</div>
</c:if>

</c:forEach>
<c:forEach var="item1" items="${sportMap['籃球']}" varStatus="status">
<div class='cost'>${item1}</div>
<c:if test="${status.last}">
<div class='count' id="basketballCount">${status.count}</div>
</c:if>

</c:forEach>

 </div>
<div class='courseAndAct'>
<!--  <button class='situation' id='course' value='${mapCourse}'>課程報名詳情</button><button class='situation' id='act'>活動報名詳情</button>-->
<button class='situation' id='MyPieChart'>圓餅圖</button><button class='situation' id='Mychart'>柱狀圖</button>
<div id="piechart" style="width: 900px; height: 500px;"></div>
</div>


</div>
</body>
</html>