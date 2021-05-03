<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<a href="bbsM"><button class="btn btn-info btn-sm">留言板</button></a>

	<form id="select" name="select" action="bbsM.Delete" method="post"
		onclick="return false">
		<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
		<div>
			<div>
				<div class="row">
					<h6 class="col-sm-1">${bbs.bbsType.typeName}</h6>
					<h1 class="col-sm-11">${bbs.bbsTitle}</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					${bbs.bbsBuilder}
				</div>
				<div class="col">
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
			<button type="submit" id="deteleBbsYN" class="btn btn-danger btn-sm">刪除</button>
			<button type="button" id="upDateBbs" class="btn btn-primary btn-sm">編輯</button>
		</div>
	</form>

	<hr>

	<form:form modelAttribute="bbsReply" id="reply" name="reply"
		action="bbsReplySuccess" method="post">
		<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
		<form:textarea id="replyMessage" name="replyMessage" path="reply"
			rows="3" cols="40" style="resize: none" placeholder="敲下你的留言..."></form:textarea>
	</form:form>
	<script>
		// 	在回覆發文的<textarea>以Enter送出，Enter + Shift換行
		$("#replyMessage").keypress(function(e) {
			var replyText = $("#replyMessage").val();
			if (e.which === 13 && !e.shiftKey) {
				e.preventDefault();
				if (replyText.length > 0) {
					$(this).closest("form").submit();
				}
			}
		});
		document.getElementById("replyMessage").value = "";
	</script>

	<br>
	
	<form id="replyForm" name="replyForm">
		<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
		<c:forEach var="reply" items="${replyList}">
			<c:if test="${reply.replyDelete == 0}">
				<div class="card">
					<p class="card-header">No.${reply.replyRank}</p>
					<div class="card-body">
						<div class="card-title">
							<div class="row">
								<p class="col">${reply.replyAccount}</p>
								<P class="col">
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
							<p class="card-text" id="div${reply.replyId}">${reply.reply}</p>
							<input type="button" class="replyEdit  btn btn-primary btn-sm"
								rel="${reply.replyId}" value="編輯" />
							<button id="modify${reply.replyId}" style="display: none;"
								class="btn btn-primary btn-sm"
								onclick="javascript:document.replyForm.action='bbsM.ReplyUpdate'; document.replyForm.method='post'"
								name="replyId" value="${reply.replyId}">修改</button>
							<button
								onclick="javascript:document.replyForm.action='bbsM.ReplyDelete'; document.replyForm.method='post'; return false;"
								id="replyDelete${reply.replyId}"
								class="replyDelete btn btn-danger btn-sm" rel="${reply.replyId}">刪除</button>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${reply.replyDelete == 1}">
				<div class="card">
					<p class="card-header">No.${reply.replyRank} <i class="fas fa-running"></i> 已被留言者刪除</p>
					<div class="card-body">
						<div class="card-title">
							<div class="row">
								<p class="col">${reply.replyAccount}</p>
								<P class="col">
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
							<p class="card-text" id="div${reply.replyId}">${reply.reply}</p>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${reply.replyDelete == 2}">
				<div class="card">
					<p class="card-header">No.${reply.replyRank} <i class="fas fa-running"></i> 管理員刪除</p>
					<div class="card-body">
						<div class="card-title">
							<div class="row">
								<p class="col">${reply.replyAccount}</p>
								<P class="col">
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
							<p class="card-text" id="div${reply.replyId}">${reply.reply}</p>
						</div>
					</div>
				</div>
			</c:if>
		</c:forEach>
	</form>

	<hr>


	<script>
		$("#deteleBbsYN").on("click", function() {
			$.confirm({
				title : "確定要刪除發文嗎？",
				content : "確定刪除後將無法還原！",
				buttons : {
					確定 : function() {
						$.confirm({
							title : "已成功刪除發文！",
							content : "",
							buttons : {
								OK : function() {
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

		$(".replyDelete").on("click", function() {
			var id = $(this).attr("rel");
			$.confirm({
			title : "確定要刪除留言嗎？",
			content : "確定刪除後將無法還原！",
			buttons : {
				確定 : function() {
					$.confirm({
					title : "已成功刪除留言！",
					content : "",
					buttons : {
						OK : function() {
							var form = document.getElementById("replyForm");
							var hiddenField = document.createElement("input");
							hiddenField.setAttribute("type", "hidden");
							hiddenField.setAttribute("name", "replyId");
							hiddenField.setAttribute("value", id);
							form.appendChild(hiddenField);
							document.body.appendChild(form);
							form.submit();
							$("#replyForm").submit();
							}
						}
					});
				},
						取消 : function() {
						}
			}
		});
	});
	</script>

</body>
</html>