<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table class="table table-striped" id="table" data-pagination="true" data-page-size="5"
		data-pagination-parts="['pageList']">
		<thead>
			<tr>
				<th data-field="typeName" data-formatter="TypeFormatter"></th>
				<th data-field="bbsTitle"  data-formatter="TitleFormatter"></th>
				<th data-field="bbsBuilder" data-formatter="BuilderFormatter"></th>
				<th data-field="replySetupTime" data-formatter="ReplyFormatter">最新回覆</th>
			</tr>
		</thead>
	</table>

	<script>
		function TitleFormatter(value, row, index) {
			
		}
	</script>

</body>
</html>