<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

/* CKEditor 編輯區塊 */
.ck-editor__editable_inline {
	/* 設定最低高度、寬度 */
    min-height: 300px;
    min-width: 600px;
}

/* 發文修改彈跳框 */
.modal-dialog {
	min-height: 400px;
    min-width: 700px;
}

</style>
</head>
<body>
<c:import url="../newheader.jsp"/>

	<div class="container-fluid" style="position: relative; top: 50px;">
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6 border" style="padding-bottom: 30px;">
				<form id="select" name="select" action="bbsDelete" method="post"
					onclick="return false" style="width: 90%; margin: 40px auto 10px auto;">
				<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
					<div>
						<p><sup class="badge badge-info">${bbs.bbsType.typeName}</sup> <span style="font-size: 30px; font-weight: bold;">${bbs.bbsTitleByDetail}</span></p>
						<div class="row">
							<p class="col"><i class="fas fa-user-circle"></i> ${bbs.users.name}(${bbs.users.account})</p>
							<p class="col" align="right">
							<c:if test="${bbs.bbsUpdateTime == null}">
								<fmt:formatDate value="${bbs.bbsSetupTime}"
									pattern="YYYY-MM-dd HH:mm" />
							</c:if>
							<c:if test="${bbs.bbsUpdateTime != null}">
								<fmt:formatDate value="${bbs.bbsUpdateTime}"
									pattern="YYYY-MM-dd HH:mm" /> 編輯
							</c:if>
							</p>
						</div>
						<div><p>${bbs.bbsMessageByDetail}</p></div>
					</div>
					<br>
					<div>
						<button type="button" id="upDateBbs" class="btn btn-outline-primary btn-sm" data-toggle="modal" data-target="#update" style="position: relative; left: 84%;">編輯</button>
						<button type="submit" id="deteleBbs" class="btn btn-outline-danger btn-sm" style="position: relative; left: 86%;">刪除</button>
					</div>
					<br>
				</form>
			
				<hr>
	
				<form:form modelAttribute="bbsReply" id="reply" name="reply"
					action="bbsReplySuccess" method="post" style="margin: 40px auto 0px auto;">
				<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
					<form:textarea id="replyMessage" name="replyMessage" path="reply" 
						rows="3" style="resize: none; width: 90%; position: relative; left: 5%;" 
						placeholder="敲下你的留言..."></form:textarea>
				</form:form>
	
				<br>
		
				<form id="replyForm" name="replyForm" style="width: 90%; margin: 10px auto 0px auto;">
				<input type="hidden" id="bbsId" name="bbsId" value="${bbs.bbsId}">
				<c:forEach var="reply" items="${replyList}">
					<c:if test="${reply.replyDelete == 0}">
						<div class="card">
							<div class="card-header">
							<div class="row">
							<p class="col" style="margin: 0px;">No.${reply.replyRank}  <i class="far fa-user-circle"></i> ${bbs.users.name}(${bbs.users.account})</p>
								<P class="col" align="right" style="margin: 0px;">
								<c:if test="${reply.replyUpdateTime == null}">
									<fmt:formatDate value="${reply.replySetupTime}"
										pattern="YYYY-MM-dd HH:mm" />
								</c:if>
								<c:if test="${reply.replyUpdateTime != null}">
									<fmt:formatDate value="${reply.replyUpdateTime}"
										pattern="YYYY-MM-dd HH:mm" /> 編輯
								</c:if>
								</P>
							</div>
							</div>
							<div class="card-body" style="padding: 20px;">
							<div class="card-title">
								
								<p class="card-text" id="div${reply.replyId}">${reply.replyByDetail}</p>
							</div>
							<div>
								<button
									onclick="javascript:document.replyForm.action='bbsReplyDelete'; document.replyForm.method='post'; return false;"
									id="replyDelete${reply.replyId}" style="position: relative; left: 93%;"
									class="replyDelete btn btn-outline-danger btn-sm" rel="${reply.replyId}">刪除</button>
								<button type="button" class="cancelEdit  btn btn-outline-primary btn-sm" id="cancelEdit${reply.replyId}" 
								style="display: none; position: relative; left: 93%;">取消</button>
								<input type="button" class="replyEdit  btn btn-outline-primary btn-sm" id="replyEdit${reply.replyId}"
									rel="${reply.replyId}" value="編輯" style="position: relative; left: 75%;" />
								<button id="modify${reply.replyId}" style="display: none; position: relative; left: 75%;"
									class="btn btn-outline-success btn-sm"
									onclick="javascript:document.replyForm.action='bbsReplyUpdate'; document.replyForm.method='post'"
									name="replyId" value="${reply.replyId}">修改</button>
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
			<div class="col-3"></div>
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
					<div style="width: 440px; position: relative; top: 40px">
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
					</div>
						<p style="width: 250px; position: relative; left: 450px">
							建立時間：<fmt:formatDate value="${bbs.bbsSetupTime}" pattern="YYYY-MM-dd HH:mm" />
						<br>
						<c:if test="${bbs.bbsUpdateTime != null}">上次編輯：<fmt:formatDate value="${bbs.bbsUpdateTime}" 
							pattern="YYYY-MM-dd HH:mm" />
						</c:if>
						</p>
					<div>
						<textarea id="bbsMessage" name="bbsMessage">${bbs.bbsMessage}</textarea>
					</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<input type="submit" id="upDateYN" class="btn btn-outline-success"
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

		//發文修改的文字編輯器
		ClassicEditor.create(document.querySelector("#bbsMessage"), {
			toolbar: {
			    items: [
			    	'heading', '|',
			        'fontfamily', 'fontsize', '|',
			        'undo', 'redo', '|',
			        'bold', 'italic', 'strikethrough', 'underline', 'subscript', 'superscript', '|',
			        'outdent', 'indent', '|',
			        'bulletedList', 'numberedList', 'todoList', '|',
			        'code', 'codeBlock', '|',
			        'blockQuote', '|',
			    ],
			}
		}).then(editor => {
			window.editor = editor;
		});
		
		//發文修改鈕
		$("#upDateYN").on("click", function() {
			var data = window.editor.getData();
			$("#bbsMessage").val(data);
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
						$("#replyForm").submit();
					});
				}
			});
		});
		
		//留言編輯鈕
		$(".replyEdit").on("click",	function() {
			var id = $(this).attr("rel");
			var text = $("#div" + id).html();
			$("#div" + id).html("<textarea name='reply' style='resize:none; width: 95%;"
								+ "position: relative; left: 3%; margin: 10px auto 0px auto;' rows='3'>"
								+ text + "</textarea>");
			$(this).hide();
			$("#modify" + id).show();
			$("#replyDelete" + id).hide();
			$("#cancelEdit" + id).show();
		});
		
		//留言編輯取消鈕
		$(".cancelEdit").on("click", function() {
			window.location.reload();
		})
		
	</script>

</body>
</html>