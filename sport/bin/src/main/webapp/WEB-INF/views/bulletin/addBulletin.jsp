<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<style type="text/css">
span.error {
	color: red;
	display: inline-block;
	font-size: 5pt;
}
</style>
<meta charset="UTF-8">
<link rel='stylesheet' href="<c:url value='/css/style.css' />"
	type="text/css" />
</head>
<body>
	<fieldset>
		<legend>新增公告</legend>
		<form:form method="POST" modelAttribute="bulletin" enctype='multipart/form-data'>
			<Table style="align-self: center;">
				<tr>
					<td>公告標題：<br>&nbsp;
					</td>
					<td width='360'><form:input path='title' /><br>&nbsp; 
					<form:errors
							path='title' cssClass="error" /></td>
					<td>公告內容：<br>&nbsp;
					</td>
					<td width='360'><form:textarea path="contents" /><br>&nbsp;
						<form:errors path='contents' cssClass="error" /></td>
				</tr>
				<tr>
					<td>公告分類:<br>&nbsp;
					</td>
					<td><form:select path="class_id.id">
							<form:option label="請挑選" value="-1" />
							<form:options items="${classList}" itemLabel='name'
								itemValue='id' />
						</form:select><br>&nbsp; <form:errors path="class" cssClass="error" /></td>
				</tr>
				<tr>
					<td colspan='4' align='center'><br>&nbsp; <input
						type='submit'></td>
				</tr>
			</Table>
		</form:form>
	</fieldset>
	<br>
	<div align="center">
		<a href="<c:url value='/bulletin'/> ">回前頁</a>
	</div>
</body>
</html>