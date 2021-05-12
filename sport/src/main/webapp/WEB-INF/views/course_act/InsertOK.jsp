<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:import url="../headerScript.jsp"/>
<title>Insert title here</title>
<style type="text/css">
.result{
margin-top:300px
margin-right:auto;
margin-left:auto;
}
.main_body{
text-align:center;
}
</style>
</head>

<body>
<c:import url="../newheaderM.jsp" />
<div class='main_body'>
<h1 class='result'>${result}</h1>
<button onclick="window.location.href='/sport/NewManageActivityMain'">返回</button>
</div>

</body>
</html>