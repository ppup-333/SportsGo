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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<a href="bbsdiscussion.c"><input type="button" value="發文"></a>

	<a href="bbs"><input type="button" value="全部"></a>

	<select id="game" name="game">
		<option value="">-- 賽事討論 --</option>
		<c:forEach var="game" items="${gameList}">
			<option value="${game.typeId}"
				<c:if test="${game.typeId == typeId}">selected</c:if>>${game.typeName}</option>
		</c:forEach>
	</select>
	<script>
		$("#game").change(function() {
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "bbs.selectSearch");
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "typeId");
			hiddenField.setAttribute("value", $("#game").val());
			form.appendChild(hiddenField);
			document.body.appendChild(form);
			form.submit();
		});
	</script>

	<select id="health" name="health">
		<option value="">-- 健康情報 --</option>
		<c:forEach var="health" items="${healthList}">
			<option
				value="${health.typeId} <c:if test="${health.typeId == typeId}">selected</c:if>">${health.typeName}</option>
		</c:forEach>
	</select>
	<script>
		$("#health").change(function() {
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "bbs.selectSearch");
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "typeId");
			hiddenField.setAttribute("value", $("#health").val());
			form.appendChild(hiddenField);
			document.body.appendChild(form);
			form.submit();
		});
	</script>

	<select id="sport" name="sport">
		<option value="">-- 揪團運動 --</option>
		<c:forEach var="sport" items="${sportList}">
			<option
				value="${sport.typeId} <c:if test="${sport.typeId == typeId}">selected</c:if>">${sport.typeName}</option>
		</c:forEach>
	</select>
	<script>
		$("#sport").change(function() {
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "bbs.selectSearch");
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "typeId");
			hiddenField.setAttribute("value", $("#sport").val());
			form.appendChild(hiddenField);
			document.body.appendChild(form);
			form.submit();
		});
	</script>

	<form action="bbsdiscussion.r" method="get">
		<input type="search" id="search" name="search" autocomplete="off"
			placeholder="輸入查詢字串..."> <input type="image"
			src="images/magnifier.png" width="20" height="20">
	</form>

	<form action="bbsdiscussion.r" method="get">
		<table border="1">
			<tr>
				<th>類型</th>
				<th>建立者</th>
				<th>標題及內文</th>
				<th>建立時間</th>
				<th>最後編輯時間</th>
			</tr>
			<c:if test="${searchList.size() > 0}">
				<c:forEach var="search" items="${searchList}">
					<tr>
						<td>${search.bbsType.typeName}</td>
						<td>${search.bbsBuilder}</td>
						<td><a
							href="<c:url value='bbsSelect' />?bbsId=${search.bbsId}">
								<div>
									<div>
										<p>${search.bbsTitle}</p>
									</div>
									<p>${search.bbsMessage}</p>
								</div>
						</a></td>
						<td><fmt:formatDate value="${row.bbsSetupTime}"
								pattern="YYYY-MM-dd" /><br> <fmt:formatDate
								value="${row.bbsSetupTime}" pattern="HH:mm" /></td>
						<td><fmt:formatDate value="${row.bbsUpdateTime}"
								pattern="YYYY-MM-dd" /><br> <fmt:formatDate
								value="${row.bbsUpdateTime}" pattern="HH:mm" /></td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${searchList.size() == 0}">
				<tr>
					<td colspan="5" align="center">查無資料</td>
				</tr>
			</c:if>
		</table>
	</form>
</body>
</html>