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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form id="update" name="update" action="bbsUpdateSuccess" method="post"
		onclick="return false">
		<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
		<div>
			<select name ="typeId" id="selectGroup" class="custom-select-sm">
				<optgroup label="賽事討論">
					<c:forEach var="game" items="${gameList}">
						<option value="${game.typeId}"
							<c:if test="${game.typeId == bbs.bbsType.typeId}">selected</c:if>>${game.typeName}</option>
					</c:forEach>
				</optgroup>
				<optgroup label="健康情報">
					<c:forEach var="health" items="${healthList}">
						<option	value="${health.typeId}" <c:if test="${health.typeId == bbs.bbsType.typeId}">selected</c:if>>${health.typeName}</option>
					</c:forEach>
				</optgroup>
				<optgroup label="揪團運動">
					<c:forEach var="sport" items="${sportList}">
						<option	value="${sport.typeId}" <c:if test="${sport.typeId == bbs.bbsType.typeId}">selected</c:if>>${sport.typeName}</option>
					</c:forEach>
				</optgroup>
			</select>
			<input type="text" id="bbsTitle" name="bbsTitle" size="40" value="${bbs.bbsTitle}">
		</div>

			<hr>
			
		<div>
			<p>${bbs.bbsBuilder}</p>
			<p align="right">
				建立時間：<fmt:formatDate value="${bbs.bbsSetupTime}"
					pattern="YYYY-MM-dd HH:mm" />
		<br>
				最後編輯：<fmt:formatDate value="${bbs.bbsUpdateTime}"
					pattern="YYYY-MM-dd HH:mm" />
			</p>
		</div>
		<div>
			<textarea id="bbsMessage" name="bbsMessage" rows="15" cols="60" style="resize: none">${bbs.bbsMessage}</textarea>
		</div>

		<input type="submit" id="upDateYN" class="btn btn-danger" value="修改">
		<input type="button" id="giveUpYN" class="btn btn-primary" value="放棄修改">
	</form>

	<script>
		$("#upDateYN").on("click", function() {
			$.confirm({
				title : "確定要修改發文嗎？",
				content : "按下確定修改發文，按下取消繼續編輯。",
				buttons : {
					確定 : function() {
						$.confirm({
							title : "已修改發文！",
							content : "",
							buttons : {
								OK : function() {
									$("#update").submit();
								}
							}
						})
					},
					取消 : function() {
					}
				}
			});
		});

		$("#giveUpYN").on("click", function() {
			$.confirm({
				title : "確定要放棄修改發文嗎？",
				content : "按下確定將放棄修改發文並導回前頁，按下取消繼續編輯。",
				buttons : {
					確定 : function() {
						window.history.back();
					},
					取消 : function() {

					}
				}
			});
		});
	</script>

</body>
</html>