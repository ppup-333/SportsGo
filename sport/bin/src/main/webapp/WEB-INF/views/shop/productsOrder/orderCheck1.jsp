<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>

.All {
	width: 1280px;
	min-height:680px;
	margin-left: 120px;
	display:none;
}

#allProductInOrder {
   width: 830px;
border: 1px black solid;
   margin-top:30px;  
   margin-left:220px;
   padding:10px 0px;

}


.productInOrder {
	width: 830px;
	height: 46px;
	margin: 0 auto;
	background-color:#ffffff;
	
/*     border: 2px black solid;   */
/*  	line-height:80px;   */
/* 	border-radius:14px; */
	vertical-align:middle;
/* 		display:table-cell;  */
}

.productInOrder * {
vertical-align:middle;
}

.prodPic{
  vertical-align : middle;
  border:2px #f0f0ef solid;
/*   margin:-5px 8px 30px 6px; */
  margin-left:8px;
  margin-right:8px;
  border-radius:12px;
}

.pnamebox{
  display: inline-block; 
  height: 46px;
  width: 490px;
  font-size:17px;
  font-weight:bold;
  color:#2a2e32; 
  margin-top:-12px;
/*   margin:-12px 0px 0px; */
/*   line-height:50px;  */
}

.pname{
  overflow:hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
/*   margin:13px 0px 0px; */
}

.pnamehref{
  color:#2a2e32;
  text-decoration:none;
}

.pnamehref:hover{
  color:#5a636c;
}


.price{
  display: inline-block; 
  font-size:18px;
  color:#187191;
  font-weight:bold;
/*   margin-top:-30px; */
}

.num{
  font-size:16px;
  font-weight:bold;
  margin-left:12px;
  position: relative;
/*   top: -9px; */
}

.sumprice{
  font-size:20px;
  font-weight:bold;
  color:#15058f;
  margin-left:14px;
  position: relative;
/*   top: -9px; */
}


#orderFooter{
   width: 600px;
   height:100px;
   margin-top:30px;  
   margin-left:340px;
/*    border: 1px black solid;  */
   padding:10px 0px;
   text-align:center; 

}

#orderOption{
   width: 600px;
   min-height:100px;
   margin-top:0px;  
   margin-left:340px;
/*    border: 1px black solid;  */
   padding:10px 0px;
   text-align:center; 

}

.sumNum{

 margin:auto;
 font-size:20px;
 font-weight:bold;

}

.cnum{

width:120px;
display: inline-block;
margin-left:590px;
}


.sumPrice{
 margin-left:6px;


}


#feeZone {
   width: 830px;
   margin-left:220px;
   padding:10px 0px;
}
.fee{
 margin:auto;
 color:red;
 font-size:20px;
 font-weight:bold;
 margin-left:700px;
/* text-decoration:underline;  */

}


#sumPriceZone {
  font-size:20px;
  font-weight:bold;
  color:#306eab;


}
.sumPrices{
  font-size:36px;
  font-weight:bold;
  color:#2c4ec3;
  text-decoration:underline; 
}

.continue, .home, .payBill{
margin:auto;
height:60px;
width:180px;
font-size:28px;
font-weight:bold;
border:2px white solid;
background-color:#1aa1ff;
color:#fff;
border-radius:10px;
cursor:pointer;
}
.continue:hover, .home:hover, .payBill:hover{
  background-color:#1b1dac;
  border:2px #003C9D solid;
}


input[type=checkbox]{
 -webkit-transform: scale(1.5); /* Safari and Chrome */
}

#dataBox{
width:360px;
margin-left:110px;
padding:10px;
border:4px black solid;
border-radius:30px;
background-color: #f0feff;

}

.d1, .d2{
color:#4F4FFF;
 font-size:18px;
 font-weight:bold;
/*  text-decoration:underline; */

}

#deliveryBox{
 display:none;
/*  margin-left:140px; */
/*  border:2px black solid; */
/*  border-radius:10px; */
}

#deliveryBox1{
float:left;
}

#deliveryBox2{
float:left;
}

#button{
width:180px;
margin-left:80px;
}


.name{
margin:10px;
width:90px;
height:22px;

}

.tel{
margin:10px;
width:90px;
height:22px;
 
 } 
 
 .address{
 margin:10px;
 width:280px;
height:22px;
 
 }
 
 
 .buyer{
 font-size:20px;
 font-weight:bold;
  text-decoration:underline;
 }

