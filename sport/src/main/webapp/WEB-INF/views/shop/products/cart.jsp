<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>

.title{
/* color:#2482e0; */
text-shadow: 2px 4px 3px rgba(0,0,0,0.2);
margin-top:20px;
font-size : 34px;
font-weight:bolder;
text-align: center;
}



.All {
	width: 1280px;
	min-height:680px;
	margin-left: 120px;

}

#allProductInCart {
   width: 960px;

   margin-top:30px;  
   margin-left:160px;
/*    border: 1px black solid;  */
   padding:10px 0px;
}

.productInCart {
	width: 960px;
	height: 100px;
	margin: 0 auto;
	background-color:#ffffff;
	
    border: 1px black solid; 
/*  	line-height:80px;   */
/* 	border-radius:14px; */
	vertical-align:middle;
/* 		display:table-cell;  */
}

.productInCart:hover{
	background-color:#e0fcff;
	border: 1px grey solid; 

}


.productInCart * {
vertical-align:middle;
}

.prodPic{
  vertical-align : middle;
  border:6px #f0f0ef solid;
  margin:16px 14px 16px 12px;
  
  border-radius:12px;
}

.pnamebox{
  display: inline-block; 
  height: 72px;
  width: 540px;
  font-size:20px;
  font-weight:bold;
  color:#2a2e32; 

}

.pname{
  overflow:hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}

.pnamehref{
  color:#2a2e32;
  text-decoration:none;
}

.pnamehref:hover{
  color:#5a636c;
}

.buttons{
height:36px;
  display: inline-block; 
  padding:30px:
  
}

ul,li{
margin:0; padding:0; 
}

.counter li{
float:left; 
list-style-type:none; 
width:32px; 
height:32px; 
text-align:center; 
line-height:30px; 
border:#999 thin solid; 
background-color:#fff
}

.counter li input{
font-size:20px; 
width:100%; 
height:100%; 
outline:none; 
-webkit-appearance:none; 
background:none; 
margin:0; 
padding:0; 
border: 1px solid transparent; 
border-radius: 0;

margin-top:-10px;
}

#countnum{ 
border-left:hidden; 
border-right:hidden; 
color:#666
}

.price{
  font-size:17px;
  color:grey;
}

.pprice{
  font-size:20px;
  font-weight:bold;
  color:grey;
}

.stock{
  font-size:14px;
  color:grey;
}

.sumprice{
  font-size:18px;
  font-weight:bold;
  color:#15058f;

  position: relative;
   top: -3px;
   margin-left:15px;
/*     margin:23px; */

}

.delete{
width:50px;
height:30px;
border:0;
background-color:grey;
color:#fff;
border-radius:10px;
cursor:pointer;
float:right;
margin-right:15px;
margin-top:36px;
}

.delete:hover{
  background-color:black;
  border:2px #003C9D solid;
}

.clearCart {
font-size:14px;
height:25px;
border:2px grey solid;
background-color:grey;
color:#fff;
border-radius:10px;
cursor:pointer;
float:right;
margin-right:8px;

}

.clearCart:hover{
  background-color:black;
  border:2px #003C9D solid;
}

#cartFooter{
   width: 600px;
   height:100px;
   margin-top:10px;  
   margin-left:340px;
/*    border: 1px black solid;  */
   padding:10px 0px;
   text-align:center; 

}

.prodAll{
 font-weight:bolder;
 text-align:center;
 width:300px;
 margin:auto;

}
.selectAll{
  font-size:13px;
}

.cartPic{
margin-top:15px;
margin-left: 330px;
}

.emptyCart{
border:10px grey solid;
/* background-color:grey; */
/* color:#fff; */
border-radius:100px;
}

.deleteSelectProd{
font-size:14px;
height:25px;
border:2px grey solid;
background-color:grey;
color:#fff;
border-radius:10px;
cursor:pointer;
margin-left:20px;
margin-right:8px;
margin-top:-3px;
}

.deleteSelectProd:hover{
  background-color:black;
  border:2px #003C9D solid;
}
input[type=checkbox] {
  -webkit-transform: scale(1.3); /* Safari and Chrome */
  height:18px;
  vertical-align:text-top;
  margin-left:5px;
  margin-top:3px;
}

#clickAll{
-webkit-transform: scale(1.3); /* Safari and Chrome */
  height:18px;
  vertical-align:text-top;
  margin-left:5px;
  margin-top:2px;
  margin-right:5px;
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
}

