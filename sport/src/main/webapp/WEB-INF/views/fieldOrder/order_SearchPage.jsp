<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="../headerScript.jsp"/>
<!-- jQuery -->
<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.js"></script> -->
<!-- <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
<!-- bootstrap -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> -->
<!-- <script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<style>
#orderFullMainDiv {
	min-height: 250px;
}

#searchDiv {
	width: 600px;
	margin: auto;
}

#searchDiv button, #search2 {
	padding: 2px 7px;
	margin-bottom: 4px;
}

#div_DateType {
	margin-top: 10px;
}

#queryDiv {
	margin: 10px auto;
	width: 1100px;
}

#orderTable th, #orderTable td {
	text-align: center;
/* 	padding: 5px 10px; */
}

.statusSpan {
	font-size: 15px;
	padding: 1px 7px;
	border-radius: 15px;
}


.bg-info th {
	color: white;
	font-size: 17px;
	font-weight: 550;
}

#detailDiv td{
	padding: 5px 10px;
}

.displayDetail, .updateBtn {
	padding: 2px 7px;
}

</style>


</head>
<body>
	<c:import url="../newheaderM.jsp"/>
	<h2>訂單管理</h2>
	<div id="orderFullMainDiv">
	<div id="searchDiv">
		帳號：
		<input type="text" name="account" id="account" />
		<button id="search" class="btn btn-outline-secondary">搜尋目前訂單</button>
		<button id="searchPast" class="btn btn-outline-secondary">查詢歷史訂單</button>
		<button id="searchAll" class="btn btn-outline-secondary">查詢全部訂單</button>
		<hr>
		<div id="div_DateType">
			類型：	
			<select id="typeSelect" name="typeSelect">
				<option value="0">- 請選擇 -</option>
				<c:forEach var="fieldType" items="${fieldTypeList}">
					<option value="${fieldType.id}">${fieldType.name}</option>
				</c:forEach>
			</select>
			日期：
			<input id="date" name="date" type="date" value="${day1}" min="${day1}" max="${day2}">&nbsp;&nbsp;
			時段：
			<select id="period" name="periodId">
				<option value="0">- 請選擇 -</option>
				<c:forEach var="periods" items="${periodList}">			
					<option value="${periods.id}">${periods.period}</option>
				</c:forEach>
			</select>
			<button id="search2" class="btn btn-outline-secondary">查詢</button>
			
			<hr>
		</div>
	</div>
	
	<div id="queryDiv"></div>
