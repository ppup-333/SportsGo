<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-Hant-TW">
<head>
<title></title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<style>
	.text {
		width: 500px;
		border: 1px solid black;
		word-break: break-all;
        word-wrap: break-word;
        white-space: pre-wrap;
	}
	#id {
		text-align:center;
	}
	#contents{
		text-align:left;
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
			var title = "<h2>" + data.title + "</h2>"
			var tempContents = data.contents.replace(/&nbsp;/g, ' ').replace(/<br\/>/g, '\r\n');
			content = "<p>" + tempContents + "</p>";
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
<div id="view" align='center'>
	<input id='bulletinId' type='hidden' value='${bulletin.id }'>
		
	<div id="title" class="text">
		
	</div>
	<div id="contents" class="text">
		
	</div>
	<div id="picutre">
		<c:choose>
			<c:when test='${bulletin.image != null}'>
				<img width='120' height='144' src='<c:url value="/Bulletin/picture/${bulletin.id }"/>'/>
			</c:when>
		</c:choose>	
	</div>
</div>
<div align="center">
	<input type="button" value="更新公告" onclick="location.href='<c:url value='/Bulletin/update/${bulletin.id}'/>'"/>
	<form action="<c:url value='/'/>Bulletin/delete/${bulletin.id}" method='POST'>
		<input type='hidden' name='_method' value='delete'>
		<button type="submit" id='deletelink'>刪除公告</button>
	</form>
<%-- 	<a class='deletelink' href="<c:url value='/'/>Bulletin/delete/${bulletin.id}" >刪除公告</a> --%>
	<a href="<c:url value='/Bulletin/showAllBulletin'/> " >回前頁</a>
</div>

<script src="/sport/scripts/bulletin/linkify.min.js"></script>
<script src="/sport/scripts/bulletin/linkify-jquery.min.js"></script>
</body>

</html>