<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="zh-Hant-TW">
<head>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="/sport/scripts/bulletin/date.format.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>最新消息</title>
</head>
<style>
	.box{
		margin-left:auto;
		margin-right:auto;
	}
	.container{
		border: 1px solid black;
	}
	.news-container{
	overflow:inherit;
		border:2px solid red;
		height:200px;
	}
	.title-container{
		margin-top:40px;
		margin-left:40px;
		margin-bottom:0;
 		height:45px; 
/* 		width:800px; */
/* 		border:1px solid orange; */
	}
	
	.news-col0, .news-col1, .news-col2, .news-col3{
		margin:auto;
/* 		border:1px solid #FFAC55; */

		float:left;
	}
	.news-time0, .news-time1, .news-time2, .news-time3{
		margin:auto;
		margin-top:5px;
		margin-right:40px;
/* 		border:1px solid red; */

		text-align:right;
		color:gray;
		font-size:0.9em;
		float:right;
	}
	.subtitle-container0, .subtitle-container1, .subtitle-container2, .subtitle-container3{
		
		margin-left:70px;
	}
	.title{
/* 		border:2px solid yellow; */
	}
	.pagination-container{
		height:45px;
		margin:auto;
		border:2px solid black;
	}
	hr.style-one {
	    border: 0;
	    height: 1px;
	    background: #333;
	    background-image: linear-gradient(to right, #ccc, #333, #ccc);
	}
</style>

<script>
	$(document).ready(function(){
		showBulletin(1);
		generatePage();
		
	})
function generatePage(){
		$.getJSON("getPageInfo?classId=" + globalClassId,function(data){
				console.log(data.totalPage);
				console.log(data.totalBulletin);
			});	
		}
	
function showBulletin(nowPage) {
	globalClassId = 0;
	dataUrl = "bulletinPaging/" + nowPage
	var xhr = new XMLHttpRequest()
	xhr.open('GET', dataUrl, true)
	xhr.send()
	xhr.onreadystatechange = function() {
		if (this.readyState === 4 && this.status === 200) {
			var data = JSON.parse(this.responseText);
			console.log(data);
			
			$.each(data, function(index, bulletin){
				var updateTime = new Date(bulletin.update_time).format("Y-m-d");
				$('.news-col' + index).html('<h5 class="title">'+ '【' + bulletin.class_id.name + '】' + bulletin.title + '</h5>');
				$('.news-time' + index).html('<p>' + updateTime + '</p>');
				$('.subtitle-container' + index).html('<p>' + bulletin.subtitle + '</p>');
			});
			
// 			$.getJSON("getPageInfo?classId=" + globalClassId, function(data){
// 				$("#").empty();
// 				$('#').append($('<p>').text('總頁數:' + data.totalPage));
				
// 			});
		}
	}
}
</script>


<body>
<c:import url="../header.jsp"/>
	<div class="box">
		<div class="container">
			<div class="bulletinAdv">
			</div>
			
			<hr class="style-one" />
			<div class="news-container">
				<div class="title-container">
					<div class="news-col0">
					</div>
					<div class="news-time0">
					</div>
				</div>
				<div class="sub-container0">
					<div class="subtitle-container0">
						
					</div>
					<div class="showContentbtn0">
					</div>
				</div>
			</div>
			<hr class="style-one" />
			<div class="news-container">
				<div class="title-container">
					<div class="news-col1">
					</div>
					<div class="news-time1">
					</div>
				</div>
				<div class="sub-container1">
					<div class="subtitle-container1">
						
					</div>
					<div class="showContentbtn1">
					</div>
				</div>
			</div>
			<hr class="style-one" />
		
			<div class="news-container">
				<div class="title-container">
					<div class="news-col2">
					</div>
					<div class="news-time2">
					</div>		
				</div>
				<div class="sub-container2">
					<div class="subtitle-container2">
						
					</div>
					<div class="showContentbtn2">
						<a href="#" id="showContentLink">
							<img>
						</a>
					</div>
				</div>
			</div>
			
			<hr class="style-one" />
	
			<div class="news-container">
				<div class="title-container">
					<div class="news-col3">
					</div>
					<div class="news-time3">
					</div>
				</div>
				<div class="sub-container3">
					<div class="subtitle-container3">
						
					</div>
					<div class="showContentbtn3">
					</div>
				</div>
			</div>
		</div>
		<div class="pagination-container">
			<ul	class="pagination">
			</ul>
		</div>
	</div>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</body>
</html>