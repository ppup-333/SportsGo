<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>	
<!DOCTYPE html>
<html>
<head>
<%-- <link rel='stylesheet' href="<c:url value='/css/style.css' />" type="text/css" /> --%>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<title>商城首頁</title>
</head>
<body>
	<h2 style="text-align:center">商城系統暫定首頁</h2>
	<hr/>
	<div style="text-align:center">
	<a href='shop/showAllProducts'><img src="images/shop.jpg"  width="600" height="400" /></a><br>
	
	<a href='shop/showAllProducts'><button>商城後台系統管理</button></a><br>
	</div>
	<br>
	<hr>
	<br>
	<div style="text-align:center">
	<a href='shop/storeProductsAll'><button>商城系統(暫)</button></a><br>
	</div>
	<br>
	<div style="text-align:center">
	<a href='shop/myShoppingCart'><button>購物車車(暫)</button></a><br>
	</div>
	<br>
	<div style="text-align:center">
	<a href='shop/order/orderList'><button>會員訂單(暫)</button></a><br>
	</div>
	
	
	
<%-- <img src='${pageContext.request.contextPath}/images/zero.jpg'> --%>


<!-- 	<div> -->
<!-- 		<form method="post" action="../GetField"> -->
<!-- 			<h1>This is a SHOP.</h1> -->
<!-- 		</form> -->
<!-- 	</div> -->
	
<!-- 	<div class="img"> -->
<!-- 	<a href="../GetAllProducts"><img src="../images/shop.jpg"  width="600" height="400" /></a> -->
<!-- 	</div> -->
	
<!-- 	<form method="post" action="../GetAllProducts"> -->
<!-- 		<button type="submit">進入商城</button> -->
<!-- 	</form> -->
	
<!-- 	<form> -->
<!-- 		<a href="ProductManager.html"><input type="button" value="後台系統"></a> -->
<!-- 	</form> -->

</body>
</html>