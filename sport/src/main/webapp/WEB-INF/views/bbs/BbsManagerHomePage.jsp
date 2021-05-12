<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

#selectDropdown {
 	background-color: white;
 	color: black;
 	border: 1px solid black;
 	border-radius: 2px;
 	font-size: 14px;
 	height: 31px;
 	position: relative;
 	top: 20%;
}

select {
 	border: 1px solid black;
 	border-radius: 2px;
 	position: relative;
 	top: 20%;
 	width: 17%;
 	margin-left: 3%;
}

#search {
	border-radius: 3px;
 	border: 1px solid black;
 	height: 28px;
} 

#searchImage {
	position: relative;
	top: 20%;
	width: 28px;
	height: 28px;
}

a {
	text-decoration: none;
	color: black;
}

a:link {
	text-decoration: none;
	color: black;
}

a:hover {
	color: black;
}

tbody {
	cursor: pointer;
}

table.table-hover tbody tr:hover {
    background-color: #d7e5f4; 
}

</style>
</head>
<body>
<c:import url="../newheaderM.jsp"/>
<h2>討論區</h2>	
	<div class="container-fluid pt-3">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row">
<!-- 					<div class="dropdown col-3"> -->
<!-- 						<button type="button" id="selectDropdown" name="selectDropdown" class="btn btn-primary btn-sm dropdown-toggle" -->
<!-- 							data-toggle="dropdown"> -- 選擇狀態 -- </button> -->
<!-- 						<ul class="dropdown-menu"> -->
<!-- 							<li class="dropdown-item" onclick="selectDelete(-1)"> 全部 </li>  -->
<!-- 							<li class="dropdown-item" onclick="selectDelete(0)"> 正常 </li> -->
<!-- 							<li class="dropdown-item" onclick="selectDelete(1)"> 用戶刪除 </li> -->
<!-- 							<li class="dropdown-item" onclick="selectDelete(2)"> 管理員刪除 </li> -->
<!-- 						</ul> -->
<!-- 					</div> -->
					<div class="col-9">
						<select id="selectDropdown" class="custom-select-sm">
							<option value="">-- 選擇狀態 --</option>
							<option value="-1">全部</option>
							<option value="0">正常</option>
							<option value="1">用戶刪除</option>
							<option value="2">管理員刪除</option>
						</select>
<!-- 					<div class="col-6"> -->
						<select id="game" name="game" class="custom-select-sm">
							<option value="-1">-- 賽事討論 --</option>
							<c:forEach var="game" items="${gameList}">
								<option value="${game.typeId}"
									<c:if test="${game.typeId == typeId}">selected</c:if>>${game.typeName}</option>
							</c:forEach>
						</select>
				
						<select id="health" name="health" class="custom-select-sm">
							<option value="-2">-- 健康情報 --</option>
							<c:forEach var="health" items="${healthList}">
								<option value="${health.typeId}"
									<c:if test="${health.typeId == typeId}">selected</c:if>>${health.typeName}</option>
							</c:forEach>
						</select>
						
						<select id="sport" name="sport" class="custom-select-sm">
							<option value="-3">-- 揪團運動 --</option>
							<c:forEach var="sport" items="${sportList}">
								<option value="${sport.typeId}"
									<c:if test="${sport.typeId == typeId}">selected</c:if>>${sport.typeName}</option>
							</c:forEach>
						</select>
					</div>	
					<div class="col-3" align="right">
						<input type="search" id="search" name="search" autocomplete="off"
							placeholder=" 輸入查詢字串...">
						<input id="searchImage"	type="image" src="images/magnifier.png" width="25" height="25">
					</div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
		
		<br>
		
	<div class="container-fluid">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<table class="table table-striped table-borderless" id="table" data-pagination="true" data-page-size="5"
					data-pagination-parts="['pageList']">
					<thead>
						<tr>
							<th data-field="bbsDelete" data-formatter="DeleteFormatter" data-halign="center" data-align="center" data-width="80">狀態</th>
							<th data-field="bbsId" data-halign="center" data-align="center" data-width="60">序號</th>
							<th data-field="typeName" data-halign="center" data-align="center" data-width="90">類型</th>
							<th data-field="bbsTitle"  data-formatter="TitleFormatter" data-halign="center" data-align="left" data-width="460">發文</th>
							<th data-field="bbsBuilder" data-formatter="BuilderFormatter" data-halign="center" data-align="center" data-width="185">建立者</th>
							<th data-field="replySetupTime" data-formatter="ReplyFormatter" data-halign="center" data-align="center" data-width="185">最新回覆</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="col-2"></div>
		</div>		
	</div>
	
	<script>
		//dropdown
