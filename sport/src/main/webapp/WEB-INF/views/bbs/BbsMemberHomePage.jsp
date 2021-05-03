<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
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

	<div class="container-sm">
		<a href="bbsdiscussion.c"><button type="button" class="btn btn-primary btn-sm">發文</button></a>

		<a href="bbs"><button type="button" class="btn btn-primary btn-sm">全部</button></a> 
		
		<select id="game" name="game" class="custom-select-sm">
			<option value="-1">-- 賽事討論 --</option>
			<c:forEach var="game" items="${gameList}">
				<option value="${game.typeId}"
					<c:if test="${game.typeId == typeId}">selected</c:if>>${game.typeName}</option>
			</c:forEach>
		</select>
		<script>
			$("#game").change(
				function() {
					var $table = $("#table");
					$.get("bbs.selectSearch?typeId=" + $("#game").val() + "&bbsDelete=0",
						function(data) {
							$table.bootstrapTable({
								data : data
							});
								$table.bootstrapTable("load", data);
						});
				});
		</script>

		<select id="health" name="health" class="custom-select-sm">
			<option value="-2">-- 健康情報 --</option>
			<c:forEach var="health" items="${healthList}">
				<option value="${health.typeId}"
					<c:if test="${health.typeId == typeId}">selected</c:if>>${health.typeName}</option>
			</c:forEach>
		</select>
		<script>
			$("#health").change(
				function() {
					var $table = $("#table");
					$.get("bbs.selectSearch?typeId=" + $("#health").val() + "&bbsDelete=0",
						function(data) {
							$table.bootstrapTable({
								data : data
							});
								$table.bootstrapTable("load", data);
						});
				});
		</script>

		<select id="sport" name="sport" class="custom-select-sm">
			<option value="-3">-- 揪團運動 --</option>
			<c:forEach var="sport" items="${sportList}">
				<option value="${sport.typeId}"
					<c:if test="${sport.typeId == typeId}">selected</c:if>>${sport.typeName}</option>
			</c:forEach>
		</select>
		<script>
			$("#sport").change(
				function() {
					var $table = $("#table");
					$.get("bbs.selectSearch?typeId=" + $("#sport").val() + "&bbsDelete=0",
						function(data) {
							$table.bootstrapTable({
								data : data
							});
								$table.bootstrapTable("load", data);
						});
				});
		</script>

			<input type="search" id="search" name="search" autocomplete="off"
				placeholder="輸入查詢字串...">
			<input id="searchImage"
				type="image" src="images/magnifier.png" width="20" height="20">

		<table class="table table-striped" id="table" data-pagination="true" data-page-size="5"
			data-pagination-parts="['pageList']">
			<thead>
				<tr>
					<th data-field="typeName"></th>
					<th data-field="bbsTitle"  data-formatter="TitleFormatter" id="deleteByManager">標題<br>內文</th>
					<th data-field="bbsBuilder" data-formatter="BuilderFormatter">建立者</th>
					<th data-field="replySetupTime" data-formatter="ReplyFormatter">最新回覆</th>
				</tr>
			</thead>
		</table>
		<script>
			var $table = $("#table");
			$.get("bbs.selectSearch?typeId=0&bbsDelete=0", function(data) {
				$table.bootstrapTable({
					data : data
				});
				$table.bootstrapTable("load", data);
			});
			
			function TitleFormatter(value, row, index) {
				if (row.bbsDelete == 2) {
					return "<p class='text-muted font-weight-light'>" + value + "<br><span class='badge badge-secondary'>發文不存在</span></p>";
				} else {
					return "<a href='bbsSelect?bbsId=" + row.bbsId + "'>"
							+ value + "<br>" + row.bbsMessage + "</a>";
				}
			}

			function BuilderFormatter(value, row, index) {
				return row.bbsBuilder + "<br>" + row.bbsSetupTime;
			}
			
			function ReplyFormatter(value, row, index) {
				if(row.replyAccount != null){
					return row.replyAccount + "<br>" + row.replySetupTime;
				}else{
					return "";
				}
			}
			
			$("#searchImage").on("click", function() {
				var $table = $('#table');
				$.get("bbsdiscussion.r?search="+$("#search").val(), function(data) {
					$table.bootstrapTable({
						data : data
					});
					$table.bootstrapTable('load', data);
				});
			});
		</script>
	</div>
</body>
</html>