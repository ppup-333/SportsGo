<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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

</style>
</head>
<body>
<c:import url="../newheader.jsp"/>

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
					<input type="button" style="position: relative; top: -3px;" onclick="formReset()" class="btn btn-outline-warning btn-sm" value="清除" />
					<br>
					<form:textarea path="bbsMessage" id="bbsMessage" name="bbsMessage"
						placeholder="輸入內文" value="<c:out value='${bbs.bbsMessage}' />"></form:textarea>
					
					<br>
					<button type="button" id="cancelYN"class="btn btn-outline-danger btn-sm" style="position: relative; left: 220px;">放棄發文</button>
					<button type="submit" id="postYN"class="btn btn-outline-success btn-sm" style="position: relative; left: 240px;">送出發文</button>
				</form:form>
			</div>
			<div class="col">
				<button type="button" id="bbsOne">一鍵輸入</button>
			</div>
		</div>
	</div>
	
	<script>
		//一鍵輸入
		$("#bbsOne").on("click", function() {
			$("#typeId").val(1);
			$("#bbsTitle").val("湖人勇士附加賽誰輸是不是都沒有遺憾?");
			editor.data.set("如題<br><br>湖人勇士沒意外就要打附加賽"
							+ "<br><br>一個去年冠軍 一個剛結束連霸王朝"
							+ "<br><br>大家都說這收視率會超越今年冠軍賽"
							+ "<br><br>不過這兩個組合不管誰贏誰輸  整季都盡力了"
							+ "<br><br>看看湖人"
							+ "<br><br>沒有留下DH 補來抓猛結果發現沒想像猛"
							+ "<br><br>LBJ曇花終於開完了 跟AD傷傷停停"
							+ "<br><br>復出戰績不理想"
							+ "<br><br>看隔壁勇士 只有Curry一個撐全場"
							+ "<br><br>其他隊友都不知道在幹嘛"
							+ "<br><br>KT還沒好 Green大三單"
							+ "<br><br>圍巾有一場沒一場 還有傷兵"
							+ "<br><br>別人的隊友都是NBA隊友"
							+ "<br><br><br>這樣看下來哪一隊輸是不是都沒有遺憾 雖敗猶榮????");
		});

		//清除鈕
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
					toast: true,
					icon: "warning",
					position: "center",
					showConfirmButton: false,
					timer: 2000,
					title: "請選擇發文類型！",
				});
			} else if($("#bbsTitle").val() == "") {
				Swal.fire({
					toast: true,
					icon: "warning",
					position: "center",
					showConfirmButton: false,
					timer: 2000,
					title: "請輸入標題！",
				});
			} else if($("#bbsMessage").val() == "") {
				Swal.fire({
					toast: true,
					icon: "warning",
					position: "center",
					showConfirmButton: false,
					timer: 2000,
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