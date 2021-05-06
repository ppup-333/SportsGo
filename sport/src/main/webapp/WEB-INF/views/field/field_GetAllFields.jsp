<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.js"></script> -->
<!-- <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->

<!-- bootstrap -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> -->
<!-- <script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script> -->
<style>
th, td {
	padding: 5px 10px;
}
</style>

</head>
<body>
	<c:import url="../headerM.jsp"/>
	<h2>場地管理</h2>
	<!-- startCode -->
	<input style="display:none" id="startCode" value="${startCode}">
	
	<select id="ts" name="typeId">
		<option value="0" <c:if test="${typeId==0}">selected</c:if>>- ALL -</option>
		<c:forEach var="fieldType" items="${fieldTypeList}">
			<option value="${fieldType.id}" <c:if test="${typeId==fieldType.id}">selected</c:if>>${fieldType.name}</option>
		</c:forEach>
	</select>
	<hr>
	<div id=queryByType>
		<!-- 回傳查詢的資料放入 -->
	</div>
	<input type="button" id="createFieldBtn" data-toggle="modal" data-target="#myModal" value="測試新增"/>
	
	<!-- The Modal -->
	<form:form modelAttribute="field" action="updateField" method="post">
		<div class="modal fade" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">
	
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">新增場地</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
	
					<!-- Modal body -->
					<div class="modal-body">
						<div style="width:480px; margin:auto">						
								<input id='typeIdHide' name="typeIdHide" style="display: none" value="${typeId}"/>
								<table>
									<tr><td><form:label path="id">編號</form:label></td>
										<td><form:input path="id" id="createFieldId"/></td>
										<td><form:errors path="id"/></td><td id="createIdError"></td>
									<tr><td><form:label path="name">名稱</form:label>
										<td><form:input path="name" id="createFieldName"/>
										<td><form:errors path="name"/></td><td id="createNameError"></td>
									<tr><td><form:label path="fieldType">類型</form:label>
										<td><form:select path="fieldType">
												<option value="0">- 請選擇 -</option>
												<option value="1">羽毛球</option>
												<option value="2">籃球</option>
												<option value="3">壁球</option>
												<option value="4">桌球</option>
												<option value="5">排球</option>
											</form:select>
										<td><form:errors path="fieldType"/></td>
									<tr><td><form:label path="position">位置</form:label>
										<td><form:select path="position">				
												<option value="5F">5F</option>
												<option value="4F">4F</option>
												<option value="3F">3F</option>
												<option value="2F">2F</option>
												<option value="1F">1F</option>
												<option value="B1">B1</option>
											</form:select>
									<tr><td><form:label path="rentForMember">租金(會員)</form:label>
										<td><form:input path="rentForMember"/>
										<td><form:errors path="rentForMember"/></td>
									<tr><td><form:label path="rentForAct">租金(活動)</form:label>
										<td><form:input path="rentForAct"/>
										<td><form:errors path="rentForAct"/></td>
									<tr><td><form:label path="situation">狀態</form:label>
										<td><form:select path="situation">
												<option value="1">可使用</option>
												<option value="0">不可使用</option>
											</form:select>
									<tr><td><form:label path="remark">備註</form:label>
										<td><form:input path="remark"/>
									<tr><td><form:label path="buildDate">創建日期</form:label>				
										<td><form:input path="buildDate" type="date"/><br>
<%-- 									<tr><td><td><form:button type="submit" id="createButton">送出</form:button> --%>
								</table>
						</div>
					</div>
						
					<!-- Modal footer -->
					<div class="modal-footer">
					<form:button type="submit" class="btn btn-primary" id="createButton">送出</form:button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>
	
				</div>
			</div>
		</div>
	</form:form>
	
<script>

var typeSelect = document.getElementById("ts");
var queryByType = document.getElementById("queryByType");

checkStartCode();
function checkStartCode(){
	var createFieldBtn = document.getElementById("createFieldBtn");
	var startCode = document.getElementById("startCode").value;
	alert("startCode=" + startCode);
	if(startCode == "createError"){
		alert("新增失敗！");
		createFieldBtn.click();
	}else if(startCode == "createSuccess"){
		alert("新增成功！")
	}else if(startCode == "updateError"){
		alert("修改失敗！");
		//updateFieldBtn.click();
	}else if(startCode == "updateSuccess"){
		alert("修改成功！");
	}else if(startCode == "deleteSuccess"){
		alert("刪除成功！");
	}
}

$("#ts").ready(xhrFunction);
$("#ts").change(typeIdFunction);
$("#ts").change(xhrFunction);
$("#createButton").click(function(){
	if(!confirm("確定要新增？")){
		return false;
	}
});

function typeIdFunction(){
	var typeIdHide = document.getElementById("typeIdHide");
	typeIdHide.value = typeSelect.value;
}

