<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EcpayConfirm</title>
 <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
<form  id="ecpay" method="post" action="../springsport/ecpay" target="_blank">
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
<button class="confirm">確認付款</button>
</body>
<script type="text/javascript">
$(".confirm").on("click",function(){
	if(confirm("確認付款")){
		$("#ecpay").submit();
		
		$.ajax({		
			url:"/springsport/index",
		    context: document.body,
		    success: function(result){	
		    		console.log("哈囉");
		    	$("#sport").html(result);		    
		   }
		});
	}
});
</script>

</html>