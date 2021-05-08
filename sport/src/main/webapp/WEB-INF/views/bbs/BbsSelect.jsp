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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="container-fluid pt-3">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<form id="select" name="select" action="bbsDelete" method="post"
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
							<div>${bbs.bbsMessageByDetail}</div>
						</div>
						<br>
						<div>
							<button type="submit" id="deteleBbs" class="btn btn-danger btn-sm">刪除</button>
							<button type="button" id="upDateBbs" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#update">編輯</button>
						</div>
				</form>
			
				<hr>
	
				<form:form modelAttribute="bbsReply" id="reply" name="reply"
					action="bbsReplySuccess" method="post">
				<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
					<form:textarea id="replyMessage" name="replyMessage" path="reply"
						rows="3" cols="40" style="resize: none" placeholder="敲下你的留言..."></form:textarea>
				</form:form>
	
				<br>
		
				<form id="replyForm" name="replyForm">
				<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
				<c:forEach var="reply" items="${replyList}">
					<c:if test="${reply.replyDelete == 0}">
						<div class="card">
							<p class="card-header">No.${reply.replyRank}  <i class="far fa-user-circle"></i> ${reply.users.account}</p>
							<div class="card-body">
							<div class="card-title">
								<div class="row">
									<p class="card-text col-sm-8" id="div${reply.replyId}">${reply.replyByDetail}</p>
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
								<input type="button" class="replyEdit  btn btn-primary btn-sm" id="replyEdit${reply.replyId}"
									rel="${reply.replyId}" value="編輯" />
								<button id="modify${reply.replyId}" style="display: none;"
									class="btn btn-primary btn-sm"
									onclick="javascript:document.replyForm.action='bbsReplyUpdate'; document.replyForm.method='post'"
									name="replyId" value="${reply.replyId}">修改</button>
								<button
									onclick="javascript:document.replyForm.action='bbsReplyDelete'; document.replyForm.method='post'; return false;"
									id="replyDelete${reply.replyId}"
									class="replyDelete btn btn-danger btn-sm" rel="${reply.replyId}">刪除</button>
							</div>
							</div>
						</div>
					</c:if>
					<c:if test="${reply.replyDelete == 1}">
						<div class="card">
							<p class="card-header">No.${reply.replyRank} <i class="fas fa-running"></i> 已被留言者刪除！</p>
							<div class="card-body"></div>
						</div>
					</c:if>
					<c:if test="${reply.replyDelete == 2}">
						<div class="card">
							<p class="card-header">No.${reply.replyRank} <i class="fas fa-running"></i> 留言不存在</p>
							<div class="card-body"></div>
						</div>
					</c:if>
				</c:forEach>
				</form>
			</div>
			<div class="col-2"></div>
		</div>
	</div>
	
	<!-- The Modal -->
	<form id="update" name="update" action="bbsUpdateSuccess" method="post"
		onclick="return false" class="modal fade">
	<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal body -->
				<div class="modal-body">
					<select name="typeId" id="selectGroup" class="custom-select-sm">
						<optgroup label="賽事討論">
						<c:forEach var="game" items="${gameList}">
							<option value="${game.typeId}"
							<c:if test="${game.typeId == bbs.bbsType.typeId}">selected</c:if>>${game.typeName}</option>
						</c:forEach>
						</optgroup>
						<optgroup label="健康情報">
						<c:forEach var="health" items="${healthList}">
							<option value="${health.typeId}"
							<c:if test="${health.typeId == bbs.bbsType.typeId}">selected</c:if>>${health.typeName}</option>
						</c:forEach>
						</optgroup>
						<optgroup label="揪團運動">
						<c:forEach var="sport" items="${sportList}">
							<option value="${sport.typeId}"
							<c:if test="${sport.typeId == bbs.bbsType.typeId}">selected</c:if>>${sport.typeName}</option>
						</c:forEach>
						</optgroup>
					</select> 
						
					<input type="text" id="bbsTitle" name="bbsTitle" size="40"
						value="${bbs.bbsTitle}">
					<div>
						<p>${bbs.users.account}</p>
						<p align="right">
							建立時間：<fmt:formatDate value="${bbs.bbsSetupTime}" pattern="YYYY-MM-dd HH:mm" />
						<br>
						<c:if test="${bbs.bbsUpdateTime != null}">最後編輯：<fmt:formatDate value="${bbs.bbsUpdateTime}" 
							pattern="YYYY-MM-dd HH:mm" />
						</c:if>
						</p>
					</div>
					<div>
						<textarea id="bbsMessage" name="bbsMessage" rows="15" cols="60"
							style="resize: none">${bbs.bbsMessage}</textarea>
					</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<input type="submit" id="upDateYN" class="btn btn-success"
						data-dismiss="modal" value="修改">
				</div>
				</div>
			</div>
		</div>
	</form>
	
	

	<script>
		//發文的編輯、刪除鈕
		<c:if test="${account != bbs.users.account}">
			$("#deteleBbs").hide();
			$("#upDateBbs").hide();
		</c:if>

		//留言的編輯、刪除鈕
		<c:forEach var="reply" items="${replyList}">
			<c:if test="${account != reply.users.account}">
				$("#replyEdit${reply.replyId}").hide();	
				$("#replyDelete${reply.replyId}").hide();
			</c:if>
		</c:forEach>

		//發文刪除鈕
		$("#deteleBbs").on("click", function() {
			Swal.fire({
				icon: "warning",
				showCancelButton: true,
				confirmButtonText: "確定",
				cancelButtonText: "取消",
				title: "確定要刪除發文嗎？",
				text: "刪除後將無法還原！",
			}).then((result) => {
				if (result.isConfirmed) {
					Swal.fire({
						icon: "success",
						title: "已刪除發文",
					}).then((result) => {
						$("#select").submit();
					});
				}
			});
		});

		//發文修改鈕
		$("#upDateYN").on("click", function() {
			Swal.fire({
				icon: "question",
				showCancelButton: true,
				confirmButtonText: "確定",
				cancelButtonText: "取消",
				title: "確定要修改發文嗎？",
				text: "按下取消可繼續編輯發文",
			}).then((result) => {
				if (result.isConfirmed) {
					Swal.fire({
						icon: "success",
						title: "已成功修改發文",
					}).then((result) => {
						$("#update").submit();
					});
				} else {
					$("#update").modal({
						show:true
					});
				}
			});
		});

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

		//留言刪除鈕
		$(".replyDelete").on("click", function() {
			var id = $(this).attr("rel");
			Swal.fire({
				icon: "warning",
				showCancelButton: true,
				confirmButtonText: "確定",
				cancelButtonText: "取消",
				title: "確定要刪除留言嗎？",
				text: "刪除後將無法復原！",
			}).then((result) => {
				if (result.isConfirmed) {
					Swal.fire({
						icon: "success",
						title: "已成功刪除留言",
					}).then((result) => {
						var form = document.getElementById("replyForm");
						var hiddenField = document.createElement("input");
						hiddenField.setAttribute("type", "hidden");
						hiddenField.setAttribute("name", "replyId");
						hiddenField.setAttribute("value", id);
						form.appendChild(hiddenField);
						document.body.appendChild(form);
						form.submit();
						$("#replyForm").submit();
					});
				}
			});
		});
		
		//留言編輯鈕
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