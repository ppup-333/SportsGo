<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SportsGo!</title>

<c:import url="../headerScript.jsp"/>

<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.js"></script> -->
<!-- <script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
<style>
#dataDiv {
	margin: auto;
}
#dataDiv p {
	text-align: center;
}

</style>

</head>
<body>
	<c:import url="../newheaderM.jsp"/>
	<h2>場地資料修改</h2>
	<div class="container">
		<div class="row">
			<div id="dataDiv" class="col-4">			
				<form:form id="updateFieldForm" modelAttribute="field" action="updateField" method="post">
					<input name="typeIdHide" style="display: none" value="${typeId}"/>
					<table class="table table-bordered">
						<tr><td><form:label path="id">編號</form:label>
							<td>
							<c:if test="${field.id!=null}">
								<form:input path="id" value="${field.id}" readonly="true"/>
							</c:if>
							<c:if test="${field.id==null}">
								<form:input path="id" value="${field.id}"/>
							</c:if>
							
						<tr><td><form:label path="name">名稱</form:label>
							<td><form:input path="name" value="${field.name}"/>
						<tr><td><form:label path="fieldType">類型</form:label>
							<td><form:select path="fieldType">
									<c:forEach var="fType" items="${fieldTypeList}">
										<option <c:if test="${field.fieldType.id==fType.id}">selected</c:if> value="${fType.id}">${fType.name}</option>
									</c:forEach>
								</form:select>
						<tr><td><form:label path="position">位置</form:label>
							<td><form:select path="position">
									<option <c:if test="${field.position=='5F'}">selected</c:if> value="5F">5F</option>
									<option <c:if test="${field.position=='4F'}">selected</c:if> value="4F">4F</option>
									<option <c:if test="${field.position=='3F'}">selected</c:if> value="3F">3F</option>
									<option <c:if test="${field.position=='2F'}">selected</c:if> value="2F">2F</option>
									<option <c:if test="${field.position=='1F'}">selected</c:if> value="1F">1F</option>
									<option <c:if test="${field.position=='B1'}">selected</c:if> value="B1">B1</option>
								</form:select>
						<tr><td><form:label path="rentForMember">租金(會員)</form:label>
							<td><form:input path="rentForMember" value="${field.rentForMember}"/>
						<tr><td><form:label path="rentForAct">租金(活動)</form:label>
							<td><form:input path="rentForAct" value="${field.rentForAct}"/>
						<tr><td><form:label path="situation">狀態</form:label>
							<td><form:select path="situation" value="${field.situation}">
									<option <c:if test="${field.situation==1}">selected</c:if> value="1">可使用</option>
									<option <c:if test="${field.situation==0}">selected</c:if> value="0">不可使用</option>
								</form:select>
						<tr><td><form:label path="remark">備註</form:label>
							<td><form:input path="remark" value="${field.remark}"/>
							<tr><td><form:label path="remark">創建日期</form:label>
							<td><form:input path="buildDate" cssClass="datepicker" value="${field.buildDate}"/>
					</table>	
					<p>
						<button type="button" id="insertButton" class="btn btn-primary">送出</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/sport/field_GetAllFields" id="insertButton" class="btn btn-secondary">返回</a>
					</p>
					
				</form:form>
			</div>
		</div>
	</div>
<script>
$("#insertButton").on("click", function() {
	Swal.fire({
		icon: "question",
		showCancelButton: true,
		confirmButtonText: "確定",
		cancelButtonText: "取消",
		title: "確定修改？",
		text: "請確認資料是否正確"
	}).then((result) => {
		if (result.isConfirmed) {
			$("#updateFieldForm").submit();			
		}
	});
	
// 	if(!confirm("確定要修改？")){
// 		return false;
// 	}
});

$.datepicker.setDefaults($.datepicker.regional['zh-TW']);
</script>
<c:import url="../footer.jsp"/>	
</body>
</html>