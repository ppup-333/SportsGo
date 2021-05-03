<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
</head>
<body>
	<form:form modelAttribute="field" action="updateField" method="post">
		<input name="typeId" style="display: none" value="${typeId}"/>
		<table>
			<tr><td><form:label path="id">編號</form:label></td>
				<td><form:input path="id" value="${field.id}"/></td>
				<td><form:errors path="id"/></td>
			<tr><td><form:label path="name">名稱</form:label>
				<td><form:input path="name" value="${field.name}"/>
				<td><form:errors path="name"/></td>
			<tr><td><form:label path="fieldType">類型</form:label>
				<td><form:select path="fieldType">
						<option value="0" <c:if test="${field.fieldType.id==0}">selected</c:if>>- 請選擇 -</option>
						<option value="1" <c:if test="${field.fieldType.id==1}">selected</c:if>>羽毛球</option>
						<option value="2" <c:if test="${field.fieldType.id==2}">selected</c:if>>籃球</option>
						<option value="3" <c:if test="${field.fieldType.id==3}">selected</c:if>>壁球</option>
						<option value="4" <c:if test="${field.fieldType.id==4}">selected</c:if>>桌球</option>
						<option value="5" <c:if test="${field.fieldType.id==5}">selected</c:if>>排球</option>
					</form:select>
				<td><form:errors path="fieldType"/></td>
			<tr><td><form:label path="position">位置</form:label>
				<td><form:select path="position">				
						<option value="5F" <c:if test="${field.position}=='5F'">selected</c:if>>5F</option>
						<option value="4F" <c:if test="${field.position}=='4F'">selected</c:if>>4F</option>
						<option value="3F" <c:if test="${field.position}=='3F'">selected</c:if>>3F</option>
						<option value="2F" <c:if test="${field.position}=='2F'">selected</c:if>>2F</option>
						<option value="1F" <c:if test="${field.position}=='1F'">selected</c:if>>1F</option>
						<option value="B1" <c:if test="${field.position}=='B1'">selected</c:if>>B1</option>
					</form:select>
			<tr><td><form:label path="rentForMember">租金(會員)</form:label>
				<td><form:input path="rentForMember" value="${field.rentForMember}"/>
				<td><form:errors path="rentForMember"/></td>
			<tr><td><form:label path="rentForAct">租金(活動)</form:label>
				<td><form:input path="rentForAct" value="${field.rentForAct}"/>
				<td><form:errors path="rentForAct"/></td>
			<tr><td><form:label path="situation">狀態</form:label>
				<td><form:select path="situation">
						<option value="1" <c:if test="${field.situation==1}">selected</c:if>>可使用</option>
						<option value="0" <c:if test="${field.situation==0}">selected</c:if>>不可使用</option>
					</form:select>
			<tr><td><form:label path="remark">備註</form:label>
				<td><form:input path="remark" value="${field.remark}"/>
			<tr><td><form:label path="buildDate">創建日期</form:label>				
				<td><form:input path="buildDate" type="date" value="${field.buildDate}" /><br>
			<tr><td><td><form:button type="submit" id="createButton">送出</form:button>
		</table>
	</form:form>
    
    
		
<%-- 	</form> --%>

<script>

	$("#createButton").on("click", function() {
		if(!confirm("確定要新增？")){
			return false;
		}
	});	
	
// 	$.datepicker.regional['zh-TW'] = {
// 			clearText: '清除', clearStatus: '清除已選日期',
// 			closeText: '關閉', closeStatus: '取消選擇',
// 			prevText: '<上一月', prevStatus: '顯示上個月',
// 			nextText: '下一月>', nextStatus: '顯示下個月',
// 			currentText: '今天', currentStatus: '顯示本月',
// 			monthNames: ['一月','二月','三月','四月','五月','六月',
// 			'七月','八月','九月','十月','十一月','十二月'],
// 			monthNamesShort: ['一月','二月','三月','四月','五月','六月',
// 			'七月','八月','九月','十月','十一月','十二月'],
// 			monthStatus: '選擇月份', yearStatus: '選擇年份',
// 			weekHeader: '周', weekStatus: '',
// 			dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
// 			dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
// 			dayNamesMin: ['日','一','二','三','四','五','六'],
// 			dayStatus: '設定每周第一天', dateStatus: '選擇 m月 d日, DD',
// 			dateFormat: 'yy-mm-dd', firstDay: 1, 
// 			initStatus: '請選擇日期', isRTL: false
// 	};
	
// 	$(".datepicker").datepicker({
// 		dateFormat: "yy-mm-dd",
// 		changeMonth: true,
// 		changeYear: true,
// 	});
    
// 	$.datepicker.setDefaults($.datepicker.regional['zh-TW']);

</script>
</body>
</html>