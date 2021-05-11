<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
<c:import url="../../headerScript.jsp" />
<style type="text/css">

span.error {
  color: red;
  display: inline-block;
  font-size: 5pt;
}

.title{
color: #556372;
font-weight: bold;

}









</style>
<meta charset="UTF-8">
<title>新增商品</title>
<%-- <link rel='stylesheet' href="<c:url value='/css/style.css' />" type="text/css" /> --%>
</head>
<body>
	<c:import url="../../newheaderM.jsp" />
<fieldset style="width:550px;margin:auto;margin-top:50px;">
	<legend ><span class="title">新增商品資料(Product)</span></legend> 
	<form:form method="POST" modelAttribute="product" enctype='multipart/form-data'>
		<br>
	<Table style="align-self: center;">
	


	   <tr>
	      <td>商品名稱：<br>&nbsp;</td>
		  <td  width='200'><form:input path='product_name' style="width:440px;" /><br>&nbsp;	
		      <form:errors path='product_name' cssClass="error"/>
		  </td>
	   </tr>
	   <tr>

          <td>分類：<br>&nbsp;</td>
		  <td  width='200'>
	   	  	<form:select path="productCategory.id">
	   	  		<form:option value="-1" label="請選擇" />
				<form:options  items="${productCategoryList}"
	   	  	   			itemLabel='name' itemValue='id'/>
	   	  	</form:select><br>&nbsp;
	   	   <form:errors path="productCategory"  cssClass="error" />
	   	  </td>
	   	
		  
	   </tr>
	   <tr>
	      <td>價錢：<br>&nbsp;</td>
	   	  <td>
	      	<form:input path="product_price"/><br>&nbsp;	
		      <form:errors path='product_price' cssClass="error"/>
		  </td>
	  </tr>
	  <tr>	  
		   <td>庫存：<br>&nbsp;</td>
	   	  <td>
	      	<form:input path="product_stock"/><br>&nbsp;	
		      <form:errors path='product_stock' cssClass="error"/>
		  </td>
	   </tr>	   
	  	   
	   <tr>
	      <td>商品描述：<br>&nbsp;</td>
	   	  <td>
			  <form:textarea style="width:440px;height:100px;" path="product_remark"/><br>&nbsp;	
		      <form:errors path='product_remark' cssClass="error"/>
	   	  </td>
	   </tr>
	   
	   <tr>
	   	  <td>商品圖片：<br>&nbsp;</td>
	   	  <td>
	   	  	 <form:input path="productImage" type='file'/><br>&nbsp;
	   	  	 <form:errors path="productImage"  cssClass="error" /><hr>
	   	  </td>
	   </tr>
	   
	   <tr>
	    <td colspan='4' align='center'>
	      <input class="btn btn-success" type='submit'>
	      
        </td>
              
	   </tr>

	</Table>

	</form:form>
	

	<br>
		<c:choose>
	<c:when test="${keyword == null}">
		<div style="margin-left:234px;" ><a href="<c:url value='/shop/showAllProducts?page=${currentPage}&status=${status}&category=${category}'/> " ><button class="btn btn-dark">取消</button></a></div>
	</c:when>
	<c:otherwise>
	    <div style="margin-left:234px;" ><a href="<c:url value='/shop/showSearchProducts?keyword=${keyword}&page=${currentPage}&status=${status}&category=${category}'/> " ><button class="btn btn-dark">取消</button></a></div>
	</c:otherwise>
	</c:choose>
	
</fieldset>

<br>

</body>
</html>