// 		function selectDelete(deleteType){
// 			var $table = $("#table");
// 			if(deleteType == -1) {
// 				$("#selectDropdown").text(" 全部 ");
// 			} else if(deleteType == 0) {
// 				$("#selectDropdown").text(" 正常 ");
// 			} else if(deleteType == 1) {
// 				$("#selectDropdown").text(" 用戶刪除 ");
// 			} else {
// 				$("#selectDropdown").text(" 管理員刪除 ");
// 			}
// 			$.get("bbsM.selectSearchByBbsDelete?bbsDelete=" + deleteType,
// 			function(data) {
// 				$table.bootstrapTable({
// 					data : data
// 				});
// 				$table.bootstrapTable("load", data);
// 			});
// 		}
		
		$("#selectDropdown").change(function() {
			var $table = $('#table');
			$.get("bbsM.selectSearchByBbsDelete?bbsDelete=" + $("#selectDropdown").val(),
			function(data) {
				$table.bootstrapTable({
					data : data
				});
				$table.bootstrapTable('load', data);
			});
		});
				
		$("#game").change(function() {
			var $table = $('#table');
			$.get("bbsM.selectSearch?typeId=" + $("#game").val(),
			function(data) {
				$table.bootstrapTable({
					data : data
				});
				$table.bootstrapTable('load', data);
			});
		});
	
		$("#health").change(function() {
			var $table = $('#table');
			$.get("bbsM.selectSearch?typeId=" + $("#health").val(),
			function(data) {
				$table.bootstrapTable({
					data : data
				});
				$table.bootstrapTable('load', data);
			});
		});
	
		$("#sport").change(function() {
			var $table = $('#table');
			$.get("bbsM.selectSearch?typeId=" + $("#sport").val(),
			function(data) {
				$table.bootstrapTable({
					data : data
				});
				$table.bootstrapTable('load', data);
			});
		});
		
		//hover
		$("#table").on("click", "tr", function(){
			var url = $(this).find("a").attr("href");
			if(url !== undefined){
				window.location.href=url;
			}
		});
	
		var $table = $('#table');
		$.get("bbsM.selectSearch?typeId=0", function(data) {
			$table.bootstrapTable({
				data : data
			});
			$table.bootstrapTable('load', data);
		});
		
		function DeleteFormatter(value, row, index) {
			if(row.bbsDelete == 0){
				return "<h5><span class='badge badge-success'>正常</span></h5>";
			} else if(row.bbsDelete == 1){
				return "<h5><span class='badge badge-secondary'>用戶刪除</span></h5>";
			} else {
				return "<h5><span class='badge badge-warning'>管理員刪除</span></h5>";
			}
		}
			
		function TitleFormatter(value, row, index) {
			return "<a href='bbsM.Select?bbsId=" + row.bbsId + "'><b style='font-size: 20px'>" + value + "</b><br>" + row.bbsMessage + "</a>";
		}
	
		function BuilderFormatter(value, row, index) {
			return row.account + "<br>" + row.bbsSetupTime;
		}
			
		function ReplyFormatter(value, row, index) {
			if (row.replyAccount != null) {
				return row.replyAccount + "<br>" + row.replySetupTime;
			} else {
				return "";
			}
		}
	
		$("#searchImage").on("click", function() {
			var $table = $('#table');
			$.get("bbsM.discussion.r?search=" + $("#search").val(),
			function(data) {
				$table.bootstrapTable({
					data : data
				});
				$table.bootstrapTable('load', data);
			});
		});
	</script>
</body>
</html>