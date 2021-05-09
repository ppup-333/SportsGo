<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../header.jsp"/>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/27.1.0/classic/ckeditor.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

/* CKEditor 編輯區塊 */
.ck-editor__editable_inline {
	/* 設定最低高度、寬度 */
    min-height: 300px;
    min-width: 600px;
}

</style>
</head>
<body>

	<div class="container-fluid pt-5">
		<div class="row justify-content-center align-items-center">
			<div class="col"></div>
			<div class="col">
				<form:form modelAttribute="bbs" id="create" name="create"
					onclick="return false" action="bbsCreateSuccess" method="post">
					<form:select path="bbsType" id="typeId" name="typeId">
						<option value="">-- 選擇類型 --</option>
						<optgroup label="賽事討論">
							<c:forEach var="game" items="${gameList}">
								<option value="${game.typeId}">${game.typeName}</option>
							</c:forEach>
						</optgroup>
						<optgroup label="健康情報">
							<c:forEach var="health" items="${healthList}">
								<option value="${health.typeId}">${health.typeName}</option>
							</c:forEach>
						</optgroup>
						<optgroup label="揪團運動">
							<c:forEach var="sport" items="${sportList}">
								<option value="${sport.typeId}">${sport.typeName}</option>
							</c:forEach>
						</optgroup>
					</form:select>
					<form:input type="text" path="bbsTitle" id="bbsTitle" name="bbsTitle"
						autocomplete="off" size="50" placeholder="輸入標題"></form:input>
					<input type="button" style="position: relative; top: -3px;" onclick="formReset()" class="btn btn-warning btn-sm" value="清除" />
					<br>
					<form:textarea path="bbsMessage" id="bbsMessage" name="bbsMessage"
						placeholder="輸入內文" value="<c:out value='${bbs.bbsMessage}' />"></form:textarea>
					
					<br>
					<button type="button" id="cancelYN"class="btn btn-danger btn-sm" style="position: relative; left: 220px;">放棄發文</button>
					<button type="submit" id="postYN"class="btn btn-success btn-sm" style="position: relative; left: 240px;">送出發文</button>
				</form:form>
			</div>
			<div class="col"></div>
		</div>
	</div>

	<script>
		function formReset() {
			document.getElementById("create").reset();
			editor.data.set("");
		}
		
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
			    ]
			}
		}).then(editor => {
			window.editor = editor;
		});
		
		$("#postYN").on("click", function() {
			var data = window.editor.getData();
			$("#bbsMessage").val(data);
			if($("#typeId").val() == ""){
				Swal.fire({
					icon: "warning",
					confirmButtonText: "知道了",
					title: "請選擇發文類型！",
				});
			} else if($("#bbsTitle").val() == "") {
				Swal.fire({
					icon: "warning",
					confirmButtonText: "知道了",
					title: "請輸入標題！",
				});
			} else if($("#bbsMessage").val() == "") {
				Swal.fire({
					icon: "warning",
					confirmButtonText: "知道了",
					title: "請輸入內文！",
				});
			} else {
				Swal.fire({
					icon: "question",
					showCancelButton: true,
					confirmButtonText: "確定",
					cancelButtonText: "取消",
					title: "確定要送出發文嗎？",
					text: "確認後送出發文；取消後繼續編輯發文。"
				}).then((result) => {
					if (result.isConfirmed) {
						Swal.fire({
							icon: "success",
							title: "成功送出發文！",
						}).then((result) => {
							$("#create").submit();
						});
					}
				});
			}
		});
		
		$("#cancelYN").on("click", function(){
			Swal.fire({
				icon: "question",
				showCancelButton: true,
				confirmButtonText: "確定",
				cancelButtonText: "取消",
				title: "確定要放棄發文嗎？",
				text: "放棄發文後將導回討論區首頁。",
			}).then((result) => {
				if (result.isConfirmed) {
					Swal.fire({
						icon: "success",
						title: "已放棄發文",
					}).then((result) => {
						document.location.href = "bbs";
					});
				}
			});
		});

	</script>

</body>
</html>