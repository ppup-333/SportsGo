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
</head>
<body>

<div class="container pt-3">
	<table class="table table-striped" id="table" data-pagination="true" data-page-size="5"
		data-pagination-parts="['pageList']">
		<thead>
			<tr>
				<th data-field="typeName"></th>
				<th data-field="bbsTitle"  data-formatter="TitleFormatter"></th>
				<th data-field="bbsBuilder" data-formatter="BuilderFormatter"></th>
				<th data-field="replySetupTime" data-formatter="ReplyFormatter">最新回覆</th>
			</tr>
		</thead>
	</table>
</div>

	<script>
		var $table = $("#table");
		$.get("bbs.selectSearchPrivateBbs?typeId=0&bbsDelete=0", function(data) {
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
	</script>

</body>
</html>