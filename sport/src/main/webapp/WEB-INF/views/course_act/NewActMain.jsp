<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<meta charset="UTF-8">
<title>home</title>

<link rel="stylesheet" href="css/course.css">
<!--  <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<script type="text/javascript">

$(document).ready(function(){
	let xhr=new XMLHttpRequest();
	xhr.open("GET","/sport/activity",true);
	xhr.send();
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
			var result = JSON.parse(xhr.responseText);
			console.log(result);
			let context="";
			for(let i=0;i<result.length;i++){
				context+="<button  id='activityButton'  onclick='activity("+result[i].actId+")' >";	
				context+="<img  src='data:image/png;base64,"+result[i].actPicture+"'  width='300px' height='300px'/>";
				context+="<div>"+result[i].actName+"</div>";
				context+="</button>";
			
			}

				$("#act").append(context);
		}
	}
		
});

function activity(a){	
	var f = document.createElement("form");
	f.setAttribute('method',"get");
	f.setAttribute('action',"/sport/activityApply");
	f.setAttribute('id',"goapply");
	var i = document.createElement("input"); //input element, text
	i.setAttribute('type',"text");
	i.setAttribute('name',"actId");
	i.setAttribute('value',a);
	f.appendChild(i);
	console.log("hello"+a);
	document.getElementsByTagName('body')[0].appendChild(f);
	$("#goapply").submit();
	//var s = document.createElement("input"); //input element, Submit button
	//s.setAttribute('type',"submit");
	//s.setAttribute('value',"Submit");
	//s.setAttribute('id',"goapply");
	


}

</script>

<style type="text/css">
.title{
text-align:center;
margin-top:30px;
}
#activityButton{
margin:20px;	
}
.main_body{
text-align:center;
}


</style>
</head>
<body>
<c:import url="../newheader.jsp"/>
<div class="main_body">
<div class="course">活動總攬<hr></div>
<div id="act"></div>
</div>


</body>
</html>