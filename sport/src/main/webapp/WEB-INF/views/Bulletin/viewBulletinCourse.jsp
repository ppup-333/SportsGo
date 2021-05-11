<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="zh-Hant-TW">
<head>
<c:import url="../headerScript.jsp"/>

<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<script src="/sport/scripts/bulletin/date.format.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>課程異動</title>
</head>
<style>
	.box{
		margin-left:auto;
		margin-right:auto;
	}
	.container{
/* 		border: 3px solid black; */
	}
	.news-container{
		overflow:inherit;
/* 		border:2px solid red; */
		height:150px;
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
		margin:auto;
		
/* 		border:1px solid black; */
		margin-left:70px;
		float:left;
	}
	.showContentBtn0, .showContentBtn1, .showContentBtn2, .showContentBtn3{
		margin:auto;
		margin-top:30px;
		margin-right:40px;
/* 		border:1px solid red; */
		text-align:right;
		float:right;
	}
	.title{
/* 		border:2px solid yellow; */
	}
	.pagination-container{
		margin-top:5px;
		float: right;
		left: -50%;
		position: relative;
		
	}
	.pagination{
		float:left;
		left: 50%;
		position: relative;
	}
	.pagination>li{

	}
	hr.style-one {
	    border: 0;
	    height: 1px;
	    background: #333;
	    background-image: linear-gradient(to right, #ccc, #333, #ccc);
	}
	.chosen > a{
		background:	#E0E0E0;
	}
	.myMOUSE{ cursor: pointer; }
</style>

<script>

	
	$(document).ready(function(){
// 		showBulletin(1);
		generatePage(1);
		
	})
function generatePage(currentPage){
		$.getJSON("getPageInfo?classId=" + 2,function(data){
				console.log(data.totalPage);
				console.log(data.totalBulletin);
				console.log(currentPage);
				$(".pagination li").remove();
				
				for(var i = 0; i < 4; i++){
					$('.news-col' + i).empty();
					$('.news-time' + i).empty();
					$('.subtitle-container' + i).empty();
					$('#showContentLink' + i).empty();
				}
				showBulletin(currentPage);
				
// 				var content = '<li id="prevPage" class="page-item"><a class="page-link" href="#">Previous</a></li>'
// 				for(var i = 1; i <= data.totalPage; i++){
// 					content += '<li id="page' + i + '" class="page-item"><a class="page-link" href="#">' + i + '</a></li>'
// 				}
				
// 				content += '<li id="nextPage" class="page-item"><a class="page-link" href="#">Next</a></li>';
// 				$('.pagination').html(content);
				var total = data.totalPage;
				var pageNum = currentPage;
				var firstPage = 1;
				var prePage = pageNum - 1;//上一页
				var nextPage = pageNum + 1;//下一页
				var lastPage = total;
				
				var firstPageStr = "generatePage(1)";
				var prePageStr = "generatePage("+ prePage +")";
				var nextPageStr = "generatePage("+ nextPage +")";
				var lastPageStr = "generatePage("+ lastPage +")";
				
				
				if(currentPage == lastPage){
					
				}
				 //做判断，满足某些条件时，不能点击
				 //生成首頁
				if(firstPage == pageNum){
// 					$('.pagination').append('<li class="page-item"><a class="page-link"   onclick="" >首頁</a></li>');
				}else{
// 					$('.pagination').append('<li class="page-item"><a class="page-link myMOUSE"  onclick="'+firstPageStr+'" >首頁</a></li>');
				}//上一頁
				if(prePage<=0){
// 					$('.pagination').append('<li class="page-item"><a class="page-link"   onclick="" >上一頁</a></li>');
				}else{
					$('.pagination').append('<li class="page-item"><a class="page-link myMOUSE"   onclick="'+prePageStr+'" >上一頁</a></li>');
				}
			
				if(pageNum <= 3){
					for(var i=1; i<=(total<=5?total:5); i++){
						if(i==pageNum){
							$('.pagination').append('<li class="page-item"><a id="link'+i+'" class="page-link myMOUSE"  onclick="" >'+ i +'</a></li>');
						}else{
							var pageNumber = "generatePage("+ i +")"
							$('.pagination').append('<li class="page-item"><a id="link'+i+'" class="page-link myMOUSE"  onclick="'+ pageNumber + '" >'+ i +'</a></li>');
						}
					}
				}else if(pageNum > 3 && total <= (pageNum+2)){
					for(var i = total - 4; i <=total; i++){
						if(i == pageNum){
							$('.pagination').append('<li class="page-item"><a id="link'+i+'" class="page-link myMOUSE"  onclick="" >'+ i +'</a></li>');
						}else{
							var pageNumber = "generatePage("+ i +")"
							$('.pagination').append('<li class="page-item"><a id="link'+i+'" class="page-link myMOUSE"  onclick="'+ pageNumber + '" >'+ i +'</a></li>');
						}
					}
				}else if(pageNum > 3 && total > (pageNum + 2)){
					for(var i = pageNum - 2; i <= pageNum + 2; i ++){
						if(i == pageNum){
							$('.pagination').append('<li class="page-item"><a id="link'+i+'" class="page-link myMOUSE"  onclick="" >'+ i +'</a></li>');
						}else{
							var pageNumber = "generatePage("+ i +")"
							$('.pagination').append('<li class="page-item"><a id="link'+i+'" class="page-link myMOUSE"  onclick="'+ pageNumber + '" >'+ i +'</a></li>');
						}
					}
				}
				
				if(nextPage <= 0 || nextPage > total){
// 					$('.pagination').append('<li class="page-item"><a class="page-link"  onclick="">下一頁</a></li>');
				}else{
					$('.pagination').append('<li class="page-item"><a class="page-link myMOUSE"  onclick="'+nextPageStr+'">下一頁</a></li>');
				}
				if(lastPage == pageNum){
// 					$('.pagination').append('<li class="page-item"><a class="page-link"  onclick="">尾頁</a></li>');
				}else{
// 					$('.pagination').append('<li class="page-item"><a class="page-link myMOUSE"  onclick="'+lastPageStr+'">尾頁</a></li>');
				}
				$('#link' + currentPage).parent().addClass("chosen");
			});	
		}
	
function showBulletin(nowPage) {
	
	globalClassId = 0;
	dataUrl = "bulletinPagingClass?nowPage=" + nowPage + "&classId=2";
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
				$('.news-time' + index).html('<p><i class="far fa-clock"></i>' + updateTime + '</p>');
				$('.subtitle-container' + index).html('<p>' + bulletin.subtitle + '</p>');
				$('#showContentLink' + index).attr("href","/sport/Bulletin/showBulletinContent/" + bulletin.id).html('<img src="/sport/images/bulletin/button_readmore.png" width="90px" height="30px">');
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
<c:import url="../newheader.jsp"/>
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
					<div class="showContentBtn0">
						<a href="#" id="showContentLink0" class="showContentLink" style="text-decoration:none;">
							<img src="/sport/images/bulletin/button_readmore.png" width="90px" height="30px">
						</a>
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
					<div class="showContentBtn1">
						<a href="#" id="showContentLink1" class="showContentLink" style="text-decoration:none;">
							<img src="/sport/images/bulletin/button_readmore.png" width="90px" height="30px">
						</a>
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
					<div class="showContentBtn2">
						<a href="#" id="showContentLink2" class="showContentLink" style="text-decoration:none;">
							<img src="/sport/images/bulletin/button_readmore.png" width="90px" height="30px">
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
					<div class="showContentBtn3">
						<a href="#" id="showContentLink3" class="showContentLink" style="text-decoration:none;">
							<img src="/sport/images/bulletin/button_readmore.png" width="90px" height="30px">
						</a>
					</div>
				</div>
			</div>
			<hr class="style-one" />
		</div>
		<div class="pagination-container">
			<ul	class="pagination">
<!-- 				<li class="page-item"><a class="page-link" href="#">Previous</a></li> -->
<!-- 			    <li class="page-item"><a class="page-link" href="#">1</a></li> -->
<!-- 			    <li class="page-item"><a class="page-link" href="#">2</a></li> -->
<!-- 			    <li class="page-item"><a class="page-link" href="#">3</a></li> -->
<!-- 			    <li class="page-item"><a class="page-link" href="#">Next</a></li> -->
			</ul>
		</div>
	</div>
<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
</body>
</html>