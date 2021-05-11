<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EcpayOrderConfirm</title>
</head>
<body>

<form  id="ecpay" method="post" action="../sport/ecpayAct">
<table>
<tr><td>account<td>${account}
<tr><td>課程名稱<td>${itemName}
<tr><td>總金額<td>${totalAmount}
<tr><td>備註<td>${remark}
<input name="actId" value="${actId}" style="display:none;"/>
<input name="orderId" value="${orderId}" style="display:none;"/>
<input name="account" value="${account}" style="display:none;"/>
<input name="itemName" value="${itemName}" style="display:none;"/>
<input name="totalAmount" value="${totalAmount}" style="display:none;"/>
<input name="TradeDesc" value="${remark}" style="display:none;"/>
</table>
</form>
 <button type="button" onclick="window.location.href='/sport/activityApply?actId=${actId}'">上一步</button>
<button class="confirm">確認付款</button>
</body>
<script type="text/javascript">


$(".confirm").on("click",function(){
	Swal.fire({
		title:'確定付款?',
		icon:'question',
      	showCancelButton: true, 
      	confirmButtonColor: '#3085d6',
      	cancelButtonColor: '#d33',
      	confirmButtonText: '確定',
      	cancelButtonText:'取消',
	}).then(result => {
		if(result.value){			
			$("#ecpay").submit();			
		}
	})
	
		
	
});
</script>
</body>
</html>