.continue, .home, .checkBill{
/* margin-left:50px; */
/* margin-right:50px; */

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
.continue:hover, .home:hover, .checkBill:hover{
  background-color:#1b1dac;
  border:2px #003C9D solid;
}




</style>

<title>購物車</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>

</head>
<body>


<div class="All2" >

<c:import url="../../header.jsp" />


<div class="All">
	<p class="title">我的購物車</p>

	<div id="allProductInCart">
	
<!-- 		<div class="productInCart"> -->
<!-- 			<label>&nbsp;<input type="moox" name="selectProduct" value="check"> </label> -->
<!-- 			<a><img width='60' height='60' src='picture/2'/></a> -->
<!-- 			<div class="pnamebox"><p class="pname"> -->
<%-- 				<a class="pnamehref" href="<c:url value='/'/>">金黃5號-精選鵝毛A級室內外羽毛球 (1打12入)aaaawdwdwdaaa</a><br> --%>
<!-- 				<span class="price">&nbsp;NT$&nbsp;</span><span class="pprice">500</span></p> -->
<!-- 			</div>&nbsp;&nbsp; -->
<!-- 			<div class="buttons"> -->
<!-- 				<ul class="counter"> -->
<!-- 					<li id="minus"><input type="button" class="minuser" value="-"/></li> -->
<!-- 					<li id="countnum">0</li> -->
<!-- 					<li id="plus"><input type="button" class="adder"  value="+"/></li> -->
<!-- 				</ul><br><br><span class="stock">&nbsp;庫存數量：30</span> -->
<!-- 			</div> -->
<!-- 			<span class="sumprice">總價$ 500</span> -->
<!-- 			<input class="delete" type="button" value="刪除"/> -->
<!-- 		</div> -->
		
	</div>
	
	<div id="cartFooter">
<!-- 		<span id="sumPriceZone"></span> -->
<!-- 		<input class="continue" type="button" value="繼續購物"/> -->
<!-- 		<input class="home" type="button" value="回到首頁"/> -->
<!--  		<input class="checkBill" type="button" value="結帳去"/>  -->
	
	
	
	
	
	</div><br><br><br><br>

</div>
</div>


<script type='text/javascript'>

$(document).ready(xhrFunction);

function xhrFunction(){
	var xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='getCartJson'/>",true);
	xhr.send();
	if(xhr!=null){
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				cartProducts(xhr.responseText);		
			}					
		}
	}
}



