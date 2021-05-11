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
		
		
		let ckoption=["B 09:00~10:00","C 10:00~11:00","D 11:00~12:00",
			"E 13:00~14:00","F 14:00~15:00","G 15:00~16:00","H 16:00~17:00","I 17:00~18:00"];
		const ckresult=[];
		
		if($("#CK option").length!=0){
			for(let i=0;i<ckoption.length;i++){
			$("#CK option").each(function(){
				
			
			   if( ckoption[i]==($(this).val())){				   
				   
			   }else{
				   console.log(ckoption[i]);
				   ckresult.push(ckoption[i]);
			   }
			   
			});
		 }
		}else{
			console.log(ckoption.length);
			for(let i=0;i<ckoption.length;i++){
				 ckresult.push(ckoption[i]);				
			}
		}
		
		$("#CK").empty();
		for(let i=0;i<ckresult.length;i++){
			$("#CK").append("<option value='"+ckresult[i]+"'>"+ckresult[i]+"</option>");
		}
		
		
		
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

		
		$("#to").change(function() {
			let toval=$("#to").val();
			let total=toval*300;
			$("#cost").attr("value",total);
		});
		
		
		/*for (let i = 301; i < 306; i++) {
			let opt = document.createElement("option");
			opt.setAttribute("value", i);
			let optTxt = document.createTextNode(i);
			opt.appendChild(optTxt);
			$("#CP").append(opt);
		}*/
		

	});
</script>
<style type="text/css">
.courseInsertTable {
text-align:center;
	border-collapse: collapse;
	border: 2px solid #D0D0D0;
	border-right: 1px solid #D0D0D0;
	/*margin-left: auto;
	margin-right: auto;*/
}

.courseInsertTr td:first-child {
	text-align:center;
   	padding: 20px;
	background-color: #D2E9FF;
	border-right: 1px solid #D0D0D0;
}


.courseInsertTr td:last-child {
text-align:center;
	padding: 20px;
	background-color: #66B3FF;
	border-right: 1px solid #D0D0D0;
}
</style>
</head>
<body>
	<form id="insert" action="/sport/courseInsertImpl">

		<table class="courseInsertTable" border="1" style="text-align: center;">
			<tr class="courseInsertTr">
				<td>選擇運動
				<td><input type="text" id="CN" name="courseName" value="${courseName}" style="display:none"/>${courseName}				
				<tr class="courseInsertTr">
				<td>選擇時段
				<td><select name="courseKind" id="CK">
				<c:forEach var="item1" items="${Timeperiod}" varStatus="status">
						<option value="${item1}">${item1}</option>
				</c:forEach>						
						<!--  <option value="A 08:00~09:00">A 08:00~09:00</option>
						<option value="B 09:00~10:00">B 09:00~10:00</option>
						<option value="C 10:00~11:00">C 10:00~11:00</option>
						<option value="D 11:00~12:00">D 11:00~12:00</option>
						<option value="E 13:00~14:00">E 13:00~14:00</option>
						<option value="F 14:00~15:00">F 14:00~15:00</option>
						<option value="G 15:00~16:00">F 15:00~16:00</option>
						<option value="H 16:00~17:00">F 16:00~17:00</option>-->
				</select>
			<tr class="courseInsertTr">
				<td><p>
						<label for="from">起始日期</label>
					</p>
				<td><input type="text" id="from" name="from" value="${time}" style="display:none"/>${time}
			<tr class="courseInsertTr">
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
				</select> <span id="check" style="display:none;">請填入次數</span></td>
			</tr>
			<tr class="courseInsertTr">
				<td>費用:
				<td><input type="text" name="courseCost" id="cost" style="color:gray" value="300" readonly></input>
			<tr class="courseInsertTr">
				<td>場地:
				<td><select name="coursePlace" id="CP">
					<c:forEach var="item1" items="${fieldList}" varStatus="status">
						<option value="${item1.id}">${item1.name}</option>
						</c:forEach>
				</select>
			<tr class="courseInsertTr">
				<td>教師:
				<td><select name="teacherId" id="teacherName">
						<c:forEach var="item1" items="${teacherList}" varStatus="status">
						<option value="${item1.teacherId}">${item1.teacherName}</option>
						</c:forEach>
					</select>
			<tr class="courseInsertTr">
				<td>最大學生數:
				<td><select name="studentMaxNum">
				<option value="12">12</option>
				<option value="24">24</option>
				<option value="30">30</option>
				<option value="36">36</option>
				</select>
			<tr class="courseInsertTr">
				<td>課程介紹:
				<td><textarea rows="10" cols="40" name="courseIntroduce"></textarea>
					<input type="text" name="types" style="display: none;"
					value="insert" />
		</table>
	</form>
	<button id="goCourseInsert">送出</button>

</body>
</html>