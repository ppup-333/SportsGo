<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理活動</title>
 <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
 <link rel="stylesheet" href="css/course.css">
 <link rel="stylesheet" href="css/loader.css">
<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function() {
	$("#animation").addClass("loader");	
	let xhr=new XMLHttpRequest();
	xhr.open("GET","/sport/activity",true);
	xhr.send();
	xhr.onreadystatechange=function(){
		if(xhr.readyState==4&&xhr.status==200){
			var result = JSON.parse(xhr.responseText);
			console.log(result);
			let context="<table border='1'>";
			/*activityMap.put("actPicture", alist.get(i).getActPicture());
			activityMap.put("actCost", alist.get(i).getActCost());
			activityMap.put("actMaxNum", alist.get(i).getActMaxNum());
			activityMap.put("actCurrentNum", alist.get(i).getActCurrentNum());
			activityMap.put("actName", alist.get(i).getActName());
			activityMap.put("TimeStart", time.getTimeStart());
			activityMap.put("TimeEnd", time.getTimeEnd());
			activityMap.put("DateStart", DateStart);
			activityMap.put("DateEnd", DateEnd);*/
				context+="<tr><th>活動編號<th>活動名稱<th>活動費用<th>開始時間<th>結束時間<th>開始日期<th>結束日期<th>活動最大人數<th>目前活動人數<th>活動照片<th><th>"
			for(let i=0;i<result.length;i++){
				context+="<tr>";
				context+="<td>"+result[i].actId+"<td>"+result[i].actName+"<td>"+result[i].actCost+
					  	"<td>"+result[i].TimeStart+"<td>"+result[i].TimeEnd+"<td>"+result[i].DateStart+
					  	"<td>"+result[i].DateEnd+"<td>"+result[i].actMaxNum+"<td>"+result[i].actCurrentNum+
					  	"<td>"+"<img  src='data:image/png;base64,"+result[i].actPicture+"' width='100px' height='100px'/>"+
						"<td><button>修改</button>"+
						"<td><button>刪除</button>";
			}
			$("#animation").removeClass("loader");	
			context+="</table>"
			$("#actList").append(context);
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
<c:import url="../headerM.jsp" />
<div class="course">管理活動<hr></div>
<div id="animation"></div>
<div class="main_body">
	<div id="actList"></div>
	<button id="insert">新增</button>
</div>
</body>
</html>