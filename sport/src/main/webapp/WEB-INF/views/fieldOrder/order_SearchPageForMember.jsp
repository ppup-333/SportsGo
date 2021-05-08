<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap css -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous"> -->

<!-- <link rel="stylesheet" href="../css/header.css"> -->
<!-- <link rel="stylesheet" href="../css/HomeMain.css"> -->
<!-- <link rel="stylesheet" href="../css/footer.css"> -->
<link rel="stylesheet" href="/sport/css/field/order_SearchPageForMember.css">

<!-- jQuery -->
<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.js"></script> -->
<!-- <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
<!-- <!-- bootstrap -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> -->
<!-- <script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<style>
th, td {
	padding: 5px 10px;
}
</style>


</head>
<body>
	<c:import url="../header.jsp"/>


	<div class="container">
		<div class="row">
			<div class="col-12">
				<div id="title">
					<h2>訂單查詢</h2>
				</div>				
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div id="mainDiv">
					<button id="search">目前訂單</button>
					<button id="searchPast">歷史訂單</button>
					<div id="queryDiv"></div>
				</div>				
			</div>
		</div>
	</div>


	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">預約時間表</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div style="width:200px; margin:auto">
						<table>
							<tr><td>場地:</td><td id="detailField"></td></tr>
							<tr><td>日期:</td><td id="detailDate"></td></tr>
							<tr><td>時間:</td><td id="detailTime"></td></tr>
							<tr><td>時數:</td><td id="detailHours"></td></tr>
						</table>						
					</div>
				</div>
									
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
				
			</div>
		</div>
	</div>

<script>
	var queryDiv = document.getElementById("queryDiv");
	var mapData;
	
	xhrFunction();
	$("#search").click(xhrFunction);
	$("#searchPast").click(xhrFunction);
	
	function xhrFunction() {		
		
		var urlStr = "";
		var xhr = new XMLHttpRequest();
		if(this.id == "search"){
			urlStr = "getMemberOrderJson";
		}else if(this.id == "searchPast"){
			urlStr = "getPastMemberOrderJson";
		}else{
			urlStr = "getMemberOrderJson";
		}
		
		xhr.open("GET", urlStr, true);
		xhr.send();
		if (xhr != null) {
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					displayMemberOrders(xhr.responseText);
				}
			}
		}
		
	}
	
	function displayMemberOrders(responseText) {
		mapData = JSON.parse(responseText);
		var fieldMemberOrderList = mapData.fieldMemberOrderList;		
		
		console.log(fieldMemberOrderList.length);		
		
		if(fieldMemberOrderList.length != 0){
			var content = "";
			content += "<table border='1'>"
					 + "<tr><th>訂單編號<th>帳號<th>建立時間<th>預約明細<th>出席狀態<th>訂單狀態";
	
			for (var i = 0; i < fieldMemberOrderList.length; i++) {
				var createTime = fieldMemberOrderList[i].createTime.substr(0,19);
				var attendance = "";
				if (fieldMemberOrderList[i].attendance == 1) {
					attendance = "出席";
				} else if (fieldMemberOrderList[i].attendance == -1) {
					attendance = "缺席";
				}
				var orderStatus = (fieldMemberOrderList[i].orderStatus == 0) ? "已取消" : "成立";
				var remark = (fieldMemberOrderList[i].remark == null) ? "無" : fieldMemberOrderList[i].remark;
					content += "<tr>"
							+ "<td>" + fieldMemberOrderList[i].id
							+ "<td>" + fieldMemberOrderList[i].users.account
							+ "<td>" + createTime
							+ '<td><input type="button" displayId="'+fieldMemberOrderList[i].id+'" class="displayDetail" data-toggle="modal" data-target="#myModal" value="瀏覽"/>'
							+ "<td>" + attendance
							+ "<td>" + orderStatus;
			}
			content += "</table>";
	
			queryDiv.innerHTML = content;
			
			$(".displayDetail").click(displayDetail);			
		}else{
			queryDiv.innerHTML = "<h4>查無相符資料</h4>"
		}

	}
	
	function displayDetail(){
		var displayId = $(this).attr('displayId');
		var fieldMemberOrderList = mapData.fieldMemberOrderList;
		var fieldMemberOrderDetails;
		for(var i = 0; i < fieldMemberOrderList.length; i++){
			if(fieldMemberOrderList[i].id == displayId){
				fieldMemberOrder = fieldMemberOrderList[i];
				fieldMemberOrderDetails = fieldMemberOrder.orderDetails;
				break;
			}
		}
		var orderDate = fieldMemberOrderDetails[0].date;
		var orderField = fieldMemberOrderDetails[0].field.name;
		var startTime = fieldMemberOrderDetails[0].fieldPeriod.period.substr(0,5);
		var endTime = fieldMemberOrderDetails[fieldMemberOrderDetails.length-1].fieldPeriod.period.substr(6);
		var hours = fieldMemberOrderDetails.length;
//	 	console.log('預約日期:'+orderDate);
//	 	console.log('預約場地:'+orderField);
//	 	console.log('開始時間:'+startTime);
//	 	console.log('結束時間:'+endTime);

		var detailField = document.getElementById("detailField");
		var detailDate = document.getElementById("detailDate");
		var detailTime = document.getElementById("detailTime");
		var detailHours = document.getElementById("detailHours");
		detailField.innerHTML = orderField;
		detailDate.innerHTML = orderDate;
		detailTime.innerHTML = startTime + " ~ " + endTime;
		detailHours.innerHTML = hours + "小時";
	}
	

</script>

<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script> -->

</body>
</html>