function xhrFunction(){
	var tid = parseInt(typeSelect.value);
	var xhr = new XMLHttpRequest();

	xhr.open("GET","<c:url value='getFieldsJsonByTypeId/"+tid+"'/>",true);

	xhr.send();
	if(xhr!=null){
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				displayFields(xhr.responseText);					
			}					
		}
	}
}
function xhrFunction1(){
	var tid = parseInt(typeSelect.value);
	var xhr = new XMLHttpRequest();

	xhr.open("GET","<c:url value='getFieldsJsonByTypeId/0'/>",true);

	xhr.send();
	if(xhr!=null){
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				checkCreateId(xhr.responseText);					
			}					
		}
	}
}

function displayFields(responseText){
	var mapData = JSON.parse(responseText);					
	var fieldList = mapData.fieldList;
	var typeId = mapData.typeId;
	var fieldCreateDateStrList = mapData.fieldCreateDateStrList;
	var fieldUpdateDateStrList = mapData.fieldUpdateDateStrList;

	var content;
	if(fieldList.length > 0){			
		content = "<table border='1'><tr>"
				+ "<th>編號<th>名稱<th>類型<th>位置	<th>租金(會員)	<th>租金(活動)"
				+ "<th>狀況<th>備註<th>創建日期<th>資料建立日期<th>資料修改日期</tr>";
		console.log(fieldList);
		for(var i=0; i < fieldList.length; i++){
			var situation;
			if(fieldList[i].situation==1){
				situation="可使用"
			}else{
				situation="不可使用"
			}
			var updateDateStr = (fieldUpdateDateStrList[i]==null)?"":fieldUpdateDateStrList[i];
			var remark = (fieldList[i].remark==null||fieldList[i].remark=="")?"(無)":fieldList[i].remark;
			content += "<tr><td>"+fieldList[i].id+"<td>"+fieldList[i].name+"<td>"+fieldList[i].fieldType.name
					 + "<td>"+fieldList[i].position+"<td>"+fieldList[i].rentForMember+"<td>"+fieldList[i].rentForAct
					 + "<td>"+situation
					 + "<td>"+remark+"<td>"+fieldList[i].buildDate+"<td>"+fieldCreateDateStrList[i]
					 + "<td>"+updateDateStr
					 + "<td><form class='formUpdate' action='updateFieldPage' method='post'>"
					 + "<input name='typeId' style='display: none' value='"+typeId+"'/>"
					 + "<button type='submit' name='updateId' value='"+fieldList[i].id+"'>修改</button></form>"
					 + "<form class='formDelete' action='deleteField' method='post'>"
					 + "<button type='submit' name='deleteId' class='deleteButton' value='"+fieldList[i].id+"'>刪除</button>"
					 + "</form>"
					 + "<td><input type='button' class='updateBtn' value='修改'/>";					
		}
		content += "</table>"
	}else if(fieldList.length == 0){
		content = "<h3>此類型沒有資料</h3>"; 
	}
	
	content += "<form action='field_CreatePage' method='get'>"
				+ "<input style='display:none' name='typeId' value='"+typeId+"'>"
				+ "<button type='submit'>新增場地</button>"
				+ '<td><input type="button" id="createFieldBtn" data-toggle="modal" data-target="#myModal" value="測試"/>'
			 + "</form>"
	
	queryByType.innerHTML = content;
		
	var updateBtnList = document.getElementsByClassName("formUpdate");
	var deleteBtnList = document.getElementsByClassName("formDelete");
	for(var i = 0; i < updateBtnList.length; i++){
		updateBtnList[i].style.display = "inline";
		deleteBtnList[i].style.display = "inline";
	}
	document.getElementsByClassName("formDelete")
			 
	$(".deleteButton").click(function() {
		if(!confirm("確定要刪除？")){
			return false;
		}
	});
}

$("#createFieldId").change(xhrFunctionId);
$("#createFieldName").change(xhrFunctionName);

function xhrFunctionId(){
	var xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='getFieldsJsonByTypeId/0'/>",true);
	xhr.send();
	if(xhr!=null){
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				checkCreateId(xhr.responseText);					
			}					
		}
	}
}

function xhrFunctionName(){
	var xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='getFieldsJsonByTypeId/0'/>",true);
	xhr.send();
	if(xhr!=null){
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				checkCreateName(xhr.responseText);					
			}					
		}
	}
}

function checkCreateId(responseText){
	var mapData = JSON.parse(responseText);
	var fieldList = mapData.fieldList;
	var createFieldId = document.getElementById("createFieldId").value;
	var createIdError = document.getElementById("createIdError");
	
	for(var i = 0; i < fieldList.length; i++){
		if(fieldList[i].id == createFieldId){
			createIdError.innerHTML = "此編號已存在";
			break;
		}
		createIdError.innerHTML = "";
	}
}


function checkCreateName(responseText){
	var mapData = JSON.parse(responseText);
	var fieldList = mapData.fieldList;
	var createFieldName = document.getElementById("createFieldName").value;
	var createNameError = document.getElementById("createNameError");
	
	for(var i = 0; i < fieldList.length; i++){
		if(fieldList[i].name == createFieldName){
			createNameError.innerHTML = "此名稱已存在";
			break;
		}
		createNameError.innerHTML = "";
	}
}
	
</script>
</body>
</html>