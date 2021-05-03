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
			<p>
				<fmt:formatDate value="${bbs.bbsUpdateTime}"
					pattern="YYYY-MM-dd HH:mm" />
			</p>
		</div>
		<div>${bbs.bbsMessage}</div>
	</div>

	<a href="bbs">回留言板首頁</a>

</body>
</html>