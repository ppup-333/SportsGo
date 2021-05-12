<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="zh-Hant-TW">
<head>

<c:import url="../headerScript.jsp"/>

<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script> -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>公告管理</title>
</head>
<style>

.box{
		margin-top:50px;
		font-family: 'Noto Sans TC';
	}
.container {
	align: center;
	text-align: center;
}

.container ul {
	margin: 5px;
	display: inline-block;
}

.container li {
	float: left;
}
.chosen > a{
	background:	#E0E0E0;
}
.myMOUSE{ 
	cursor: pointer; 
}
.table-hover tbody tr:hover td, .table-hover tbody tr:hover{
	background-color: #d7e5f4;
}
a{
	color:#2474A3;
	
}
a:hover{
	color:#2474A3;
	text-decoration:none;
}

.page-item > a{
	color:#17A2B8;
}
</style>

<script>
	// 	$.ajax({
	// 	        url:"bulletinPaging/"+"1",
	// 	        type:"get",
	// 	        dataType:"json",
	// 	        success: function(data) {
	// 			    console.log(data); 
	// 			    var item = JSON.parse(data);
	// 			    console.log(item);
	// 	        }
	// 	});
	var nowPage = 1;
	var globalClassId = 0;
	
	$(document).ready(function() {
// 		initNowPage();
// 		showBulletin(nowPage);
// 		changePage(globalClassId);
		generatePage(1,0);
		
// 		$('#prevPage').click(function(){
// 			$.getJSON("getPageInfo?classId=" + globalClassId, function(data){
// 				console.log(data.totalPage);
// 				console.log(data.totalBulletin);
// 				if (nowPage <= 1) {
// 					alert("目前是第一頁");
// 				} else {
// 					nowPage = nowPage - 1;
// 					$('#nowPage').empty();
// 					$('#nowPage').append($('<p>').text('目前頁數:' + nowPage));
// 					if(globalClassId == 0){
// 						showBulletin(nowPage);
						
// 					}
// 					else{
// 						showBulletinByClass(globalClassId, nowPage);
						
// 					}
// 				}
// 			});
// 		});
// 		$('#nextPage').click(function(){
// 			$.getJSON("getPageInfo?classId=" + globalClassId, function(data){
// 				console.log(data.totalPage);
// 				console.log(data.totalBulletin);
// 				if (nowPage >= data.totalPage){
// 					alert("目前是最後一頁");
// 				}else{
// 					nowPage = nowPage + 1;
// 					$('#nowPage').empty();
// 					$('#nowPage').append($('<p>').text('目前頁數:' + nowPage));
// 					if(globalClassId == 0){
// 						showBulletin(nowPage);
						
// 					}
// 					else{
// 						showBulletinByClass(globalClassId, nowPage);
						
// 					}
// 				}
// 			});
// 		});
// 		function initNowPage(){
// 			nowPage = 1;
// 			$('#nowPage').empty();
// 			$('#nowPage').append($('<p>').text('目前頁數:' + nowPage));
// 		}
	})

	
	function generatePage(currentPage,classId){
		$.getJSON("getPageInfoCustomize?classId=" + classId + "&pageSize=" + 10,function(data){
				console.log(data.totalPage);
				console.log(data.totalBulletin);
				console.log(currentPage);
				$(".pagination li").remove();
				
				if(classId == 0){
					showBulletin(currentPage);
				}else{
					showBulletinByClass(currentPage,classId);
				}
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
				
				var firstPageStr = "generatePage(1,"+ classId +")";
				var prePageStr = "generatePage("+ prePage +","+ classId +")";
				var nextPageStr = "generatePage("+ nextPage +","+ classId +")";
				var lastPageStr = "generatePage("+ lastPage +","+ classId +")";
				
				
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
							var pageNumber = "generatePage("+ i +","+ classId +")"
							$('.pagination').append('<li class="page-item"><a id="link'+i+'" class="page-link myMOUSE"  onclick="'+ pageNumber + '" >'+ i +'</a></li>');
						}
					}
				}else if(pageNum > 3 && total <= (pageNum+2)){
					for(var i = total - 4; i <=total; i++){
						if(i == pageNum){
							$('.pagination').append('<li class="page-item"><a id="link'+i+'" class="page-link myMOUSE"  onclick="" >'+ i +'</a></li>');
						}else{
							var pageNumber = "generatePage("+ i +","+ classId +")"
							$('.pagination').append('<li class="page-item"><a id="link'+i+'" class="page-link myMOUSE"  onclick="'+ pageNumber + '" >'+ i +'</a></li>');
						}
					}
				}else if(pageNum > 3 && total > (pageNum + 2)){
					for(var i = pageNum - 2; i <= pageNum + 2; i ++){
						if(i == pageNum){
							$('.pagination').append('<li class="page-item"><a id="link'+i+'" class="page-link myMOUSE"  onclick="" >'+ i +'</a></li>');
						}else{
							var pageNumber = "generatePage("+ i +","+ classId +")"
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
				
				$.getJSON("getPageInfoCustomize?classId=" + globalClassId +"&pageSize=" + 10, function(data){
					$("#pageInfo").empty();
					$('#pageInfo').append($('<p>').text('總頁數:' + data.totalPage));
				});	
				
				
			});	
		}
	
	
	
	function showBulletin(nowPage) {
		globalClassId = 0;
		$('#classChooseLink').text('所有公告');
		dataUrl = "bulletinPagingCustomize?nowPage=" + nowPage + "&pageSize=" + 10; 
		var xhr = new XMLHttpRequest()
		xhr.open('GET', dataUrl, true)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (this.readyState === 4 && this.status === 200) {
				var data = JSON.parse(this.responseText);
				console.log(data);
				$("#allBulletins").empty();
				var $table = $('<table class="table table-striped table-hover">').appendTo(
						$('#allBulletins')).append(
						"<tr class='bg-info' style='color:white'><th>公告類型</th><th>公告標題</th><th>公告更新時間</th><th>編輯公告</th><th>刪除公告</th></tr>");
				$('#allBulletins').append($table);
				$.each(data, function(index, bulletin) {
					var tmp = "<c:url value='/' />Bulletin/showBulletinContent/" + bulletin.id;
					var updateTime = new Date(bulletin.update_time).toLocaleString('zh-TW');
					var updateLink = "/Bulletin/update/" + bulletin.id;
					$('<tr>').appendTo($table)
							.append($('<td>').text(bulletin.class_id.name))
							.append($('<td>').html('<a href=' + tmp + '>' + bulletin.title + '</a>'))
							.append($('<td>').text(updateTime))
							.append($('<td>').html('<input class="btn btn-outline-warning" id="updateBtn'+index+'" type="button" value="編輯" />'))
							.append($('<td>').html('<input class="btn btn-outline-danger" id="deleteBtn'+index+'" type="button" value="刪除" onclick="deleteBulletin('+bulletin.id+','+nowPage+',0);"/>'));
// 					$("table>tr").find("td:eq(1)").append('<a>').attr("href",tmp);
							$('#updateBtn' + index).attr('onclick','location.href="/sport/Bulletin/update/'+bulletin.id+'"');
				});
// 				$.getJSON("getPageInfoCustomize?classId=" + globalClassId +"&pageSize=" + 10, function(data){
// 					$("#pageInfo").empty();
// 					$('#pageInfo').append($('<p>').text('總頁數:' + data.totalPage));
					
// 				});
			}
		}
	}

	
	function showBulletinByClass(nowPage, classId){
		globalClassId = classId;
		if(classId == 1){
			$('#classChooseLink').text('一般公告');
		}else if(classId == 2){
			$('#classChooseLink').text('課程異動');
		}else if(classId == 3){
			$('#classChooseLink').text('緊急公告');
		}
		dataUrl = "bulletinPagingClassCustomize?nowPage=" + nowPage + "&classId=" + classId +"&pageSize=" + 10;
		var xhr = new XMLHttpRequest();
		xhr.open('GET', dataUrl, true)
		xhr.send()
		xhr.onreadystatechange = function(){
			if (this.readyState === 4 && this.status === 200) {
				var data = JSON.parse(this.responseText);
				console.log(data);
				$("#allBulletins").empty();
				var $table = $('<table class="table table-striped table-hover">').appendTo(
						$('#allBulletins')).append(
						"<tr class='bg-info' style='color:white'><th>公告類型</th><th>公告標題</th><th>公告更新時間</th><th>編輯公告</th><th>刪除公告</th></tr>");
				$('#allBulletins').append($table);
				$.each(data, function(index, bulletin) {
					var tmp = "<c:url value='/' />Bulletin/showBulletinContent/" + bulletin.id;
					var updateLink = "<c:url value='/' />Bulletin/update/" + bulletin.id;
					var updateTime = new Date(bulletin.update_time).toLocaleString('zh-TW');
					$('<tr>').appendTo($table)
							.append($('<td>').text(bulletin.class_id.name))
							.append($('<td>').html('<a href=' + tmp + '>' + bulletin.title + '</a>'))
							.append($('<td>').text(updateTime))
							.append($('<td>').html('<input class="btn btn-outline-warning" id="updateBtn'+index+'" type="button" value="編輯" />'))
							.append($('<td>').html('<input class="btn btn-outline-danger" id="deleteBtn'+index+'" type="button" value="刪除" onclick="deleteBulletin('+bulletin.id+','+nowPage+','+classId+');"/>'));
							
// 					$("table>tr").find("td:eq(1)").append('<a>').attr("href",tmp);
							$('#updateBtn' + index).attr('onclick','location.href="/sport/Bulletin/update/'+bulletin.id+'"');
				});
// 				$.getJSON("getPageInfo?classId=" + globalClassId +"&pageSize=" + 10, function(data){
// 					$("#pageInfo").empty();
// 					$('#pageInfo').append($('<p>').text('總頁數:' + data.totalPage));		
// 				});
			}
		}
	}
	
	
	function deleteBulletin(id,currentPage,classId){
		Swal.fire({ 
	      	  title: '確定刪除嗎?', 
	      	  text: '刪除後無法復原!', 
	      	  icon: 'warning',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '確定',
	      	  cancelButtonText:'取消',
	      	  backdrop: false,
		}).then(result => {
			if(result.value){
				$.ajax({
					url: '/sport/Bulletin/delete/' + id,
					type: 'DELETE',
					success: function(response){
						
						Swal.fire({
	        				  title: '刪除成功!',
	        				  text: '公告已經刪除，回不去了',
	        				  icon: 'success',
	        				  backdrop: false,
	        			  }).then(function(){
// 	        				  window.location.href = "/sport/Bulletin/showAllBulletin";  	
								generatePage(currentPage,classId)
	        	  		     });
					}
				})
			}
		});
		
		
		
// 		if(confirm('確定刪除公告嗎?')){
// 			$.ajax({
// 				url: '/sport/Bulletin/delete/' + id,
// 				type: 'DELETE',
// 				success: function(result){
// 					swal('刪除成功!');
// 					window.location.href="/sport/Bulletin/showAllBulletin";
// 				}
// 			})
// 		}
	}
