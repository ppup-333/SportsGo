<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.js"></script> -->
<!-- <script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->


</head>
<body>
	<c:import url="../header.jsp"/>
	<form:form modelAttribute="field" action="updateField" method="post">
		<input name="typeIdHide" style="display: none" value="${typeId}"/>
		<table border="1">
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
			<tr><td><td><button type="submit" class="insertButton">送出</button>
		</table>	
		
	</form:form>
<script>
$(".insertButton").on("click", function() {
	if(!confirm("確定要修改？")){
		return false;
	}
});

$.datepicker.setDefaults($.datepicker.regional['zh-TW']);
</script>
</body>
</html>