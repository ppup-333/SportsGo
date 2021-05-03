<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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

	<form:form modelAttribute="bbs" id="create" name="create"
		onclick="return false" action="bbsdiscussion.c.success" method="post">
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
			autocomplete="off" placeholder="輸入標題"></form:input>
		<br>
		<form:textarea rows="20" cols="70" path="bbsMessage" id="bbsMessage"
			name="bbsMessage" placeholder="輸入內文"
			value="<c:out value='${bbs.bbsMessage}' />"></form:textarea>
		<input type="button" onclick="formReset()" value="清除" />
		<br>
		<button type="button" id="cancelYN">放棄發文</button>
		<button type="submit" id="postYN">送出發文</button>
	</form:form>

	<script>
		function formReset() {
			document.getElementById("create").reset();
		}

		$("#postYN").on("click", function() {
			if ($("#typeId").val() == "") {
				$.confirm({
					title : "別忘了選擇發文的類型呀~",
					content : "",
					buttons : {
						來去選發文類型 : function() {

						}
					}
				});
				// 				alert("請選擇發文類型");
			} else if ($("#bbsTitle").val() == "") {
				$.confirm({
					title : "發文要記得打標題唷~",
					content : "",
					buttons : {
						來去補上標題 : function() {

						}
					}
				});
				// 				alert("發文要記得打標題唷~");
			} else if ($("#bbsMessage").val() == "") {
				$.confirm({
					title : "打完標題，內文也要記得啊~",
					content : "",
					buttons : {
						來去打完內文 : function() {

						}
					}
				});
				// 				alert("打完標題，內文也要記得啊~");
			} else {
				$.confirm({
					title : "是否送出發文？",
					content : "選擇「是」送出發文；選擇「否」繼續編輯發文",
					buttons : {
						是 : function() {
							$.confirm({
								title : "已成功送出發文！",
								content : "",
								buttons : {
									OK : function() {
										$("#create").submit();
									}
								}
							})
						},
						否 : function() {

						}
					}
				});
			}
		});

		$("#cancelYN").on("click", function() {
			$.confirm({
				title : "確定要放棄發文嗎？",
				content : "選擇確定放棄發文；選擇取消繼續編輯發文",
				buttons : {
					確定 : function() {
						$.confirm({
							title : "已放棄發文",
							content : "將為您導回留言板首頁",
							buttons : {
								OK : function() {
									document.location.href = "bbs";
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