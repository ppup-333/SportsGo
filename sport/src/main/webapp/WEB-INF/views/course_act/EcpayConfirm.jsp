<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EcpayConfirm</title>
 <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
 <style type="text/css">
 table {
text-align:center;
	border-collapse: collapse;
	border: 2px solid #D0D0D0;
	border-right: 1px solid #D0D0D0;
	margin-left: auto;
	margin-right: auto;
	margin-top:30px;
	margin-bottom:20px;
}

tr td:first-child {
	text-align:center;
   	padding: 20px;
	background-color: #D2E9FF;
	border-right: 1px solid #D0D0D0;
}


tr td:last-child {
text-align:center;
	padding: 20px;
	background-color: #66B3FF;
	border-right: 1px solid #D0D0D0;
}
.main_body {
	text-align: center;
}
 </style>
</head>
<body>

<c:import url="../header.jsp" />
 <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<div class="main_body">
 
<form  id="ecpay" method="post" action="../sport/ecpay" target="_blank">
<table>
<tr><td>account<td>${account}
<tr><td>課程名稱<td>${itemName}
<tr><td>總金額<td>${totalAmount}
<tr><td>備註<td>${remark}
<input name="courseId" value="${courseId}" style="display:none;"/>
<input name="orderId" value="${orderId}" style="display:none;"/>
<input name="account" value="${account}" style="display:none;"/>
<input name="itemName" value="${itemName}" style="display:none;"/>
<input name="totalAmount" value="${totalAmount}" style="display:none;"/>
<input name="TradeDesc" value="${remark}" style="display:none;"/>
</table>
</form>
<button>上一步</button>
<button class="confirm">前往付款</button>
</div>
</body>
<script type="text/javascript">
$(".confirm").on("click",function(){
	if(confirm("確認付款")){
		$("#ecpay").submit();
		$(".main_body").empty();
		$(".main_body").append("<button onclick=\"window.location.href='/sport/order'\">查詢課程訂單</button>");
	/*	$.ajax({		
			url:"/sport/",
		    context: document.body,
		    success: function(result){	
		    		console.log("哈囉");
		    	$("#sport").html(result);		    
		   }
		});*/
	}
});
</script>

</html>