<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
<c:import url="../headerScript.jsp"/>
<style>

 	#tb1 td { 
 		height: 40px; 
		width: auto; 
				
 	} 

	.div1 {
		width: 1000px;
		height: 100px;
		max-width: 1000px;
		box-shadow: 0px 0px 3px 1px #00000078;
		padding: 10px;
		box-sizing: border-box;
		margin: 0 auto;
		border: 1px solid white;
	}

	.sp {
		color: darkgrey;
		font-size: 1px;
	}


	span.error {
		color: red;
		display: inline-block;
		font-size: 5pt;
	}
	
	
	.f1{ 
 		height:100px; 
  		width:1100px;  
		margin:auto;
		margin-top:20px; 
 	} 
	
	.d2{
		position:relative;
		top:-12px;
    	left:1200px;
    	width:150px;
	}
	
	#teble1 td{
		padding:5px;
		font-size:12px;
		text-align:center;
	}
	
	#teble1 th{
		background-color: #17a2b8;
		color: #FFFFFF;
		font-size:13px;
	}
	
	
	.selectDiv{ 
 		width:1400px; 
 		margin:auto;  
 	} 
	
</style>
<meta charset="UTF-8">
<title>會員資料管理</title>
<!-- <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet"> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script> -->
<!-- <link rel="stylesheet" href="jqueryui/style.css"> -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous"> -->
</head>
<body>
<c:import url="../newheaderM.jsp"/>
<!-- <div class='container'> -->
<fieldset class='f1'>
	<legend>會員資料查詢</legend>
	<form:form method="POST" modelAttribute="adminResultUsers" enctype='multipart/form-data' >
		<div>
			<table id='tb1'>
				<tr>
					<td>帳號：&nbsp;</td>
					<td><form:input path="account" id="account"/>&nbsp;</td>
					<td>姓名：&nbsp;</td>
					<td><form:input path="name" id="name"/>&nbsp;</td>
					<td>身分證字號：&nbsp;</td>
					<td><form:input path="id" id="id"/>&nbsp;</td>
				</tr>
				<tr>
					<td>縣市地區：&nbsp;</td>
					<td>
						<form:select path="cityCode.cityCode" id="aaaa">
							<form:option label="請選擇縣市" value="00" id="cityValue"/>
							<form:options  items="${cityList}" itemLabel='city' itemValue='cityCode' />
	   	  				</form:select>&nbsp;
	   	  				<form:select path="userDistrictCode.userDistrictCode" id='cityDistrict' >
							<form:option label="選擇鄉鎮市區" value="1000" id="districtValue"/>
	   	  				</form:select>&nbsp;&nbsp;&nbsp;&nbsp;
	   	  			</td>
	   	  			<td>地址：&nbsp;</td>
	   	  			<td>
	   	  				<form:input path='address' id="address"/>&nbsp;&nbsp;&nbsp;&nbsp;
	   	  			</td>
	   	  			<td>帳號狀態：&nbsp;</td>
	   	  			<td>
	   	  				<form:select path="statusCode.statusCode" id="userStatus">
	   	  					<form:option label="請選擇" value="00" id="statusValue"/>
							<form:options  items="${statusList}" itemLabel='status' itemValue='statusCode' />
	   	  				</form:select>
	   	  			</td>
				</tr>
			</table>
		</div>
	</form:form>
		<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  			<div class="modal-dialog">
    			<div class="modal-content">
     				<div class="modal-header">
        				<h5 class="modal-title" id="staticBackdropLabel">修改帳號狀態</h5>
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          					<span aria-hidden="true">&times;</span>
        				</button>
      				</div>
      			<form method="POST" action="UpdateStatus" id="form1" name="form1">
      				<div class="modal-body">
      					<table>
      						<tr>
      							<td>帳號：&nbsp;</td>
      							<td>
      								<input type='text' readonly id='selectAct' name='selectAct'/>&nbsp;&nbsp;
      							</td>
      							<td>狀態：&nbsp;</td>
      							<td>
      								<select id="selectStatus" name='selectStatus'>
      									<option value='00' id='selectValue'>請選擇</option>
      									<option value='01'>未驗證</option>
      									<option value='02'>正常使用</option>
      									<option value='03'>封鎖</option>
      								</select>
      							</td>
      						</tr>
      					</table>
      				</div>
      			</form>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
<!--         				<button type="button" class="btn btn-primary" onclick="submitStatus()">確認送出</button> -->
        				<button type="button" class="btn btn-primary" id="submitStatus">確認送出</button>
      				</div>
    			</div>
  			</div>
		</div>
	
</fieldset>
<!-- </div> -->
		<div class='d2'>
			<button id='search' class='btn btn-secondary'>搜尋會員資料</button>
		</div>
		<div id='searchResultDiv' class='selectDiv'></div>

<script>

	var alink = document.getElementById("search");
	alink.onclick = function() {
		select1();
	};
	
// 	var blink =  document.getElementById("update");
// 	blink.onclick = function() {
// 		select2();
// 	};

window.onload = function() {
	var clink = document.getElementById("aaaa");
	clink.onchange = function() {
//		var $("#aaaa").change(function(){
		var cityDistrict = document.getElementById("cityDistrict");
		
		cityDistrict.options.length = 0;
		cityDistrict.add(new Option("選擇鄉鎮市區", 1000));
		var cityCode = clink.value;
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "<c:url value='/admin/getDistrict' />", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.send("cityCode=" + cityCode);
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				var result = JSON.parse(xhr.responseText);
				for (var i = 0; i < result.length; i++) {
					cityDistrict.add(new Option(result[i].district, result[i].userDistrictCode));
				}
			}
		}
	};