.auto{
width:80px;
height:30px;
border:0;
background-color:#5959FF;
color:white;
border-radius:10px;
cursor:pointer;
}

.auto:hover, .clear:hover{
  background-color:black;
  border:2px #003C9D solid;
}


.clear{
width:50px;
height:30px;
border:0;
background-color:grey;
color:#fff;
border-radius:10px;
cursor:pointer;
}




</style>

<title>訂單頁面</title>

<script type='text/javascript' src="<c:url value='/' />/scripts/jquery-1.9.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>

</head>
<body>

<div class="All">
	<h2 style="text-align: center">訂單明細</h2>

	<div id="allProductInOrder">
		
	</div>
	<div id="feeZone">
	<p class='fee'> + 運費 $ <span id="feePrice">0</span> </p>
<!-- 	<p class="fee">共計 19000元</p> -->
	</div>
	<div id="orderOption">
		<h3 style="display: inline-block; margin-top:-10px; ">請選擇運送方式：</h3>
		<div><input type='checkbox' name='delivery' value='delivery' ><span class="d1">宅配到府 (運費$ 100)</span>&emsp;
			 <input type='checkbox' name='take' value='take' ><span class="d2">中心自取 (免運費)</span><p></p>
				<div id='dataBox' >
				<span class="buyer">購買人資料</span>
		
					<table>
						
					    <tr><td><div id="deliveryBox1"><h4 style="display: inline-block; ">姓名 : </h4><input type="text" class="name" name="name" ></div></td></tr>
	
						<tr><td><div id="deliveryBox2"><h4 style="display: inline-block; ">電話 : </h4><input type="tel"  class="tel" name="tel" ></div></td></tr>
	    
						<tr><td><div id="deliveryBox"><h4 style="display: inline-block; ">地址 : </h4><input type="text" class="address" name="address" ></div></td></tr>
						
						<tr><td><div id="button"><input type="button" class="auto" value="一鍵輸入" >
									 			 <input type="button" class="clear" value="清除" ></div></td></tr>
						
					</table>
				</div>
		</div>
	</div>
	
	<div id="orderFooter">
<!-- 		<span id="sumPriceZone"></span> -->
<!-- 		<input class="continue" type="button" value="繼續購物"/> -->
<!-- 		<input class="home" type="button" value="回到首頁"/> -->
<!--  		<input class="checkBill" type="button" value="結帳去"/>  -->
	
	</div><br><br><br>
	
</div>
<script type='text/javascript'>

$(document).ready(xhrFunction);

function xhrFunction(){
	var xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='getOrderTempJson'/>",true);
	xhr.send();
	if(xhr!=null){
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				orderProducts(xhr.responseText);		
			}					
		}
	}
}