function cartProducts(responseText){
	var mapData = JSON.parse(responseText);		
	var productList = mapData.productList;
	var productNums = mapData.productNums;
	var checks = mapData.checks;
	var content = "<div>&nbsp;<input name='clickAll'  id='clickAll' type='checkbox' class='selecter' /><span class='selectAll' >全選</span>"
				+"<input class='deleteSelectProd' type='button' value='刪除所選商品' />"
				+"<input class='clearCart' type='button' value='清空購物車' /></div>"
				
	
	if(productList.length > 0){			

		for(var i=0; i < productList.length; i++){		
						
				content += "<hr><div class='productInCart'><label>&nbsp;"
						+"<input type='checkbox' name='selectProduct' check="+checks[i]+"  value='"+productList[i].product_price*productNums[i]+"' selectName='"+productList[i].product_name+"' selectNum='"+productNums[i]+"' ></label>"
						+"<a><img class='prodPic' width='72' height='72' src='picture/"+productList[i].product_id+"'/></a>"
						+"<div class='pnamebox'><p class='pname' title='"+productList[i].product_name+"'><a class='pnamehref' href='storeProduct/"+productList[i].product_id+"'>"+productList[i].product_name+"</a><br>"
						+"<span class='price'>&nbsp;NT$&nbsp;</span><span class='pprice'>"+productList[i].product_price+"</span></p></div>&nbsp;&nbsp;"
						+"<div class='buttons'>"
						+"<ul class='counter'>"
						+"<li id='minus'><input type='button' class='minuser' value='-' minusCartId='"+productList[i].product_id
						+"'minusCartName='"+productList[i].product_name+"'/></li>"
						+"<li id='countnum'>"+productNums[i]+"</li>"
						+"<li id='plus'><input type='button' class='adder' value='+' addCartId='"+productList[i].product_id
						+"'addCartName='"+productList[i].product_name+"'/></li>"
						+"</ul><br><p class='stock'>&nbsp;庫存數量："+productList[i].product_stock+"</p></div>"
						+"<span class='sumprice'>小計$ "+ productList[i].product_price * productNums[i] +"</span>"
						+"<input class='delete' type='button' value='刪除' delCartId='"+productList[i].product_id
						+"'delCartName='"+productList[i].product_name+"'/></div>"
			
		}
		content+="<hr><h5 class='prodAll'>購物車內共有 "+productList.length+" 種商品</h5>";
		contentfoot = "<span id='sumPriceZone'></span>"
					+"<a href='/sport/shop/storeProductsAll'><input class='continue' type='button' value='繼續購物'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
					+"<a href='<c:url value='/'/>'><input class='home' type='button' value='回到首頁'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
					+"<input class='checkBill' type='button' value='結帳'/><br><br>";
		allProductInCart.innerHTML = content;
		cartFooter.innerHTML = contentfoot;

		//$('.productInCart').css('background', '#e0fcff');	
		$('input[name="selectProduct"]').each(function(i) {
			if( $(this).attr('check')==1){
				$(this).prop("checked",true);
				$(this).parent().parent().css('background', '#e0fcff');	
			} 
		});
		if ($('input[name="selectProduct"]:checkbox:checked').length != productList.length){
			$("#clickAll").prop("checked", false);
		} else {
			$("#clickAll").prop("checked", true);
		}
		priceSum();

		

	}else if(productList.length == 0){
		content = "<div class='emptyCart'><img class='cartPic' src='../images/cart.png'  width='250' height='236' />"
				+ "<br><br><p style='text-align:center; font-size:22px; font-weight:bold;'>購物車裡空無一物，請去選購商品再來</p><div>"; 
		contentfoot = "<span id='sumPriceZone'></span><hr><br>"
					+"<a href='/sport/shop/storeProductsAll'><input class='continue' type='button' value='繼續購物'/></a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;"
					+"<a href='<c:url value='/shopHome'/>'><input class='home' type='button' value='回到首頁'/></a><br><br>";
		allProductInCart.innerHTML = content;
		cartFooter.innerHTML = contentfoot;
	}
				
				

	




	
    function priceSum(){  //計算總金額
    	var sumPrice=0;
        $("[name=selectProduct]:checkbox:checked").each(function(){
          sumPrice += parseInt($(this).val());
          });
        var contentPrice="總共金額為 : <span class='sumPrices'>"+sumPrice+"</span> 元<hr><br>";
        sumPriceZone.innerHTML = contentPrice;
    }

	
	function check(){  //記錄勾選內容
    	var selectCheck ={};
		$('input[name="selectProduct"]').each(function(i) {
			if( $(this).prop("checked")==true){
				selectCheck[''+i] = 1;
				$(this).parent().parent().css('background', '#e0fcff');	
			} else {
				selectCheck[''+i] = 0;
				$(this).parent().parent().css('background', '');
			}			
		});
		
		$.ajax({
	        url: 'CheckRecord',              // 要傳送的頁面
	        contentType : "application/json",
	        method: 'POST',               // 使用 POST 方法傳送請求
	        dataType: 'text',             // 回傳資料會是 json 格式
	        data: JSON.stringify(selectCheck),  // 將表單資料用打包起來送出去
	        success: function(response){ // 成功以後會執行這個方法   
	        	xhrFunction();
	        },
	        error: function(response) {
	        	console.log("response = "+response)
	            alert("error");
	        }
	    });
		
	}



	
	
	
	
	$('.adder').click(function() {  //購物車增加商品
		var id = $(this).attr('addCartId');
		var name = $(this).attr('addCartName');
		var count=$(this).parent().prev().text();
		count=parseInt(count)+1;
		var json = {"addCartId" : id, "addCartName" : name, "proCount" : count};

		 $.ajax({
		        url: 'CartAdder',              // 要傳送的頁面
		        contentType : "application/json",
		        method: 'POST',               // 使用 POST 方法傳送請求
		        dataType: 'text',             // 回傳資料會是 json 格式
		        data: JSON.stringify(json),  // 將表單資料用打包起來送出去
		        success: function(response){
		            console.log("response = "+response);// 成功以後會執行這個方法
		            if (response=="success") {
		        		$(this).parent().prev().text(count);
		        		check();	
						//xhrFunction();          	
		            } else {
		            	Swal.fire({
			    		    toast: true,
			    		    position: 'top-end',
			    		    showConfirmButton: false,
			    		    timer: 2000,
			    		    icon: 'error',
			    		    title: '加入購物車失敗',
			    		    text: "庫存數量不足!",
			    		})
		            }
		        },
		        error: function(response) {
		            alert("error");
		        }
		    });

		});
	
	
	$('.minuser').click(function() {  //購物車減少商品
		var id = $(this).attr('minusCartId');
		var name = $(this).attr('minusCartName');
		var count=$(this).parent().next().text();
		
		if(count<=1){
			var json = {"delCartId" : id, "delCartName" : name};
			 cartDelete(json); 
			
		}else {
			count=parseInt(count)-1;
			var json = {"minusCartId" : id, "minusCartName" : name, "proCount" : count};
			 $.ajax({
			        url: 'CartMinus',              // 要傳送的頁面
			        contentType : "application/json",
			        method: 'POST',               // 使用 POST 方法傳送請求
			        dataType: 'text',             // 回傳資料會是 json 格式
			        data: JSON.stringify(json),  // 將表單資料用打包起來送出去
			        success: function(response){ // 成功以後會執行這個方法
			            if (response=="success") {
			            	console.log(response);
			            	$(this).parent().next().text(count);
			            	check();
							//xhrFunction();	          	
			            } else {
			            	Swal.fire({
				    		    toast: true,
				    		    position: 'top-end',
				    		    showConfirmButton: false,
				    		    timer: 2000,
				    		    icon: 'error',
				    		    title: '失敗',
				    		    text: "errorrrr!",
				    		})
			            }
			        },
			        error: function(response) {
			            alert("error");
			        }
			    });
			}		
		});
	
	
	
	$('.delete').click(function() {  //購物車刪除商品
		var id = $(this).attr('delCartId');
		var name = $(this).attr('delCartName');
		//var json = {"delCartId" : id, "delCartName" : name};
		var json = {"delCartName" : name};
	    console.log("JSONS = "+JSON.stringify(json)) 
		cartDelete(json);
	});
		
	$('.deleteSelectProd').click(function() {  //購物車刪除所勾選商品
		if ($('input[name="selectProduct"]:checkbox:checked').length == 0){
			Swal.fire({
    		    toast: true,
    		    position: 'top',
    		    showConfirmButton: false,
    		    timer: 2000,
    		    icon: 'error',
    		    title: '請勾選刪除商品!',
    		})
    		return false;
		}		
		var selectProd = new Array(); 
		var selectedProd ={};
		$('input[name="selectProduct"]:checkbox:checked').each(function(i) {
			selectProd[i] =  $(this).attr('selectName');
			selectedProd['delCartName'+i] = selectProd[i];
		});
		cartDelete(selectedProd);
	});

	
	
	$('.checkBill').click(function() {  //準備結帳
		if ($('input[name="selectProduct"]:checkbox:checked').length == 0){
			Swal.fire({
    		    toast: true,
    		    position: 'top',
    		    showConfirmButton: false,
    		    timer: 2000,
    		    icon: 'error',
    		    title: '請勾選結帳商品!',
    		})
    		return false;
		}

		var selectProd = new Array(); 
		var selectNum = new Array(); 
		var selectedProd ={};
		$('input[name="selectProduct"]:checkbox:checked').each(function(i) {
			selectProd[i] =  $(this).attr('selectName');
			selectNum[i] =  $(this).attr('selectNum');
			selectedProd[''+selectProd[i]] = selectNum[i];
		});
        
        Swal.fire({ 
	      	  title: '結帳商品', 
	      	  text: '是否要將所選商品進行結帳?', 
	      	  icon: 'question',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '結帳Go!',
	      	  backdrop: false,

	      	  }).then(result => {
	      		  if (result.value) {	  
	      			$.ajax({
	    		        url: 'order/OrderTemp',              // 要傳送的頁面
	    		        contentType : "application/json",
	    		        method: 'POST',               // 使用 POST 方法傳送請求
	    		        dataType: 'text',             // 回傳資料會是 json 格式
	    		        data: JSON.stringify(selectedProd),  // 將表單資料用打包起來送出去
	    		        success: function(response){ // 成功以後會執行這個方法   
//     		        	    console.log("response = "+response)
	    		        	if (response =="success") {
	    		        		self.location.href='order/orderCheck1';
	    		        	} else if(response =="login"){
	    		        		Swal.fire({
					    		    toast: true,
					    		    position: 'center',
					    		    showConfirmButton: false,
					    		    timer: 2500,
					    		    icon: 'error',
					    		    title: '尚未登入',
					    		    text: "請先登入再進行結帳!",    
					    		})
	    		        			
	    		        	} else {
	    		        		Swal.fire({
					    		    toast: true,
					    		    position: 'center',
					    		    showConfirmButton: false,
					    		    timer: 3500,
					    		    icon: 'error',
					    		    title: '結帳失敗',
// 					    		    text: response+" 的庫存數量不足!",
					    		    html: response+" 的庫存數量不足! <br><br><p style='text-align:center;font-size:18px;font-weight:bold;'>請重新選擇數量。</p>",
					    		})
	    		        	}
 	    
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
	
	
	
	function cartDelete(json) {  //刪除商品實作Function
		Swal.fire({ 
	      	  title: '刪除商品', 
	      	  text: '是否要將所選商品移出購物車?', 
	      	  icon: 'question',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '就是刪!',
	      	  backdrop: false,

	      	  }).then(result => {
	      		  if (result.value) {	  
	      			$.ajax({
	    		        url: 'CartDel',              // 要傳送的頁面
	    		        contentType : "application/json",
	    		        method: 'POST',               // 使用 POST 方法傳送請求
	    		        dataType: 'text',             // 回傳資料會是 json 格式
	    		        data: JSON.stringify(json),  // 將表單資料用打包起來送出去
	    		        success: function(response){ // 成功以後會執行這個方法
	    		        	console.log("response = "+response)
	    		            if (response=="success") {
	    		            	Swal.fire({
	    			    		    toast: true,
	    			    		    position: 'top-end',
	    			    		    showConfirmButton: false,
	    			    		    timer: 2000,
	    			    		    icon: 'success',
	    			    		    title: '移出購物車成功',
	    			    		    //text: id,
	    			    		})
	    						xhrFunction();
	              	
	    		            } else {
	    		            	Swal.fire({
	    			    		    toast: true,
	    			    		    position: 'top-end',
	    			    		    showConfirmButton: false,
	    			    		    timer: 2000,
	    			    		    icon: 'error',
	    			    		    title: '刪除購物車失敗',
	    			    		    text: "ERROR!",
	    			    		})
	    		            }
	    		        },
	    		        error: function(response) {
	    		            alert("error");
	    		        }
	    		    });

	      			} else {
	      				return false;
	      			}
	      	  });
	}
	
	$('.clearCart').click(function() {  //清空購物車
		var json = {"clearCart" : "clear"};
		Swal.fire({ 
	      	  title: '清空購物車', 
	      	  text: '是否要將購物車清空?', 
	      	  icon: 'question',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '清空',
	      	  backdrop: false,

	      	  }).then(result => {
	      		  if (result.value) {	  
	      			$.ajax({
	    		        url: 'CartClear',              // 要傳送的頁面
	    		        contentType : "application/json",
	    		        method: 'POST',               // 使用 POST 方法傳送請求
	    		        dataType: 'text',             // 回傳資料會是 json 格式
	    		        data: JSON.stringify(json),  // 將表單資料用打包起來送出去
	    		        success: function(response){
	    		            console.log("response = "+response);// 成功以後會執行這個方法
	    		            if (response=="success") {
	    		            	Swal.fire({
	    			    		    toast: true,
	    			    		    position: 'top-end',
	    			    		    showConfirmButton: false,
	    			    		    timer: 2000,
	    			    		    icon: 'success',
	    			    		    title: '清空購物車成功',
	    			    		    //text: id,
	    			    		})
	    						xhrFunction();
	              	
	    		            } else {
	    		            	Swal.fire({
	    			    		    toast: true,
	    			    		    position: 'top-end',
	    			    		    showConfirmButton: false,
	    			    		    timer: 2000,
	    			    		    icon: 'error',
	    			    		    title: '清空購物車失敗',
	    			    		    text: "ERROR!",
	    			    		})
	    		            }
	    		        },
	    		        error: function(response) {
	    		            alert("error");
	    		        }
	    		    });

	      			} else {
	      				return false;
	      			}
	      	  });
	});
	
	
	$("#clickAll").click(function() {  //全選商品
		var check = $("#clickAll").prop("checked");
		if (check == true){
			$("input[name='selectProduct']").prop("checked", true);
			$(".productInCart").css('background', '#e0fcff');
		} else {
			$("input[name='selectProduct']").prop("checked", false);
			$(".productInCart").css('background', '');
		}
		priceSum();
	});

	
	$("input[name='selectProduct']").click(function() {  //點選商品時動作
		priceSum();
		var check = $(this).prop("checked");

		if (check == true){
			$(this).parent().parent().css('background', '#e0fcff');			
		} else {
			$(this).parent().parent().css('background', '');
		}

		if ($('input[name="selectProduct"]:checkbox:checked').length != productList.length){
			$("#clickAll").prop("checked", false);
		} else {
			$("#clickAll").prop("checked", true);
		}
// 		console.log("checks = "+$('input[name="selectProduct"]:checkbox:checked').val());
// 		var selectProd = new Array(); //送出所選商品的時候把這段加進去code就好
// 		$('input[name="selectProduct"]:checkbox:checked').each(function(i) {
// 			selectProd[i] =  $(this).attr('selectName');
// 		});
	});



}
		
</script>

<script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>

</body>
</html>