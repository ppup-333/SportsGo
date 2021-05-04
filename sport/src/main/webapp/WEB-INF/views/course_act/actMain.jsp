<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>actMain</title>
</head>
<body>
<c:forEach item="resultList" var="item">
<h1>${item}</h1>
</c:forEach>

</body>
</html>