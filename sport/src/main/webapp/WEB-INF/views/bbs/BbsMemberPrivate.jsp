<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<meta charset="UTF-8">
<title>SportsGo!</title>
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

tbody {
	cursor: pointer;
}

#memberPrivateDiv {
	min-height: 300px;
}

</style>
</head>
<body>
<c:import url="../newheader.jsp"/>

<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">

<h2>我的發文與留言</h2>

	<div id="memberPrivateDiv" class="container-fluid pt-3">
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
				return "<p class='text-muted font-weight-light'><b style='font-size: 20px'>" + row.bbsTitleByDetail + "</b><br><span style='font-size: 12px' class='badge badge-secondary'>發文不存在</span></p>";
			} else {
				return "<a href='bbsSelect?bbsId=" + row.bbsId + "'><b style='font-size: 20px'>" + row.bbsTitleByDetail + "</b><br>" + row.bbsMessage + "</a>";
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
<c:import url="../footer.jsp"/>	
</body>
</html>