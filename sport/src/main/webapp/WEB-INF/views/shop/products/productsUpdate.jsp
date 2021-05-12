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
font-size: 23px;
margin-left:30px;
}

.field{
background-color: #eef4f7;
border:10px #eef4f7 solid;
border-radius: 20px;

}


</style>
<meta charset="UTF-8">
<title>修改商品</title>
</head>
<body>
	<c:import url="../../newheaderM.jsp" />
<fieldset class="field" style="width:550px;margin:auto;margin-top:50px;">
	<span class="title">更新商品資料 (Product)</span> 
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
	   	  	 <form:input path="productImage" type='file'/>&nbsp;
	   	  	 <form:errors path="productImage"  cssClass="error" /><hr><br>
	   	  </td>
	   </tr>
	   
	   <tr>
	    <td colspan='4' align='center'>
	      <input type='submit' class="btn btn-success" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <button type="button" id="cancel" class="btn btn-secondary" >取消</button>
	    </td>
	   </tr>
	</Table>
	
	</form:form>
	
	<input type='hidden' id='keyword' value='${keyword}'>
	<input type='hidden' id='currentPage' value='${currentPage}'>
	<input type='hidden' id='status' value='${status}'>
	<input type='hidden' id='category' value='${category}'>

</fieldset>
<br>
<script type='text/javascript'>

      $('#cancel').click(function() {
    	  var keyword = document.getElementById("keyword").value;
    	  var currentPage = document.getElementById("currentPage").value;
    	  var status = document.getElementById("status").value;
    	  var category = document.getElementById("category").value;
    	  
    	  console.log("keyword ="+keyword);
    	  console.log("currentPage ="+currentPage);
    	  console.log("status ="+status);
    	  console.log("category ="+category);
    	  
    	  if (keyword==""){
    		  window.location.href = "/sport/shop/showAllProducts?page="+currentPage+"&status="+status+"&category="+category;   
    	  } else{
    		  window.location.href = "/sport/shop/showSearchProducts?keyword="+keyword+"&page="+currentPage+"&status="+status+"&category="+category;   
    	  }
    	    
    	  
    	});
    		
      
</script>
</body>
</html>