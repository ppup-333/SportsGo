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

	<form id="update" name="update" action="bbsUpdateSuccess" method="post"
		onclick="return false">
		<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
		<div>
			<div>
				<div>
					<h6>${bbs.bbsType.typeName}</h6>
					<input type="hidden" id="typeId" name="typeId"
						value="${bbs.bbsType.typeId}"> <input type="text"
						id="bbsTitle" name="bbsTitle" value="${bbs.bbsTitle}">
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
			<div>
				<textarea rows="20" cols="70" id="bbsMessage" name="bbsMessage">${bbs.bbsMessage}</textarea>
			</div>
		</div>

		<input type="submit" id="upDateYN" value="修改"> <input
			type="button" id="giveUpYN" value="放棄修改">

	</form>

	<script>
		$("#upDateYN").on("click", function() {
			$.confirm({
				title : "確定要修改發文嗎？",
				content : "按下確定修改發文，按下取消導回前頁",
				buttons : {
					確定 : function() {
						$.confirm({
							title : "已修改發文",
							content : "",
							buttons : {
								OK : function() {
									$("#update").submit();
								}
							}
						})
					},
					取消 : function() {
						history.back();
					}
				}
			});
		});

		$("#giveUpYN").on("click", function() {
			$.confirm({
				title : "確定要放棄修改發文嗎？",
				content : "按下確定將放棄修改發文並導回留言板首頁，按下取消繼續編輯",
				buttons : {
					確定 : function() {
						location.href = "bbs";
					},
					取消 : function() {

					}
				}
			});
		});
	</script>

</body>
</html>