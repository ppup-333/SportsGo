<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-Hant-TW">
<head>
<title></title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="/sport/scripts/bulletin/date.format.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<style>
	.box{
		margin-top:100px;
	
	}
	.box-center{
		border:1px solid black;
	}
	.title-container > h2{
/* 		text-align:left; */
	}
	.image-container{
 		width:50%; 
 		
		float:left;
	}
	.contents-container{
 		width:50%; 
		float:right;
		diplay:inline-block;
	}
	.contents-container > p{
 	
	}
	.control{
		float:left;
	}
	.clear{
		clear:both;
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
			var tempContents = data.contents.replace(/&nbsp;/g, ' ').replace(/<br\/>/g, '\r\n');
			content = "<p>" + data.contents + "</p>";
			var titleDiv = document.getElementById("title");
			var contentDiv = document.getElementById("contents");
			titleDiv.innerHTML = title;
			contentDiv.innerHTML = content;
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
<c:import url="../header.jsp"/>
<input id='bulletinId' style='display:none' value='${bulletin.id }'>
	<div class="box">
		<div class="container">
				
			<div id="title" class="title-container">
				
			</div>
			<div class="image-container">
				<div id="picutre">
					<c:choose>
						<c:when test='${bulletin.image != null}'>
							<img width='500' height='700' src='<c:url value="/Bulletin/picture/${bulletin.id }"/>'/>
						</c:when>
					</c:choose>	
				</div>
			</div>
			<div id="contents" class="contents-container">
				
			</div>
			<div class="clear"></div>
		</div>
	</div>


	<div class="container">
		<input type="button" value="更新公告" onclick="location.href='<c:url value='/Bulletin/update/${bulletin.id}'/>'"/>
		<form action="<c:url value='/'/>Bulletin/delete/${bulletin.id}" method='POST'>
			<input type='hidden' name='_method' value='delete'>
			<button type="submit" id='deletelink'>刪除公告</button>
		</form>
	
		<a href="<c:url value='/Bulletin/viewBulletin'/> " >回前頁</a>
 	</div> 





<script src="/sport/scripts/bulletin/linkify.min.js"></script>
<script src="/sport/scripts/bulletin/linkify-jquery.min.js"></script>
</body>

</html>