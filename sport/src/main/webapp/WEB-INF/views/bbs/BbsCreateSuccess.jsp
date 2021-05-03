<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- 	<table border="1"> -->
	<!-- 		<tr> -->
	<!-- 			<td>編號</td> -->
	<%-- 			<td>${bbs.bbsId}</td> --%>
	<!-- 		</tr> -->
	<!-- 		<tr> -->
	<!-- 			<td>標題</td> -->
	<%-- 			<td>${bbs.bbsTitle}</td> --%>
	<!-- 		</tr> -->
	<!-- 		<tr> -->
	<!-- 			<td>內文</td> -->
	<%-- 			<td>${bbs.bbsMessage}</td> --%>
	<!-- 		</tr> -->
	<!-- 		<tr> -->
	<!-- 			<td>類型</td> -->
	<%-- 			<td>${bbs.bbsType.typeName}</td> --%>
	<!-- 		</tr> -->
	<!-- 		<tr> -->
	<!-- 			<td>建立時間</td> -->
	<%-- 			<td><fmt:formatDate value="${bbs.bbsSetupTime}" --%>
	<%-- 					pattern="YYYY-MM-dd HH:mm:ss" /></td> --%>
	<!-- 		</tr> -->
	<!-- 	</table> -->

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
			</p>
		</div>
		<div>${bbs.bbsMessage}</div>
	</div>

	<a href="bbs">回留言板首頁</a>

</body>
</html>