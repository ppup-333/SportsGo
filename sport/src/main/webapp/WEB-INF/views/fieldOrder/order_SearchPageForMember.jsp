<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<c:import url="../headerScript.jsp"/>


<style>
th, td {
	padding: 5px 10px;
}

#memberOrderDiv p {
	text-align: center;
}

#memberOrderTable {
	text-align: center;
}
</style>


</head>
<body>
<c:import url="../newheader.jsp"/>

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
			<div class="col-2"></div>
			<div class="col-8">
				<div id="memberOrderDiv">
					<p>
						<button id="search">目前訂單</button>
						<button id="searchPast">歷史訂單</button>
					</p>
					<div id="queryDiv"></div>
				</div>				
			</div>
			<div class="col-2"></div>
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
<c:if test="${sessionScope.createMemberOrderCode == 'success'}">
	Swal.fire({
		icon: "success",
		title: "預約成功！",
		text: "請確認訂單"
	});
	${sessionScope.remove('createMemberOrderCode')}
</c:if>


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
			content += "<table id='memberOrderTable' class='table table-hover table-striped'>"
					 + "<tr class='bg-warning'><th>訂單編號<th>帳號<th>預約場地<th>建立時間<th>預約明細<th>出席狀態<th>訂單狀態";
	
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
							+ "<td>" + fieldMemberOrderList[i].orderDetails[0].field.name
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

</body>
</html>