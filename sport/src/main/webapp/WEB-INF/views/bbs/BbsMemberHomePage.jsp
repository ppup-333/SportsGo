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

#createBbs {
	 position: relative;
	 left: 10%;
	 top: 20%;
	 width: 50%;
}

#po {
	background-color: white;
	color: black;
	border: 1px solid black;
	border-radius: 2px;
	font-size: 14px;
	height: 31px;
	position: relative;
	top: 19%;
}

select {
 	border: 1px solid black;
 	border-radius: 2px;
 	position: relative;
 	top: 20%;
 	width: 21%;
 	margin-left: 3%;
}

#search {
	border-radius: 3px;
	border: 1px solid black;
	height: 28px
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
<c:import url="../newheader.jsp"/>
<h2>討論區</h2>
	<div class="container-fluid pt-3">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row">
					<div class="col-2">
						<button type="button" id="createBbs" class="btn btn-info btn-sm"><b>發 文</b></button>
					</div>
					<div class="col-7">
						<a href="bbs"><button type="button" id="po"> -- 全部發文 -- <i class="fa fa-angle-down" aria-hidden="false"></i></button></a> 
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
						<input id="searchImage" type="image" src="images/magnifier.png">
					</div>
				</div>
			<div class="col-2"></div>
			</div>
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
							<th data-field="typeName" data-halign="center" data-align="center" data-width="140">類型</th>
							<th data-field="bbsTitle"  data-formatter="TitleFormatter" data-halign="center" data-align="left" data-width="400"></th>
							<th data-field="bbsSetupTime" data-formatter="BuilderFormatter" data-halign="center" data-align="center" data-width="200">建立者</th>
							<th data-field="replySetupTime" data-formatter="ReplyFormatter" data-halign="center" data-align="center" data-width="200">最新回覆</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="col-2"></div>
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
		
		//hover
		$("#table").on("click", "tr", function(){
			var url = $(this).find("a").attr("href");
			if(url !== undefined){
				window.location.href=url;
			}
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
				return "<p class='text-muted font-weight-light'><b style='font-size: 20px'>" + row.bbsTitleByDetail + "</b><br><span style='font-size: 12px' class='badge badge-secondary'>發文不存在</span></p>";
			} else {
				return "<a href='bbsSelect?bbsId=" + row.bbsId + "'><b style='font-size: 20px;'>" + row.bbsTitleByDetail + "</b><br><small style='font-size: 15px;'>" + row.bbsMessage + "</small></a>";
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
		
// 		$("#search").on("keydown", function(){
// 			var $table = $('#table');
// 			$.get("bbsdiscussion.r?search=" + $("#search").val(),
// 			function(data) {
// 				$table.bootstrapTable({
// 					data : data
// 				});
// 				$table.bootstrapTable('load', data);
// 			});
// 		})

		$("#createBbs").on("click", function(){
			if(${sessionScope.account == null}) {
				$("#loginModal").modal("show");
				return false;
			}else {
				window.location.href="bbsdiscussion.c";
			}
		});
		
	</script>
</body>
</html>