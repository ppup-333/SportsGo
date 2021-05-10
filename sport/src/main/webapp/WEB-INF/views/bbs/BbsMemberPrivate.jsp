<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:import url="../header.jsp"/>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script	src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>
<link href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
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
				<table class="table table-striped" id="table" data-pagination="true" data-page-size="5"
					data-pagination-parts="['pageList']">
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
			<div class="col-2"></div>
		</div>
	</div>

	<script>
		//hover
		$("#table").on("click", "tr", function(){
			var url = $(this).find("a").attr("href");
			if(url !== undefined){
				window.location.href=url;
			}
		});
	
		var $table = $("#table");
		$.get("bbs.selectSearchPrivateBbs?typeId=0&bbsDelete=0", function(data) {
			$table.bootstrapTable({
				data : data
			});
			$table.bootstrapTable("load", data);
		});
	
		function TitleFormatter(value, row, index) {
			if (row.bbsDelete == 2) {
				return "<p class='text-muted font-weight-light'><b style='font-size: 20px'>" + row.bbsTitle + "</b><br><span style='font-size: 12px' class='badge badge-secondary'>發文不存在</span></p>";
			} else {
				return "<a href='bbsSelect?bbsId=" + row.bbsId + "'><b style='font-size: 20px'>" + row.bbsTitle + "</b><br>" + row.bbsMessage + "</a>";
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
	</script>

</body>
</html>