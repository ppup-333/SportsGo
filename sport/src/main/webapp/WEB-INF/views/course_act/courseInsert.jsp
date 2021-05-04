<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Document</title>
<script>
	$(document).ready(function() {
		$("#goCourseInsert").click(function() {
			let isNull = true;
			if ($("#from").val() == "") {
				isNull = false;
				$("span").css("visibility", "visible");
				console.log("no");
			} else if ($("#teacherName").val() == null) {
				isNull = false;
				$("emptyTeacher").css("visibility", "visible");
			}
			if (isNull) {
				$("#insert").submit();
				alert("新增成功");

			} else {
				alert("請確認資料是否有誤");
			}
		});

		for (let i = 301; i < 306; i++) {
			let opt = document.createElement("option");
			opt.setAttribute("value", i);
			let optTxt = document.createTextNode(i);
			opt.appendChild(optTxt);
			$("#CP").append(opt);
		}
		$("#CN").change(function() {

			$("#CP").empty();
			var cn = $("#CN").val()
			if (cn == "羽球") {
				for (let i = 301; i < 306; i++) {
					let opt = document.createElement("option");
					opt.setAttribute("value", i);
					let optTxt = document.createTextNode(i);
					opt.appendChild(optTxt);
					$("#CP").append(opt);
				}
			/*	let opt2 = document.createElement("option");
				let optTxt2 = document.createTextNode("Tom");
				opt2.value=101;
				opt2.appendChild(optTxt2);
				$("#teacherName").append(opt2);*/

			} else if (cn == "桌球") {
				for (let i = 401; i < 406; i++) {
					let opt = document.createElement("option");
					opt.setAttribute("value", i);
					let optTxt = document.createTextNode(i);
					opt.appendChild(optTxt);
					$("#CP").append(opt);
				}
				/*	let opt2 = document.createElement("option");
				let optTxt2 = document.createTextNode("Sandy");
				opt2.value=102;
				opt2.appendChild(optTxt2);
				$("#teacherName").append(opt2);*/

			} else if (cn == "籃球") {
				for (let i = 201; i < 206; i++) {
					let opt = document.createElement("option");
					opt.setAttribute("value", i);
					let optTxt = document.createTextNode(i);
					opt.appendChild(optTxt);
					$("#CP").append(opt);
				}
			/*	let opt2 = document.createElement("option");
		
				let optTxt2 = document.createTextNode("Jack");
				opt2.value=103;
				opt2.appendChild(optTxt2);
				$("#teacherName").append(opt2);*/
			}
		});

	});
</script>
<style type="text/css">
table {
text-align:center;
	border-collapse: collapse;
	border: 2px solid #D0D0D0;
	border-right: 1px solid #D0D0D0;
	margin-left: auto;
	margin-right: auto;
}

tr td:first-child {
	text-align:center;
   	padding: 20px;
	background-color: #D2E9FF;
	border-right: 1px solid #D0D0D0;
}


tr td:last-child {
text-align:center;
	padding: 20px;
	background-color: #66B3FF;
	border-right: 1px solid #D0D0D0;
}
</style>
</head>
<body>
	<form id="insert" action="/springsport/courseInsertImpl">

		<table border="1" style="text-align: center;">
			<tr>
				<td>選擇運動
				<td><select name="courseName" id="CN">
						<option value="羽球">羽球</option>
						<option value="桌球">桌球</option>
						<option value="籃球">籃球</option>
				</select>
			<tr>
				<td>選擇時段
				<td><select name="courseKind" id="CK">
						<option value="A 08:00~09:00">A 08:00~09:00</option>
						<option value="B 09:00~10:00">B 09:00~10:00</option>
						<option value="C 10:00~11:00">C 10:00~11:00</option>
						<option value="D 11:00~12:00">D 11:00~12:00</option>
						<option value="E 13:00~14:00">E 13:00~14:00</option>
						<option value="F 14:00~15:00">F 14:00~15:00</option>
						<option value="G 15:00~16:00">F 15:00~16:00</option>
						<option value="H 16:00~17:00">F 16:00~17:00</option>
				</select>
			<tr>
				<td><p>
						<label for="from">起始日期</label>
					</p>
				<td><input type="date" id="from" name="from"><span
					id="check" style="visibility: hidden;">請填入日期</span>
			<tr>
				<td><p>
						<label for="to">開課次數</label>
					</p>
				<td><select name="freq" id="to">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
				</select> <span id="check" style="visibility: hidden;">請填入次數</span></td>
			</tr>
			<tr>
				<td>費用:
				<td><input type="text" name="courseCost" maxlength="5"></input>
			<tr>
				<td>場地:
				<td><select name="coursePlace" id="CP"></select>
			<tr>
				<td>教師:
				<td><select name="teacherId" id="teacherName">
						<c:forEach var="item1" items="${teacherList}" varStatus="status">
						<option value="${item1.teacherId}">${item1.teacherName}</option>
						</c:forEach>
					</select>
			<tr>
				<td>最大學生數:
				<td><input type="text" name="studentMaxNum" maxlength="2"></input>
			<tr>
				<td>課程介紹:
				<td><textarea rows="30" cols="40" name="courseIntroduce"></textarea>
					<input type="text" name="types" style="display: none;"
					value="insert" />
		</table>
	</form>
	<button id="goCourseInsert">送出</button>

</body>
</html>