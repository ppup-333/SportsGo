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
text-align: center;
}


.field{
background-color: #eef4f7;
border:10px #eef4f7 solid;
border-radius: 20px;
box-shadow:0px 0px 5px grey  ;

}

.title2{
color: #055c2c;
font-weight: bold;
font-size: 19px;
}

</style>
<meta charset="UTF-8">
<title>新增商品</title>
</head>
<body>
	<c:import url="../../newheaderM.jsp" />
<fieldset class="field"  style="width:690px;margin:auto;margin-top:50px;">
<!-- 	<legend ><span class="title">新增商品資料 (Product)</span></legend>  -->
	<p class="title">新增商品資料 (Product)</p>
	<form:form method="POST" modelAttribute="product" enctype='multipart/form-data'>
	<br>
	<Table style="align-self: center;">
	
	   <tr>
	      <td class="title2">商品名稱：<br>&nbsp;</td>
		  <td  width='200'><form:input id='pname' path='product_name' style="width:500px;" /><br>&nbsp;	
		      <form:errors path='product_name' cssClass="error"/>
		  </td>
	   </tr>
	   <tr>

          <td class="title2">分類：<br>&nbsp;</td>
		  <td  width='200'>
	   	  	<form:select path="productCategory.id" id="pcate">
	   	  		<form:option value="-1" label="請選擇" />
				<form:options  items="${productCategoryList}"
	   	  	   			itemLabel='name' itemValue='id'/>
	   	  	</form:select><br>&nbsp;
	   	   <form:errors path="productCategory"  cssClass="error" />
	   	  </td>
	   	
	   </tr>
	   <tr>
	      <td class="title2">價錢：<br>&nbsp;</td>
	   	  <td>
	      	<form:input path="product_price" id='pprice'/><br>&nbsp;	
		      <form:errors path='product_price' cssClass="error"/>
		  </td>
	  </tr>
	  <tr>	  
		   <td class="title2">庫存：<br>&nbsp;</td>
	   	  <td>
	      	<form:input path="product_stock" id='pstock'/><br>&nbsp;	
		      <form:errors path='product_stock' cssClass="error"/>
		  </td>
	   </tr>	   
	  	   
	   <tr>
	      <td class="title2">商品描述：<br>&nbsp;</td>
	   	  <td>
			  <form:textarea style="width:500px;height:350px;" path="product_remark" id='premark'/><br>&nbsp;	
		      <form:errors path='product_remark' cssClass="error"/>
	   	  </td>
	   </tr>
	   
	   <tr>
	   	  <td class="title2">商品圖片：<br>&nbsp;</td>
	   	  <td>
	   	  	 <form:input path="productImage" type='file'/>&nbsp;
	   	  	 <form:errors path="productImage"  cssClass="error" /><hr><br>
	   	  </td>
	   </tr>
	   
	   <tr>
	    <td colspan='4' align='center'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    	
	      <input type='submit' class="btn btn-success" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <button type="button" id="cancel" class="btn btn-secondary" >取消</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <button type="button" id="onekey"  class="btn btn-primary " >一鍵輸入</button>
	        
	        
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
      
      $('#onekey').click(function() {
    	$("input[id='pname']").val("【初階】 羽毛球套組 (拍*2 球*2、拍套) PERFLY");
    	$("input[id='pprice']").val("399");
    	$("input[id='pstock']").val("27");
    	$("textarea[id='premark']").val("品牌 : PERFLY\r\n"
				+ "性別 : 成人\r\n"
				+ "運動 : 羽毛球\r\n"
				+ "運動範圍 : 羽毛球\r\n"
				+ "\r\n"
				+ "重量 : 105 g\r\n"
				+ "長度 : 665 mm\r\n"
				+ "內容 : 2支球拍及2顆塑膠羽球\r\n"
				+ "平衡 : 313 mm\r\n"
				+ "\r\n"
				+ "材質 : \r\n"
				+ "框架 : 100.0% 鋁 \r\n"
				+ "手把 : 90.0% 木頭, 10.0% 聚氨酯纖維 （PU） \r\n"
				+ "旅行袋 : 100.0% 聚酯纖維 \r\n"
				+ "包裝 : 50.0% 聚醯纖維, 50.0% 乙烯醋酸乙烯共聚物（EVA）");
    	$("select[id='pcate']").val("6");
    	
    	});
      
      
    		
      
</script>

</body>
</html>