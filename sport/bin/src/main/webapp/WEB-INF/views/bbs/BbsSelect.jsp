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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form id="select" name="select" action="bbsDelete" method="post"
		onclick="return false">
		<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
		<div>
			<div>
				<div>
					<h6>${bbs.bbsType.typeName}</h6>
					<h1>${bbs.bbsTitle}</h1>
				</div>

			</div>
			<hr>
			<div>
				<p>${bbs.bbsBuilder}</p>
			</div>
			<div>
				<p>
					<fmt:formatDate value="${bbs.bbsSetupTime}"
						pattern="YYYY-MM-dd HH:mm" />
					<br>
					<fmt:formatDate value="${bbs.bbsUpdateTime}"
						pattern="YYYY-MM-dd HH:mm" />
				</p>
			</div>
			<div>${bbs.bbsMessage}</div>
		</div>

		<button type="submit" id="deteleYN">刪除</button>
		<button type="button" id="upDate">編輯</button>
		<button type="button" id="reply">回覆</button>
		
	</form>

	<script>
		$("#deteleYN").on("click", function() {
			$.confirm({
				title : "確定要刪除發文嗎？",
				content : "確定刪除後將無法還原",
				buttons : {
					確定 : function() {
						$.confirm({
							title : "已成功刪除發文",
							content : "",
							buttons : {
								OK : function(){
								$("#select").submit();	
								}
							}
						});
					},
					取消 : function() {

					}
				}
			});
		});

		$("#upDate").on("click", function() {
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "bbsUpdate");
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "bbsId");
			hiddenField.setAttribute("value", $("#bbsId").val());
			form.appendChild(hiddenField);
			document.body.appendChild(form);
			form.submit();
		});
		
		$("#reply").on("click", function() {
			var form = document.createElement("form");
			form.setAttribute("method", "get");
			form.setAttribute("action", "bbsReply");
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "bbsId");
			hiddenField.setAttribute("value", $("#bbsId").val());
			form.appendChild(hiddenField);
			document.body.appendChild(form);
			form.submit();
		});
	</script>

</body>
</html>