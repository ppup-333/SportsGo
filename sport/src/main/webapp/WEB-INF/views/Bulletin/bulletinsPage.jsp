<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="zh-Hant-TW">
<head>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>公告管理</title>
</head>
<style>
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
		initNowPage();
		showBulletin(nowPage);
// 		changePage(globalClassId);
		
		$('#prevPage').click(function(){
			$.getJSON("getPageInfo?classId=" + globalClassId, function(data){
				console.log(data.totalPage);
				console.log(data.totalBulletin);
				if (nowPage <= 1) {
					alert("目前是第一頁");
				} else {
					nowPage = nowPage - 1;
					$('#nowPage').empty();
					$('#nowPage').append($('<p>').text('目前頁數:' + nowPage));
					if(globalClassId == 0){
						showBulletin(nowPage);
						
					}
					else{
						showBulletinByClass(globalClassId, nowPage);
						
					}
				}
			});
		});
		$('#nextPage').click(function(){
			$.getJSON("getPageInfo?classId=" + globalClassId, function(data){
				console.log(data.totalPage);
				console.log(data.totalBulletin);
				if (nowPage >= data.totalPage){
					alert("目前是最後一頁");
				}else{
					nowPage = nowPage + 1;
					$('#nowPage').empty();
					$('#nowPage').append($('<p>').text('目前頁數:' + nowPage));
					if(globalClassId == 0){
						showBulletin(nowPage);
						
					}
					else{
						showBulletinByClass(globalClassId, nowPage);
						
					}
				}
			});
		});
	})

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
				$("#allBulletins").empty();
				var $table = $('<table border="1">').appendTo(
						$('#allBulletins')).append(
						"<tr><th>公告類型</th><th>公告標題</th><th>公告更新時間</th><th>編輯公告</th><th>刪除公告</th></tr>");
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
							.append($('<td>').html('<input class="btn btn-outline-danger" id="deleteBtn'+index+'" type="button" value="刪除" onclick="deleteBulletin('+bulletin.id+');"/>'));
// 					$("table>tr").find("td:eq(1)").append('<a>').attr("href",tmp);
							$('#updateBtn' + index).attr('onclick','location.href="/sport/Bulletin/update/'+bulletin.id+'"');
				});
				$.getJSON("getPageInfo?classId=" + globalClassId, function(data){
					$("#pageInfo").empty();
					$('#pageInfo').append($('<p>').text('總頁數:' + data.totalPage));
					
				});
			}
		}
	}

	
	function showBulletinByClass(classId, nowPage){
		globalClassId = classId;
		dataUrl = "bulletinPagingClass?nowPage=" + nowPage + "&classId=" + classId;
		var xhr = new XMLHttpRequest();
		xhr.open('GET', dataUrl, true)
		xhr.send()
		xhr.onreadystatechange = function(){
			if (this.readyState === 4 && this.status === 200) {
				var data = JSON.parse(this.responseText);
				console.log(data);
				$("#allBulletins").empty();
				var $table = $('<table border="1">').appendTo(
						$('#allBulletins')).append(
						"<tr><th>公告類型</th><th>公告標題</th><th>公告更新時間</th><th>編輯公告</th><th>刪除公告</th></tr>");
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
							.append($('<td>').html('<input class="btn btn-outline-danger" id="deleteBtn'+index+'" type="button" value="刪除" onclick="deleteBulletin('+bulletin.id+');"/>'));
							
// 					$("table>tr").find("td:eq(1)").append('<a>').attr("href",tmp);
							$('#updateBtn' + index).attr('onclick','location.href="/sport/Bulletin/update/'+bulletin.id+'"');
				});
				$.getJSON("getPageInfo?classId=" + globalClassId, function(data){
					$("#pageInfo").empty();
					$('#pageInfo').append($('<p>').text('總頁數:' + data.totalPage));
					
				});
			}
		}
	}
	function initNowPage(){
		nowPage = 1;
		$('#nowPage').empty();
		$('#nowPage').append($('<p>').text('目前頁數:' + nowPage));
	}
	
	function deleteBulletin(id){
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
	        				  window.location.href = "/sport/Bulletin/showAllBulletin";  	 
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
<c:import url="../headerM.jsp"/>
	<div  class="container">
		<div class="container">
			<h3>公告管理</h3>
			<table>
				<tr>
					<td>
						<div class="dropdown show">
			  				<a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="classChooseLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">公告分類</a>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<a class="dropdown-item" href="#" onclick="showBulletin(1);initNowPage()">所有公告</a>
							    <a class="dropdown-item" href="#" onclick="showBulletinByClass(1,1);initNowPage()">一般公告</a>
							    <a class="dropdown-item" href="#" onclick="showBulletinByClass(3,1);initNowPage()">緊急公告</a>
							    <a class="dropdown-item" href="#" onclick="showBulletinByClass(2,1);initNowPage()">課程異動</a>
						 	</div>
						</div>				
					</td>
					<td><a class="btn btn-secondary" href='add'>新增公告</a></td>
<%-- 					<td><a class="btn btn-secondary" href="<c:url value='/'/> ">回前頁</a></td> --%>
				</tr>
			</table>
			
			
			
			<hr>
		</div>
		<div id="allBulletins" class="container"></div>
		<div class="container">
			<ul class="pagination">
				<li class="page-item"><a class="page-link" id="prevPage"
					href="#">Previous</a></li>
				<li class="page-item"><a class="page-link" id="nextPage"
					href="#">Next</a></li>
			</ul>
			<div id="nowPage">
			</div>
			<div id="pageInfo">
			</div>
		</div>
	</div>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</body>
</html>