function orderProducts(responseText){
	var mapData = JSON.parse(responseText);	
	var content ='';
	var productList = mapData.productList;
	var productNums = mapData.productNums;
	var cartNum = mapData.cartNum;
	var sumPrice=0;
	var sumPrice2=0;
	var fee = 0;
				
		for(var i=0; i < productList.length; i++){		
				content += "<div class='productInOrder'>"
						+"<img class='prodPic' width='40' height='40' src='../picture/"+productList[i].product_id+"'/>"
						+"<div class='pnamebox'><p class='pname'><a class='pnamehref' href='<c:url value='/'/>'>"+productList[i].product_name+"</a></p></div>"
						+"<div class='price'>&nbsp;NT$&nbsp;"+productList[i].product_price+"</div>&nbsp;&nbsp;"
						+"<span class='num'> 數量 : "+productNums[i]+"</span>&nbsp;"
						+"<span class='sumprice'>小計 $ "+ productList[i].product_price * productNums[i] +"</span>"
						+"</div><hr>"
				sumPrice += productList[i].product_price * productNums[i];
			
		}
		content+="<p class='sumNum'><span class='cnum'>共 "+cartNum+" 件商品</span><span class='sumPrice'>合計 $ "+sumPrice+"</span></p>";
		
		contentfoot = "<span id='sumPriceZone'>訂單總金額 : <span class='sumPrices'>"+sumPrice+"</span> 元<hr><br></span>"
					+"<a href='../myShoppingCart'><input class='continue' type='button' value='回購物車'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
					+"<a href='<c:url value='/'/>'><input class='home' type='button' value='回到首頁'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
					+"<input class='payBill' type='button' value='付款'/>";

		allProductInOrder.innerHTML = content;
		orderFooter.innerHTML = contentfoot;
		$(".All").show();
		

    function priceSum(){
    	sumPrice2 = sumPrice + fee;
    	console.log("fee  = "+fee);
        var contentPrice="訂單總金額 : <span class='sumPrices'>"+sumPrice2+"</span> 元<hr><br>";
        sumPriceZone.innerHTML = contentPrice;
        feePrice.innerHTML = fee;
    }
		
		
	$("input[name='delivery']").click(function() {
		var check = $("input[name='take']").prop("checked");
		console.log("check  ==  "+check);
		if (check == true){
			$("input[name='take']").prop("checked", false);
			$("#takeBox").slideToggle(200);
			fee = 100;
		}
		if ($("input[name='delivery']").prop("checked")== true){
			fee = 100;
		} else fee=0;
		$("#deliveryBox").slideToggle(200);
		priceSum();
	});
	
	$("input[name='take']").click(function() {
		var check = $("input[name='delivery']").prop("checked");
		console.log("check  ==  "+check);
		if (check == true){
			$("input[name='delivery']").prop("checked", false);
			$("#deliveryBox").slideToggle(200);
			fee = 0;
		}
		$("#takeBox").slideToggle(200);
		priceSum();
	});
			
			
	
	$('.payBill').click(function() {
		
		if ($('input:checkbox:checked').length == 0){
			Swal.fire({
    		    toast: true,
    		    position: 'top',
    		    showConfirmButton: false,
    		    timer: 2000,
    		    icon: 'error',
    		    title: '請勾選運送方式!',
    		})
    		return false;
		}
		
		var name = $("input[name='name']").val();
		if (name == ""){
			Swal.fire({
    		    toast: true,
    		    position: 'top',
    		    showConfirmButton: false,
    		    timer: 2000,
    		    icon: 'error',
    		    title: '請填寫姓名!',
    		})
    		return false;
		}
		
		var tel = $("input[name='tel']").val();
		if (tel == ""){
			Swal.fire({
    		    toast: true,
    		    position: 'top',
    		    showConfirmButton: false,
    		    timer: 2000,
    		    icon: 'error',
    		    title: '請填寫電話號碼!',
    		})
    		return false;
		}
		
		var address = $("input[name='address']").val();
		if ($("input[name='delivery']").prop("checked") == true){	
			if (address == ""){
				Swal.fire({
	    		    toast: true,
	    		    position: 'top',
	    		    showConfirmButton: false,
	    		    timer: 2000,
	    		    icon: 'error',
	    		    title: '請填寫地址欄!',
	    		})
	    		return false;
			}
			var ship = 100;
    	} else {
    		address = '';
    		var ship = 0;
    	}

		var json = {"Name" : name, "Tel" : tel, "Ship" : ship, "Address" : address, "OrderPrice" : sumPrice2};
        Swal.fire({ 
	      	  title: '確認訂單', 
	      	  text: '是否確認訂單並進行付款?', 
	      	  icon: 'question',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '付款去!',
	      	  backdrop: false,
	      	  }).then(result => {
	      		  if (result.value) {	  
	      			$.ajax({
	    		        url: 'OrderCreate',              // 要傳送的頁面
	    		        contentType : "application/json",
	    		        method: 'POST',               // 使用 POST 方法傳送請求
	    		        dataType: 'text',             // 回傳資料會是 json 格式
	    		        data: JSON.stringify(json),  // 將表單資料用打包起來送出去
	    		        success: function(response){ // 成功以後會執行這個方法   
	    		        	    console.log("response = "+response)
	    		        	    alert("success");
	    		        },
	    		        error: function(response) {
	    		        	console.log("response = "+response)
	    		            alert("error");
	    		        }
	    		    });

	      			} else {
	      				return false;
	      			}
	      	  });

	});
	
	
	$('.auto').click(function() {
		$("input[name='name']").val("吳柏毅");
		$("input[name='tel']").val("0987666777");
		$("input[name='address']").val("台北市大安去信義路100號2樓");
	});
	
	$('.clear').click(function() {
		$("input[name='name']").val("");
		$("input[name='tel']").val("");
		$("input[name='address']").val("");
	});
		
	


}
</script>
</body>
</html>