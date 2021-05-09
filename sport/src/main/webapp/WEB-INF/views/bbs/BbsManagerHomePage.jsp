<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../header.jsp"/>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<link href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css" rel="stylesheet">
<script	src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

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

table {
cursor: pointer;
}

</style>
</head>
<body>
	
	<div class="container-fluid pt-3">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row">
					<div class="dropdown col-3">
						<button type="button" id="selectDropdown" name="selectDropdown" class="btn btn-primary btn-sm dropdown-toggle"
							data-toggle="dropdown">選擇狀態</button>
						<ul class="dropdown-menu">
							<li class="dropdown-item" onclick="selectDelete(-1)">全部</li> 
							<li class="dropdown-item" onclick="selectDelete(0)">正常</li>
							<li class="dropdown-item" onclick="selectDelete(1)">用戶刪除</li>
							<li class="dropdown-item" onclick="selectDelete(2)">管理員刪除</li>
						</ul>
					</div>
					<div class="col-6">
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
							placeholder="輸入查詢字串...">
						<input id="searchImage"	type="image" src="images/magnifier.png" width="20" height="20">
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
				<table class="table table-striped" id="table" data-pagination="true" data-page-size="5"
					data-pagination-parts="['pageList']">
					<thead>
						<tr>
							<th data-field="bbsDelete" data-formatter="DeleteFormatter" data-halign="center" data-align="center" data-width="80">狀態</th>
							<th data-field="bbsId" data-halign="center" data-align="center" data-width="80">序號</th>
							<th data-field="typeName" data-halign="center" data-align="center" data-width="80">類型</th>
							<th data-field="bbsTitle"  data-formatter="TitleFormatter" data-halign="center" data-align="left">發文</th>
							<th data-field="bbsBuilder" data-formatter="BuilderFormatter" data-halign="center" data-align="center" data-width="180">建立者</th>
							<th data-field="replySetupTime" data-formatter="ReplyFormatter" data-halign="center" data-align="center" data-width="180">最新回覆</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="col-2"></div>
		</div>		
	</div>
	
	<script>
		//dropdown
		function selectDelete(deleteType){
			var $table = $('#table');
			$.get("bbsM.selectSearchByBbsDelete?bbsDelete=" + deleteType,
			function(data) {
				$table.bootstrapTable({
					data : data
				});
				$table.bootstrapTable('load', data);
			});
		}
				
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
				return "<span class='badge badge-success'>正常</span>";
			} else if(row.bbsDelete == 1){
				return "<span class='badge badge-secondary'>用戶刪除</span>";
			} else {
				return "<span class='badge badge-warning'>管理員刪除</span>";
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