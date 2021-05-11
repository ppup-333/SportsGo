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
		height:40px;
		width:auto;
	}
	
	.d1{
		width:300px;
	}
	
	.d2{
		position:relative;
		top:-12px;
    	left:850px;
		width:250px;
		height:60px;
	}
	
	.f1{
		height:60px; 
  		width:500px;  
		margin:auto;
		margin-top:20px;
	}
	
	#teble1 td{
		padding:5px;
	}
	
	.selectDiv{ 
 		width:1400px; 
 		margin:auto;  
 	}
	
</style>
<meta charset="UTF-8">
<title>管理者資料管理</title>
<!-- <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet"> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<!--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script> -->
<!-- <link rel="stylesheet" href="jqueryui/style.css"> -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous"> -->
</head>
<body>
<c:import url="../newheaderM.jsp"/>

<fieldset class='f1'>
	<legend>管理者資料查詢</legend>
	<form:form method="POST" modelAttribute="userAuth" enctype='multipart/form-data' action="">
		<div class='d1'>
			<table id='tb1'>
				<tr>
					<td width='360px'>請輸入帳號：&nbsp;</td>
					<td><form:input path="account" id="account"/>&nbsp;&nbsp;</td>
				</tr>
			</table>
		</div>
	</form:form>
</fieldset>
	<div class="d2">
	<button onclick="select1()">查詢</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button type="button" class="" data-toggle="modal" data-target="#addAdmin">新增管理者</button>
	</div>	
	<div class="modal fade" id="daleteAdmin" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  			<div class="modal-dialog">
    			<div class="modal-content">
     				<div class="modal-header">
        				<h5 class="modal-title" id="staticBackdropLabel">移除管理者權限</h5>
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          					<span aria-hidden="true">&times;</span>
        				</button>
      				</div>
      			<form method="POST" action="DeleteAdmin" id="form1" name="form1">
      				<div class="modal-body">
      					<table>
							<tr>
								<td>確認要移除權限的帳號：&nbsp;</td>
								<td><input type='text' readonly id='selectAct' name='selectAct'/>&nbsp;&nbsp;</td>
							</tr>
						</table>
      				</div>
      			</form>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        				<button type="button" class="btn btn-primary" onclick="deleteAdmin()">確認送出</button>
      				</div>
    			</div>
  			</div>
		</div>
		
		<div class="modal fade" id="addAdmin" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  			<div class="modal-dialog">
    			<div class="modal-content">
     				<div class="modal-header">
        				<h5 class="modal-title" id="staticBackdropLabel">新增管理者權限</h5>
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          					<span aria-hidden="true">&times;</span>
        				</button>
      				</div>
      			<form method="POST" action="AddAdmin" id="form2" name="form2">
      				<div class="modal-body">
      					<table>
							<tr>
								<td>請輸入要新增的帳號：&nbsp;</td>
								<td><input type='text' id='inputAct' name='inputAct'/>&nbsp;&nbsp;</td>
							</tr>
						</table>
      				</div>
      			</form>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        				<button type="button" class="btn btn-primary" onclick="addAdmin()">確認送出</button>
<!--         				<button type="button" class="btn btn-primary" id="add1">確認送出</button> -->
      				</div>
    			</div>
  			</div>
		</div>
		
<!-- 		<div> -->
<!-- 			<button id='search'>查詢</button>&nbsp;&nbsp; -->
<!-- 			<button type="button" class="" data-toggle="modal" data-target="#addAdmin">新增管理者</button> -->
<!-- 		</div><br> -->
		<div id='searchResultDiv' class='selectDiv'></div>

<script>

var alink = document.getElementById("search");
alink.onclick = function() {
	select1();
};
	

function select1(){
// 	window.alert("123")
	var account = document.getElementById("account");
	
	if(account.value == ""){
		alert("請輸入查詢的帳號");
	} else {

		var account = document.getElementById("account").value;
		
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "<c:url value='/admin/ResultAdmin' />", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		
		xhr.send("account=" + account);
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var content = "<table border='1' id='teble1'>";
				content += "<tr align='center'>"
					 + "<th style='width:80px'>帳號</th>"
					 + "<th style='width:100px'>姓名</th>"
					 + "<th style='width:100px'>身分證字號</th>"
					 + "<th style='width:50px'>性別</th>"
					 + "<th style='width:100px'>生日</th>"
					 + "<th style='width:100px'>email</th>"
					 + "<th style='width:80px'>城市</th>"
					 + "<th style='width:110px'>鄉鎮市區</th>"
					 + "<th style='width:180px'>地址</th>"
					 + "<th style='width:90px'>市內電話</th>"
					 + "<th style='width:90px'>行動電話</th>"
					 + "<th style='width:100px'>帳號權限</th>"
					 + "<th style='width:130px'>最後更新時間</th>"
					 + "<th style='width:120px'>異動</th></tr>";
				var adminRs = JSON.parse(xhr.responseText);
				for (var i = 0; i < adminRs.length; i++) {
					var dateTime = new Date(adminRs[i].ver).toLocaleString("zh-TW"); 
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
							+ "<td>" + adminRs[i].auth +"</td>"
							+ "<td>" + dateTime + "</td>"
							+ "<td>" + '<button type="button" class="btn btn-primary test" data-toggle="modal" data-target="#daleteAdmin" id="'+ adminRs[i].account +'"> 移除權限 </button>' + "</td>"
				}
				content += "</table>";
				var divs = document.getElementById("searchResultDiv");
				divs.innerHTML = content;
// 				window.alert(content)
				
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

// function addAdmin(){
// 	var inputAct = selectAct = document.getElementById("inputAct").value;
	
// 	if(inputAct == ""){
// 		window.alert("請輸入要新增的帳號")
// 	} else if (inputAct.indexOf(" ") != -1){
// 		window.alert("不可輸入空白字元")
// 	} else {
// 		if(confirm("確定新增此帳號為管理員？")){
// 		 	window.alert("新增成功")
// 		 	form2.submit();
// 		}
// 	}
// }

// function deleteAdmin() {
	
// 	if(confirm("確定刪除此帳號的管理員權限？")){
// 	 	window.alert("刪除成功")
// 	 	form1.submit();
// 	}
// }

function deleteAdmin(){
	Swal.fire({
		icon: "question",
		showCancelButton: true,
		confirmButtonText: "確定",
		cancelButtonText: "取消",
		title: "確定刪除此帳號管理者權限?"
	}).then((result) => {
		if (result.isConfirmed) {
			Swal.fire({
				icon: "success",
				title: "刪除成功！",
			}).then((result) => {
				$("#form1").submit();
			});
		}
	});
	
	
}

function addAdmin(){
	var inputAct = document.getElementById("inputAct").value;
	if(inputAct == ""){
		Swal.fire({
			toast: true,
    		position: 'top',
			showConfirmButton: false,
    		timer: 2000,
    		icon: 'error',
    		title: '請輸入要新增的帳號!!',
    	})
	} else if (inputAct.indexOf(" ") != -1){
		Swal.fire({
			toast: true,
    		position: 'top',
			showConfirmButton: false,
    		timer: 2000,
    		icon: 'error',
    		title: '不可輸入空白字元!!',
    	})
	} else {
		Swal.fire({
			icon: "question",
			showCancelButton: true,
			confirmButtonText: "確定",
			cancelButtonText: "取消",
			title: "確定新增此帳號管理者權限?"
		}).then((result) => {
			if (result.isConfirmed) {
				Swal.fire({
					icon: "success",
					title: "新增成功！",
				}).then((result) => {
					$("#form2").submit();
				});
			}
		});
	}
};		



</script>
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script> -->
</body>
</html>