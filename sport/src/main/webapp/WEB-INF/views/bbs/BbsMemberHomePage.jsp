<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<%-- <c:import url="../header.jsp"/> --%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" 
	crossorigin="anonymous">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<link
	href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css"
	rel="stylesheet">
<script
	src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<a href="bbsMemberPrivate"><button type="button" class="btn btn-primary btn-sm">我的發文與留言</button></a>

	<div class="container-fluid pt-3">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<a href="bbsdiscussion.c"><button type="button" class="btn btn-primary btn-sm">發文</button></a>
	
				<a href="bbs"><button type="button" class="btn btn-primary btn-sm">全部</button></a> 
			
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
				
<!-- 				<input type="search" id="search" name="search" autocomplete="off" -->
<!-- 					placeholder="輸入查詢字串..."> -->
<!-- 				<input id="searchImage" -->
<!-- 					type="image" src="images/magnifier.png" width="20" height="20"> -->
			<div class="col-2"></div>
			</div>
		</div>
	</div>
		
		<br>
		
	<div class="container-fluid">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<table class="table table-striped" id="table" data-pagination="true" data-page-size="5"
					data-pagination-parts="['pageList']" data-search="true">
					<thead>
						<tr>
							<th data-field="typeName" data-halign="center" data-align="center" data-width="100">類型</th>
							<th data-field="bbsTitle"  data-formatter="TitleFormatter" data-halign="center" data-align="left"></th>
							<th data-field="bbsBuilder" data-formatter="BuilderFormatter" data-halign="center" data-align="center" data-width="180">建立者</th>
							<th data-field="replySetupTime" data-formatter="ReplyFormatter" data-halign="center" data-align="center" data-width="180">最新回覆</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="2"></div>
		</div>
	</div>
	
	<script>
		$("#game").change(function() {
			var $table = $("#table");
			$.get("bbs.selectSearch?typeId=" + $("#game").val() + "&bbsDelete=0",
			function(data) {
				$table.bootstrapTable({
					data : data
				});
				$table.bootstrapTable("load", data);
			});
		});
			
		$("#health").change(function() {
			var $table = $("#table");
			$.get("bbs.selectSearch?typeId=" + $("#health").val() + "&bbsDelete=0",
			function(data) {
				$table.bootstrapTable({
					data : data
				});
				$table.bootstrapTable("load", data);
			});
		});
			
		$("#sport").change(function() {
			var $table = $("#table");
			$.get("bbs.selectSearch?typeId=" + $("#sport").val() + "&bbsDelete=0",
			function(data) {
				$table.bootstrapTable({
					data : data
				});
				$table.bootstrapTable("load", data);
			});
		});
		
		var $table = $("#table");
		$.get("bbs.selectSearch?typeId=0&bbsDelete=0", function(data) {
			$table.bootstrapTable({
				data : data
			});
			$table.bootstrapTable("load", data);
		});
			
		function TitleFormatter(value, row, index) {
			if (row.bbsDelete == 2) {
				return "<p class='text-muted font-weight-light'><b>" + value + "</b><br><span class='badge badge-secondary'>發文不存在</span></p>";
			} else {
				return "<a href='bbsSelect?bbsId=" + row.bbsId + "'><b style='font-size: 20px'>" + value + "</b><br>" + row.bbsMessage + "</a>";
			}
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
			$.get("bbsdiscussion.r?search=" + $("#search").val(),
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