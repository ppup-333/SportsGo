<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../header.jsp"/>
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
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div class="container-fluid pt-3">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<form id="select" name="select">
				<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
					<div>
						<div>
							<div class="row">
								<h6 class="col-sm-1">${bbs.bbsType.typeName}</h6>
								<h1 class="col-sm-11">${bbs.bbsTitle}</h1>
							</div>
						</div>
							<div class="row">
								<div class="col-sm-8">${bbs.users.account}</div>
								<div class="col-sm-4">
									<p>
										建立時間：<fmt:formatDate value="${bbs.bbsSetupTime}"
											pattern="YYYY-MM-dd HH:mm" />
							<br>
									<c:if test="${bbs.bbsUpdateTime != null}">
										最後編輯：<fmt:formatDate value="${bbs.bbsUpdateTime}"
											pattern="YYYY-MM-dd HH:mm" />
									</c:if>
									</p>
								</div>
							</div>
							<div>${bbs.bbsMessage}</div>
					</div>
				<br>
					<div>
						<button type="button" id="deteleBbs" style="display: none;" class="btn btn-danger btn-sm">刪除</button>
						<button type="button" id="recoveryBbs" style="display: none;" class="btn btn-warning btn-sm">刪除還原</button>
					</div>
		</form>
	
		<br>
	
		<form id="replyForm" name="replyForm">
			<c:forEach var="reply" items="${replyList}">
				<input type="hidden" id="${reply.replyId}" name="${reply.replyId}" value="${reply.replyId}">
				<div class="card">
					<c:if test="${reply.replyDelete == 0}">
						<p class="card-header">No.${reply.replyRank} <i class="far fa-user-circle"></i> ${reply.users.account}</p>
					</c:if>
					<c:if test="${reply.replyDelete == 1}">
						<p class="card-header">
							No.${reply.replyRank} <i class="fas fa-running"></i> 已被留言者刪除
						</p>
					</c:if>
					<c:if test="${reply.replyDelete == 2}">
						<p class="card-header">
							No.${reply.replyRank} <i class="fas fa-running"></i> 管理員刪除
						</p>
					</c:if>
					<div class="card-body">
						<div class="card-title">
							<div class="row">
								<p class="card-text col-sm-8" id="div${reply.replyId}">${reply.reply}</p>
								<P class="col-sm-4">
									建立時間：<fmt:formatDate value="${reply.replySetupTime}"
										pattern="YYYY-MM-dd HH:mm" />
									<br>
								<c:if test="${reply.replyUpdateTime != null}">
									最後編輯：<fmt:formatDate value="${reply.replyUpdateTime}"
										pattern="YYYY-MM-dd HH:mm" />
									</c:if>
								</P>
							</div>
						</div>
						<div>
							<button type="button" id="deleteReply${reply.replyId}" style="display: none;" class="btn btn-danger btn-sm">刪除</button>
							<button type="button" id="recoveryReply${reply.replyId}" style="display: none;"	class="btn btn-warning btn-sm">刪除還原</button>
						</div>
					</div>
				</div>
			</c:forEach>
		</form>
			</div>
			<div class="col-2"></div>
		</div>
	</div>

	<script>
		//管理員刪除發文及復原發文按鈕
		<c:if test="${bbs.bbsDelete == 0}">
			$("#deteleBbs").show();
		</c:if>
		<c:if test="${bbs.bbsDelete == 2}">
			$("#recoveryBbs").show();
		</c:if>
		$("#deteleBbs").on("click", function() {
			$.confirm({
				title : "確定後用戶端的發文將會被刪除。",
				content : false,
				buttons : {
					確定 : function() {
						$.get("bbsM.BbsDelete?bbsId=" + $("#bbsId").val(), function(data) {
							if(data == "OK"){
								$("#deteleBbs").hide();
								$("#recoveryBbs").show();
							}else {
								alert("系統異常");
							}
						});
					},
					取消 : function() {
					}
				}
			});
		});
		$("#recoveryBbs").on("click", function() {
			$.get("bbsM.BbsRecovery?bbsId=" + $("#bbsId").val(), function(data) {
				if(data == "OK"){
					$("#deteleBbs").show();
					$("#recoveryBbs").hide();
				}else {
					alert("系統異常");
				}
			});
		});
		
		//管理員刪除留言及復原發文按鈕
		<c:forEach var="reply" items="${replyList}">
			<c:if test="${reply.replyDelete == 0}">
				$("#deleteReply${reply.replyId}").show();
			</c:if>
			<c:if test="${reply.replyDelete == 2}">
				$("#recoveryReply${reply.replyId}").show();
			</c:if>
			$("#deleteReply${reply.replyId}").on("click", function() {
				$.confirm({
					title : "確定後用戶端的留言將會被刪除。",
					content : false,
					buttons : {
						確定 : function() {
							$.get("bbsM.ReplyDelete?replyId=" + $("#${reply.replyId}").val(), function(data) {
								if(data == "OK"){
									$("#deleteReply${reply.replyId}").hide();
									$("#recoveryReply${reply.replyId}").show();
								}else {
									alert("系統異常");
								}
							});
						},
						取消 : function() {
						}
					}
				});
			});
			$("#recoveryReply${reply.replyId}").on("click", function() {
				$.get("bbsM.ReplyRecovery?replyId=" + $("#${reply.replyId}").val(), function(data) {
					if(data == "OK"){
						$("#deleteReply${reply.replyId}").show();
						$("#recoveryReply${reply.replyId}").hide();
					}else {
						alert("系統異常");
					}
				});
			});
		</c:forEach>

		$("#upDateBbs").on("click", function() {
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

		$(".replyEdit").on("click",	function() {
			var id = $(this).attr("rel");
			var text = $("#div" + id).html();
			$("#div" + id).html("<textarea name='reply' style='resize:none' rows='3' cols='35'>"
								+ text + "</textarea>");
			$(this).hide();
			$("#modify" + id).show();
		});
	</script>

</body>
</html>