</script>


<body>
<c:import url="../newheaderM.jsp"/>
	<div  class="box">
		<div class="container">
			<h2 style="font-family: 'Noto Sans TC', sans-serif">公告管理</h2>
			<hr>
			<table>
				<tr>
					<td>
						<div class="dropdown show" style="float:left;">
			  				<a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="classChooseLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">公告分類</a>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<a class="dropdown-item" href="#" onclick="showBulletin(1);generatePage(1,0)">所有公告</a>
							    <a class="dropdown-item" href="#" onclick="showBulletinByClass(1,1);generatePage(1,1)">一般公告</a>
							    <a class="dropdown-item" href="#" onclick="showBulletinByClass(3,1);generatePage(1,3)">緊急公告</a>
							    <a class="dropdown-item" href="#" onclick="showBulletinByClass(2,1);generatePage(1,2)">課程異動</a>
						 	</div>
						</div>				
					</td>
					
					<td style="text-align:right;"></td>
					
<%-- 					<td><a class="btn btn-secondary" href="<c:url value='/'/> ">回前頁</a></td> --%>
				</tr>
				<div style="float:right;">
				 	<a class="btn btn-outline-info addBtn" href='add'>新增公告</a>
				 </div>
			</table>
			
			
			
			
		</div>
		<div id="allBulletins" class="container"></div>
		<div class="container">
			<hr>
			<ul class="pagination">
				
			</ul>
			<div id="nowPage">
			</div>
			<div id="pageInfo">
			</div>
		</div>
	</div>
	<c:import url="../footer.jsp"/>	
<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
</body>
</html>