</div>
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">預約時間表</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div id="detailDiv" class="modal-body">
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
	var accountInput = document.getElementById("account");
	var queryDiv = document.getElementById("queryDiv");
	var mapData;
	var temp;
	
	$("#search").click(xhrFunction);
	$("#search2").click(xhrFunction2);
	$("#searchPast").click(xhrFunction);
	$("#searchAll").click(xhrFunction);

	function xhrFunction() {
		
		var account = accountInput.value;
		if(account != ""){			
			var xhr = new XMLHttpRequest();
			if(this.id == "searchAll"){
				$("#search").removeClass("btn-secondary");
				$("#search2").removeClass("btn-secondary");
				$("#searchPast").removeClass("btn-secondary");
				$("#searchAll").removeClass("btn-outline-secondary");
				$("#search").addClass("btn-outline-secondary");
				$("#search2").addClass("btn-outline-secondary");
				$("#searchPast").addClass("btn-outline-secondary");
				$("#searchAll").addClass("btn-secondary");
				xhr.open("GET","<c:url value='getAllMemberOrdersJsonByAccount/"+account+"'/>",true);
				temp = this.id;
			}else if(this.id == "search"){
				$("#search").removeClass("btn-outline-secondary");
				$("#search2").removeClass("btn-secondary");
				$("#searchPast").removeClass("btn-secondary");
				$("#searchAll").removeClass("btn-secondary");
				$("#search").addClass("btn-secondary");
				$("#search2").addClass("btn-outline-secondary");
				$("#searchPast").addClass("btn-outline-secondary");
				$("#searchAll").addClass("btn-outline-secondary");
				xhr.open("GET","<c:url value='getMemberOrderJsonByAccount/"+account+"'/>",true);
				temp = this.id;
			}else if(this.id == "searchPast"){
				$("#search").removeClass("btn-secondary");
				$("#search2").removeClass("btn-secondary");
				$("#searchPast").removeClass("btn-outline-secondary");
				$("#searchAll").removeClass("btn-secondary");
				$("#search").addClass("btn-outline-secondary");
				$("#search2").addClass("btn-outline-secondary");
				$("#searchPast").addClass("btn-secondary");
				$("#searchAll").addClass("btn-outline-secondary");
				xhr.open("GET","<c:url value='getPastMemberOrderJsonByAccount/"+account+"'/>",true);
				temp = this.id;
			}else if(temp == "searchAll"){
				$("#search").removeClass("btn-secondary");
				$("#search2").removeClass("btn-secondary");
				$("#searchPast").removeClass("btn-secondary");
				$("#searchAll").removeClass("btn-outline-secondary");
				$("#search").addClass("btn-outline-secondary");
				$("#search2").addClass("btn-outline-secondary");
				$("#searchPast").addClass("btn-outline-secondary");
				$("#searchAll").addClass("btn-secondary");
				xhr.open("GET","<c:url value='getAllMemberOrdersJsonByAccount/"+account+"'/>",true);
			}else if(temp == "search"){
				$("#search").removeClass("btn-outline-secondary");
				$("#search2").removeClass("btn-secondary");
				$("#searchPast").removeClass("btn-secondary");
				$("#searchAll").removeClass("btn-secondary");
				$("#search").addClass("btn-secondary");
				$("#search2").addClass("btn-outline-secondary");
				$("#searchPast").addClass("btn-outline-secondary");
				$("#searchAll").addClass("btn-outline-secondary");
				xhr.open("GET","<c:url value='getMemberOrderJsonByAccount/"+account+"'/>",true);
			}else if(temp == "searchPast"){
				$("#search").removeClass("btn-secondary");
				$("#search2").removeClass("btn-secondary");
				$("#searchPast").removeClass("btn-outline-secondary");
				$("#searchAll").removeClass("btn-secondary");
				$("#search").addClass("btn-outline-secondary");
				$("#search2").addClass("btn-outline-secondary");
				$("#searchPast").addClass("btn-secondary");
				$("#searchAll").addClass("btn-outline-secondary");
				xhr.open("GET","<c:url value='getPastMemberOrderJsonByAccount/"+account+"'/>",true);
			}
			
			xhr.send();
			if (xhr != null) {
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						displayMemberOrders(xhr.responseText);
					}
				}
			}
		}else{
			queryDiv.innerHTML = "<h4 style='text-align:center;'>請輸入帳號</h4>"
		}
	}
	
	function xhrFunction2() {
		$("#search").removeClass("btn-secondary");
		$("#search2").removeClass("btn-outline-secondary");
		$("#searchPast").removeClass("btn-secondary");
		$("#searchAll").removeClass("btn-secondary");
		$("#search").addClass("btn-outline-secondary");
		$("#search2").addClass("btn-secondary");
		$("#searchPast").addClass("btn-outline-secondary");
		$("#searchAll").addClass("btn-outline-secondary");
		
		var typeId = parseInt(document.getElementById("typeSelect").value);
		var date = document.getElementById("date").value;
		var periodId = parseInt(document.getElementById("period").value);
		if(typeId != 0 && periodId != 0){			
			var xhr = new XMLHttpRequest();
			
			xhr.open("GET","<c:url value='getJson/typeId="+typeId+"&date="+date+"&periodId="+periodId+"'/>",true);
			
			xhr.send();
			if (xhr != null) {
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						displayMemberOrders(xhr.responseText);
					}
				}
			}
		}else{
			var content = "";
			if(typeId == 0){
				content += "類型、"
			}
			if(periodId == 0){
				content += "時段、"
			}
			content = content.substr(0, (content.length-1))
			queryDiv.innerHTML = "<h4 style='text-align:center;'>您尚未選擇" + content + "</h4>"
		}
	}
	

	function displayMemberOrders(responseText) {
		mapData = JSON.parse(responseText);
		var fieldMemberOrderList = mapData.fieldMemberOrderList;		
		
		console.log(fieldMemberOrderList.length);		
		
		if(fieldMemberOrderList.length != 0){
			var content = "";
			content += "<table id='orderTable' class='table table-hover table-striped'>"
					 + "<tr class='bg-info'><th>訂單編號<th>帳號<th>預約場地<th>預約明細<th>建立時間<th>出席狀態<th>出席狀態編輯<th>訂單狀態<th>訂單狀態編輯";
	
			for (var i = 0; i < fieldMemberOrderList.length; i++) {
				var createTime = fieldMemberOrderList[i].createTime.substr(0,19);
				var attendance = "";
				if (fieldMemberOrderList[i].attendance == 1) {
					attendance = "<span class='btn btn-primary statusSpan'>出席</span>";
				} else if (fieldMemberOrderList[i].attendance == 0) {
					attendance = "<span class='btn btn-secondary statusSpan'>待處理</span>";
				} else if (fieldMemberOrderList[i].attendance == -1) {
					attendance = "<span class='btn btn-danger statusSpan'>缺席</span>";
				}
				var orderStatus = (fieldMemberOrderList[i].orderStatus == 0) ? "<span class='btn btn-danger statusSpan'>已取消</span>" : "<span class='btn btn-primary statusSpan'>成立</span>";
				var remark = (fieldMemberOrderList[i].remark == null) ? "無" : fieldMemberOrderList[i].remark;
					content += "<tr>"
							+ "<td>" + fieldMemberOrderList[i].id
							+ "<td>" + fieldMemberOrderList[i].users.account
							+ "<td>" + fieldMemberOrderList[i].orderDetails[0].field.name
							+ '<td><input type="button" displayId="'+fieldMemberOrderList[i].id+'" class="btn btn-sm btn-outline-secondary displayDetail" data-toggle="modal" data-target="#myModal" value="瀏覽"/>'
							+ "<td>" + createTime
							+ "<td>" + attendance
							+ "<td><input type='button' class='btn btn-sm btn-outline-primary updateBtn attendanceBtn' value='出席' uId='"+fieldMemberOrderList[i].id+"'/>&nbsp;"
							+ "<input type='button' class='btn btn-sm btn-outline-danger updateBtn absenceBtn' value='缺席' uId='"+fieldMemberOrderList[i].id+"'/>&nbsp;"
							+ "<input type='button' class='btn btn-sm btn-outline-info updateBtn attendanceResetBtn' value='重製' uId='"+fieldMemberOrderList[i].id+"'/>&nbsp;"
							+ "<td>" + orderStatus
							+ "<td><input type='button' class='btn btn-sm btn-outline-danger updateBtn cancelBtn' value='取消' uId='"+fieldMemberOrderList[i].id+"'/>&nbsp;"
							+ "<input type='button' class='btn btn-sm btn-outline-secondary updateBtn resetBtn' value='還原' uId='"+fieldMemberOrderList[i].id+"'/>";
			}
			content += "</table>";
	
			queryDiv.innerHTML = content;
	
			$(".attendanceBtn").click(function() {
				Swal.fire({
					icon: "question",
					showCancelButton: true,
					confirmButtonText: "確定",
					cancelButtonText: "返回",
					title: "出席確認？"
				}).then((result) => {
					if (result.isConfirmed) {
						var uId = $(this).attr('uId');
						console.log(uId);
						var json = {"updateId" : uId};
						$.ajax({
							method : 'POST',
							contentType : "application/json;charset=UTF-8",
							url : 'updateAttendance',
							dataType : 'text',
							data : JSON.stringify(json),
			
							success : function(response) {
								if (response == "success") {
									Swal.fire({
										  toast: true,
										  icon: 'success',
										  position: 'top',
										  showConfirmButton: false,
							  		  	  timer: 2000,
										  title: '資料修改成功！'
									});
									xhrFunction();
								}
							},
							error : function(response) {
								Swal.fire({
									  toast: true,
									  icon: 'error',
									  position: 'top',
									  showConfirmButton: false,
						  		  	  timer: 2000,
									  title: '資料修改失敗！'
								});
							}
						});		
					}
				});
				
				
				
			});
	
			$(".absenceBtn").click(function() {
				Swal.fire({
					icon: "question",
					showCancelButton: true,
					confirmButtonText: "確定",
					cancelButtonText: "返回",
					title: "缺席確認？"
				}).then((result) => {
					if (result.isConfirmed) {
						var uId = $(this).attr('uId');
						console.log(uId);
						var json = {"updateId" : uId};
						$.ajax({
							method : 'POST',
							contentType : "application/json;charset=UTF-8",
							url : 'updateAbsence',
							dataType : 'text',
							data : JSON.stringify(json),
			
							success : function(response) {
								if (response == "success") {
									Swal.fire({
										  toast: true,
										  icon: 'success',
										  position: 'top',
										  showConfirmButton: false,
							  		  	  timer: 2000,
										  title: '資料修改成功！'
									});
									xhrFunction();
								}
							},
							error : function(response) {
								Swal.fire({
									  toast: true,
									  icon: 'error',
									  position: 'top',
									  showConfirmButton: false,
						  		  	  timer: 2000,
									  title: '資料修改失敗！'
								});
							}
						});
						
					}
				});
				
				
			});
			
			$(".attendanceResetBtn").click(function() {
				Swal.fire({
					icon: "question",
					showCancelButton: true,
					confirmButtonText: "確定",
					cancelButtonText: "返回",
					title: "重製確認？"
				}).then((result) => {
					if (result.isConfirmed) {
						var uId = $(this).attr('uId');
						console.log(uId);
						var json = {"updateId" : uId};
						$.ajax({
							method : 'POST',
							contentType : "application/json;charset=UTF-8",
							url : 'resetAttendance',
							dataType : 'text',
							data : JSON.stringify(json),
			
							success : function(response) {
								if (response == "success") {
									Swal.fire({
										  toast: true,
										  icon: 'success',
										  position: 'top',
										  showConfirmButton: false,
							  		  	  timer: 2000,
										  title: '資料修改成功！'
									});
									xhrFunction();
								}
							},
							error : function(response) {
								Swal.fire({
									  toast: true,
									  icon: 'error',
									  position: 'top',
									  showConfirmButton: false,
						  		  	  timer: 2000,
									  title: '資料修改失敗！'
								});
							}
						});
					}
				});
				
			});
	
			$(".cancelBtn").click(function() {
				Swal.fire({
					icon: "question",
					showCancelButton: true,
					confirmButtonText: "確定",
					cancelButtonText: "返回",
					title: "取消確認？"
				}).then((result) => {
					if (result.isConfirmed) {
						var uId = $(this).attr('uId');
						console.log(uId);
						var json = {
							"updateId" : uId
						};
						$.ajax({
							method : 'POST',
							contentType : "application/json;charset=UTF-8",
							url : 'updateCancel',
							dataType : 'text',
							data : JSON.stringify(json),
			
							success : function(response) {
								if (response == "success") {
									Swal.fire({
										  toast: true,
										  icon: 'success',
										  position: 'top',
										  showConfirmButton: false,
							  		  	  timer: 2000,
										  title: '預約已成功取消！'
									});
									xhrFunction();
								}
							},
							error : function(response) {
								Swal.fire({
									  toast: true,
									  icon: 'error',
									  position: 'top',
									  showConfirmButton: false,
						  		  	  timer: 2000,
									  title: '預約取消失敗！'
								});
							}
						});
					}
				});
			});
			
			$(".resetBtn").click(function() {
				Swal.fire({
					icon: "question",
					showCancelButton: true,
					confirmButtonText: "確定",
					cancelButtonText: "返回",
					title: "預約還原確認？"
				}).then((result) => {
					if (result.isConfirmed) {
						var uId = $(this).attr('uId');
						console.log(uId);
						var json = {
							"updateId" : uId
						};
						$.ajax({
							method : 'POST',
							contentType : "application/json;charset=UTF-8",
							url : 'resetCancel',
							dataType : 'text',
							data : JSON.stringify(json),
			
							success : function(response) {
								if (response == "success") {
									Swal.fire({
										  toast: true,
										  icon: 'success',
										  position: 'top',
										  showConfirmButton: false,
							  		  	  timer: 2000,
										  title: '預約已成功還原！'
									});
									xhrFunction();
								}
							},
							error : function(response) {
								Swal.fire({
									  toast: true,
									  icon: 'error',
									  position: 'top',
									  showConfirmButton: false,
						  		  	  timer: 2000,
									  title: '預約還原失敗！'
								});
							}
						});
					}
				});
			});
			
			$(".displayDetail").click(displayDetail);			
		}else{
			queryDiv.innerHTML = "<h4 style='text-align:center;'>查無相符資料</h4>"
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
// 	console.log('預約日期:'+orderDate);
// 	console.log('預約場地:'+orderField);
// 	console.log('開始時間:'+startTime);
// 	console.log('結束時間:'+endTime);

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
<!-- <script src="http://code.jquery.com/jquery-1.12.4.js"></script> -->
<c:import url="../footer.jsp"/>
</body>
</html>