//		 cityCode.trigger("change");
	var aaaa = $("#aaaa");
	aaaa.trigger("change");
//		alert("bbb");

	};

function select1(){
// 	window.alert("123")
	var account = document.getElementById("account");
	var name = document.getElementById("name");
	var id = document.getElementById("id");
	var cityValue = document.getElementById("aaaa");
	var districtValue = document.getElementById("cityDistrict");
	var address = document.getElementById("address");
	var statusValue = document.getElementById("userStatus");
	
	
	if(account.value == "" && name.value == "" && id.value == "" && cityValue.value == 00 
			&& districtValue.value == 1000 && address.value == "" && statusValue.value == 00){
		
		Swal.fire({
			toast: true,
    		position: 'top',
			showConfirmButton: false,
    		timer: 2000,
    		icon: 'error',
    		title: '請至少輸入一項搜尋條件!!',
    	})
		
		
// 		alert("請至少輸入一項搜尋條件");
	} else {

		var account = document.getElementById("account").value;
		var name = document.getElementById("name").value;
		var id = document.getElementById("id").value;
		var cityCode = document.getElementById("aaaa").value;
		var userDistrictCode = document.getElementById("cityDistrict").value;
		var address = document.getElementById("address").value;
		var statusCode = document.getElementById("userStatus").value;
		
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "<c:url value='/admin/ResultData' />", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		
		xhr.send("account=" + account + "&" + "name=" + name + "&" + "id=" + id + "&" + "cityCode=" + cityCode + "&" + 
				 "userDistrictCode=" + userDistrictCode + "&" + "address=" + address + "&" + "statusCode=" + statusCode);
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var content = "<table class='table table-striped table-hover' id='teble1'>";
					content += "<tr align='center'>"
							 + "<th style='width:80px'>帳號</th>"
							 + "<th style='width:90px'>姓名</th>"
							 + "<th style='width:100px'>身分證字號</th>"
							 + "<th style='width:60px'>性別</th>"
							 + "<th style='width:90px'>生日</th>"
							 + "<th style='width:80px'>email</th>"
							 + "<th style='width:70px'>城市</th>"
							 + "<th style='width:105px'>鄉鎮市區</th>"
							 + "<th style='width:180px'>地址</th>"
							 + "<th style='width:90px'>市內電話</th>"
							 + "<th style='width:90px'>行動電話</th>"
							 + "<th style='width:100px'>帳號狀態</th>"
							 + "<th style='width:105px'>最後更新時間</th>"
							 + "<th style='width:85px'>異動</th></tr>";
				var adminRs = JSON.parse(xhr.responseText);
				for (var i = 0; i < adminRs.length; i++) {
					var dateTime = new Date(adminRs[i].ver).toLocaleString("zh-TW",{hour12:false}); 
					content += "<tr align='center'><td>" + adminRs[i].account + "</td>"
							+ "<td>" + adminRs[i].name + "</td>"
							+ "<td>" + adminRs[i].id + "</td>"
							+ "<td>" + adminRs[i].gender + "</td>"
							+ "<td>" + adminRs[i].birthday + "</td>"
							+ "<td>" + adminRs[i].email + "</td>"
							+ "<td>" + adminRs[i].city + "</td>"
							+ "<td>" + adminRs[i].district + "</td>"
							+ "<td>" + adminRs[i].address + "</td>"
							+ "<td>" + adminRs[i].tel + "</td>"
							+ "<td>" + adminRs[i].mobile + "</td>"
							+ "<td>" + adminRs[i].status +"</td>"
							+ "<td>" + dateTime + "</td>"
							+ "<td>" + '<button type="button" class="btn btn-sm btn-outline-danger test" data-toggle="modal" data-target="#staticBackdrop" id="'+ adminRs[i].account +'"> 修改狀態 </button>' + "</td>"
				}
				content += "</table>";
				var divs = document.getElementById("searchResultDiv");
				divs.innerHTML = content;
				
				$(".test").click(function(){
					var oid = $(this).attr('id');
// 					alert(oid);
					var selectAct = document.getElementById("selectAct");
					selectAct.value = oid;
				})
			}
		}
	}
}


// function submitStatus() {
	
// 	var selectValue = document.getElementById("selectStatus").value;
	
// 	if (selectValue == 00){
// 		window.alert("請選擇帳號修改的狀態")
// 	} else {
// 		if(confirm("確定要修改？")){
// 		 	window.alert("修改成功")
// 		 	form1.submit();
// 		}
// 	}
// }


$("#submitStatus").click(function(){
	var selectValue = document.getElementById("selectStatus").value;
	if (selectValue == 00){
		Swal.fire({
			toast: true,
    		position: 'top',
			showConfirmButton: false,
    		timer: 2000,
    		icon: 'error',
    		title: '請選擇帳號修改的狀態!!',
    	})
	} else {
			Swal.fire({
			icon: "question",
			showCancelButton: true,
			confirmButtonText: "確定",
			cancelButtonText: "取消",
			title: "確認修改?"
		}).then((result) => {
			if (result.isConfirmed) {
				Swal.fire({
					icon: "success",
					title: "修改成功！",
				}).then((result) => {
					$("#form1").submit();
				});
			}
		});
	}
});





</script>
<br><br><br><br><br><br><br><br><br><br>
<c:import url="../footer.jsp"/>
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script> -->
</body>
</html>