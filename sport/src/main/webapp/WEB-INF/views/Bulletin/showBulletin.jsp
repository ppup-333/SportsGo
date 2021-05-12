<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-Hant-TW">
<head>
<title></title>

<c:import url="../headerScript.jsp"/>

<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<script src="/sport/scripts/bulletin/date.format.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<style>

	
	.box{
		margin-top:20px;
		margin-bottom:100px;
	}
	.box-center{
		border:1px solid black;
	}
	.head{
		position:relative;
	}
	.head-icon{
		
		padding-top:10px;
		float:left;
		
	}
	.headTitle{
		padding-left:0px;
		padding-top:40px;
		margin:auto;
		float:left;
	}
	.update-time{
		margin-top:70px;
		float:right;
		color:gray;
	}
	.title-container {
		
		padding-top:5px;
/* 		text-align:left; */
		overflow:auto;
		color:white;
		background-color:#17A2B8;
		width:90%;
		margin-left:60px;
		border-radius:10px;
	}
	.image-contents{
		margin-top:30px;
	}
	.image-container{
 		padding-right:70px;
 		width:50%; 
		float:right;
	}
	.image{
	
		display:block;
		position:relative;
		padding:5px;
		margin-right:30px;
		border:1px solid #D7D7D7;
	}
	
	.contents-container{
		padding-left:70px;
 		width:50%;
		float:left;
		diplay:inline-block;
	}
	.contents-container > p{
 	
	}
	.control{
		float:left;
	}
	.clear{
		margin-top:20px;
		clear:both;
	}
	hr.style-one {
	    border: 0;
	    height: 1px;
	    background: #333;
	    background-image: linear-gradient(to right, #ccc, #333, #ccc);
	}

</style>
<script type='text/javascript'>
window.onload = function(){
	var Id = document.getElementById("bulletinId").value;
	dataUrl = "<c:url value='/'/>Bulletin/getContent/" + Id;
	console.log(Id);
	var xhr = new XMLHttpRequest();
	xhr.open('GET', dataUrl, true);
	xhr.send();
	xhr.onreadystatechange = function() {
		if (this.readyState === 4 && this.status === 200) {
			var data = JSON.parse(this.responseText);
			console.log(data);
			var title = "<h4>【"+data.class_id.name+"】" + data.title + "</h4>"
			var updatetime = new Date(data.update_time).format("Y-m-d");
			 	updatetime = "<span><i class='far fa-clock'></i>" + updatetime + "</span>";
			var tempContents = data.contents.replace(/&nbsp;/g, ' ').replace(/<br\/>/g, '\r\n');
			content = "<p>" + data.contents + "</p>";
			var titleDiv = document.getElementById("title");
			var contentDiv = document.getElementById("contents");
			var updatetimeDiv = document.getElementById("update-time");
			titleDiv.innerHTML = title;
			contentDiv.innerHTML = content;
			updatetimeDiv.innerHTML = updatetime;
			$('p').linkify();
			$('#contents').linkify({
			    target: "_blank"
			});
		}
	}
	
// 	$('p').linkify();
// 	$('#sidebar').linkify({
// 	    target: "_blank"
// 	});


// 	getImageUrl = "<c:url value='/' />Bulletin/Picture/" + Id;
// 	var xhr2 = new XMLHttpRequest();
// 	xhr2.open("GET", get ImageUrl, true);
// 	xhr2.send();
// 	xhr2.onreadystatechange = function() {
// 		if (this.readyState === 4 && this.status === 200){
// 				var data = JSON.parse(this.responseText);
// 				var img = "<img width='60' height='72' src=
// 			}
// 		}
}

// var contents = document.getElementById("contents").value;
// console.log(contents);
// contents = contents.replace(/<br>/g,"\n");








$(document).ready(function() {
    $('#deletelink').click(function() {
    	if (confirm('確定刪除公告? ')) {
            submit();
    	} 
    	return false;
        
    });
})


</script>
<body>
<c:import url="../newheader.jsp"/>
<input id='bulletinId' style='display:none' value='${bulletin.id }'>
		
	<div class="box">
		<div class="container">
			
			<div class="head">

				<div class="head-icon">
				<img src="/sport/images/bulletin/running1.png" width="80" height="80"></img>
				</div>

				<h2 style="font-weight:bold;" class="headTitle">公告內容</h2>
				<div id="update-time"  class="update-time">
				</div>
			</div>
			
			
			
			<div class="clear"></div>
			<hr class="style-one" />
			<div id="title" class="title-container">
				
			</div>
			
			<div class="clear"></div>
				<div class="image-container">
					<div id="picutre" class="image">
						<c:choose>
							<c:when test='${bulletin.image != null}'>
								<img width='100%' height='100%' src='<c:url value="/Bulletin/picture/${bulletin.id }"/>'/>
							</c:when>
						</c:choose>	
					</div>
				</div>
				<div id="contents" class="contents-container">	
				</div>
			<div class="clear"></div>
			<br>
			<hr class="style-one" />
			<div class="back-btn" style="text-align:center">
				<button  type="button" class="btn btn-outline-dark" onclick="location.href='/sport/Bulletin/viewBulletin'">返回列表</button>
			</div>
<%-- 		<a href="<c:url value='/Bulletin/viewBulletin'/> " >回前頁</a> --%>
		</div>
	</div>


<!-- 	<div class="container"> -->
<%-- 		<input type="button" value="更新公告" onclick="location.href='<c:url value='/Bulletin/update/${bulletin.id}'/>'"/> --%>
<%-- 		<form action="<c:url value='/'/>Bulletin/delete/${bulletin.id}" method='POST'> --%>
<!-- 			<input type='hidden' name='_method' value='delete'> -->
<!-- 			<button type="submit" id='deletelink'>刪除公告</button> -->
<!-- 		</form> -->
	
		
 





<script src="/sport/scripts/bulletin/linkify.min.js"></script>
<script src="/sport/scripts/bulletin/linkify-jquery.min.js"></script>
</body>

</html>