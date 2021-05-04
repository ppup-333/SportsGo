<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>	
<!DOCTYPE html>
<html>
<head> 

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
<script src="/sport/scripts/bulletin/jquery.cycle2.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告欄</title>
</head>   
<script >

	$(document).ready(
			function() {
				
// 				$.getJSON("Bulletin/bulletinPaging/" + 1, function(data) {
// 					console.log(data);
// 					$.each(data, function(index, bulletin) {
// 						var updateTime = new Date(bulletin.update_time)
// 								.toLocaleString('zh-TW');	
// 						$('#adv' + index).text(bulletin.title).attr("href","/sport/Bulletin/showBulletinContent/" + bulletin.id);
// 					});
// 				});
			var xhr = new XMLHttpRequest();
			var dataUrl = "Bulletin/bulletinPaging/" + 1;
			xhr.open('GET', dataUrl, true)
			xhr.send()
			xhr.onreadystatechange = function() {
				if (this.readyState === 4 && this.status === 200){
						var data = JSON.parse(this.responseText);
						$.each(data, function(index, bulletin) {
							var updateTime = new Date(bulletin.update_time)
									.toLocaleString('zh-TW');	
							$('#adv' + index).text(bulletin.title).attr("href","/sport/Bulletin/showBulletinContent/" + bulletin.id);
						});
					}
				}
			});	
	
	
	
</script>
<body>
	<c:import url="header.jsp"/>
	<h2 id="h2" style="text-align: center">公告欄</h2>
	<hr />
	<div style="text-align: center">
		<a href='Bulletin/showAllBulletin'>顯示現有公告</a><br>
		<br>
	</div>

	<div id='adv'>
		
	</div>
	<div class="cycle-slideshow" data-cycle-fx="fade"
		data-cycle-pause-on-hover="true" data-cycle-slides="> div"
		data-cycle-timeout="1000">
		<div>
			<a id='adv0' href="" target="_blank"></a>
		</div>
		<div>
			<a id='adv1' href="" target="_blank"></a>
		</div>
		<div>
			<a id='adv2' href="" target="_blank"></a>
		</div>
		<div>
			<a id='adv3' href="" target="_blank"></a>
		</div>
	</div>
	<p id='test'></p>
</body>
</html>