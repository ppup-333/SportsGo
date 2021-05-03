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
	</form>

	<form id="reply" name="reply" action="bbsReplySuccess" method="post">
	
	<div>
	<c:forEach var="reply" items="${replyList}">
	<p>${reply.replyAccount}</p>
	<div>
	<h3>${reply.reply}</h3>
	</div>
	</c:forEach>
	</div>
	
	<div>
	<p>${bbsReply.replyAccount}</p>
	<div>
		<input type="text" id="replyMessage" name="replyMessage"
			autocomplete="off" placeholder="輸入回覆內容" value="<c:out value='${bbsReply.reply}' />">
		<button type="submit" id="" name="">送出</button>	
	</div>
	</div>
	
	</form>

</body>
</html>