<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../../headerScript.jsp" />
<meta charset="UTF-8">

<style type="text/css">


#All{

display: none;

}

#productPic{
display: inline-block;
width:600px;
margin:50px;
margin-left:250px;
}


#productDetail{
display: inline-block;
position:relative;
top:100px;
height:600px;
}

#pName{
margin:30px;
}

#pPrice{
margin:30px;
}

#pStock{
margin:30px;
}

#pNum{
margin:30px;
}

.pNumi{
display: inline-block;
 margin-top:20px; 
}



ul,li{
margin:0; padding:0; 
}

.counter{
display: inline-block;
position: relative;
top:25px;
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


#addCart{
margin:50px;
}


.addCartButton{
font-size:16px;

width:130px;
height:40px;
border:0;
background-color:#003C9D;
color:#fff;
border-radius:10px;
cursor:pointer;
margin-top:20px;
margin-right:0px;

}

.addCartButton:hover{
/*   color:#003C9D; */
  background-color:#3072d9;
  border:3px #003C9D solid;
   box-shadow:1px 1px 2px grey  ;
}

#productRemark{
 width: 830px;
border: 2px black solid;
   margin-top:50px;  
   margin-left:350px;
   padding:10px 0px;
   border-radius: 8px;

}

.inputNum{
font-size: 16px;
text-align: center;

}

input[type=number]::-webkit-outer-spin-button,
input[type=number]::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}


/* .cartbox{ */
/*   position:absolute; */
/* 　top:480px; */
/* 　left:480px */

/* } */

.cart{

  border: none;
  text-decoration: none;
  background-color: white;
  color:red;
  font-weight: bolder;
  position:fixed;
/* 　top:1280px; */
  top:115px;
  right: 45px;


}

.cartpic{
margin-bottom:0px;

}

.cartNum{
display: inline-block; 
margin-left:-20px;
position: relative;
top:-10px;

 -webkit-border-radius: 4px;
 -moz-border-radius: 4px;
 border-radius: 25px;
 background-color: red;

 color: #fff;
/*  display: block; */
/*  float: left; */
 height: 25px;
 width:25px;
 padding: 0px 2.5px 2px 2.5px;
 text-align: center;
 vertical-align: top;

}


</style>

<title>${product_name}</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>

</head>
<body>

<div id="All">
<c:import url="../../newheader.jsp" />

<!-- <div class="cartbox"> test123dfffffffffffff4567</div> -->

<div class="cart"><a href="<c:url value='../myShoppingCart' />" ><img class="cartpic" src='../../images/carticon.jpg' width='60' height='40'  /><span id="cartnn" style="display: inline-block; "><p class='cartNum' style="opacity:0.0;"></p></span></a></div>

	<div id="product0">
	
		<div id='productPic'>
			<img width='500' height='500' src='../picture/${product_id}'/>
		</div>
		
		<div id='productDetail'>
			<div id="pName">  </div>
			<div id="pPrice"> </div>
			<div id="pStock"> </div>
			<div id="pNum"> <p class="pNumi">數量 : </p> 
			
			<ul class="counter">
					<li id="minus"><input type="button" class="minuser" value="-"/></li>
						<li id="countnum"><input id="buy_count" type="number" maxlength="3" max="15"  class="inputNum" value=1 ></li>
					<li id="plus"><input type="button" class="adder"  value="+"/></li>
			</ul>
			</div>
			<div id="addCart"> <button>加入購物車</button></div>
			
		</div>
	
	</div>
	
	<div id="productRemark">
	</div>

	<div id="product">
	</div>

	<div id="productFooter">
	</div>
</div>

<script type='text/javascript'>

var product_id = ${product_id};
$(document).ready(xhrFunction);
function xhrFunction(){
	var xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='getProductDetailJson/"+product_id+"'/>",true);
	xhr.send();
	if(xhr!=null){
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				productDetails(xhr.responseText);		
			}					
		}
	}
}

var product = null;

function productDetails(responseText){
	var mapData = JSON.parse(responseText);	
	product = mapData.product;
	var cartNum = mapData.cartNum;
	var content = "";
	var cartcontent = "";
	var productNum = mapData.productNum;
	
 	pName.innerHTML = product.product_name;
 	pPrice.innerHTML = "售價 : $"+product.product_price+" 元";
 	pStock.innerHTML = "庫存數量 : "+product.product_stock+" 件";
 	
 	if (productNum != null && productNum!= 0){
 		addCart.innerHTML = "<button class='addCartButton'><i class='fas fa-cart-plus'>  加入購物車</i></button>&emsp;("+productNum+")";
 	} else {
 		addCart.innerHTML = "<button class='addCartButton'><i class='fas fa-cart-plus'>  加入購物車</i></button>";
 	}
 	
	contentRemark = product.product_remark;
	productRemark.innerHTML = contentRemark;
 	
 	contentfoot ="<a href='../orderList'><input class='continue' type='button' value='回訂單列表'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
				+"<a href='<c:url value='/shopHome'/>'><input class='home' type='button' value='回到首頁'/></a>&nbsp;&nbsp;&nbsp;&nbsp;";
	productFooter.innerHTML = contentfoot;
	
	
	if (cartNum != 0){
		cartcontent +="<p class='cartNum'>"+cartNum+"</p>" //""+cartNum+"";
		cartnn.innerHTML = cartcontent;
	}

	$("#All").show();
	

$('.addCartButton').click(function() {
	var addCartNum = $('#buy_count').val(); 
	if (addCartNum == 0 ){
		Swal.fire({
		    toast: true,
		    position: 'top-end',
		    showConfirmButton: false,
		    timer: 2000,
		    icon: 'error',
		    title: '加入購物車失敗',
		    text: "數量請選擇至少一件!",
		})
		return false;
	}
	
	
	var json = {"addCartId" : product_id, "addCartName" : product.product_name, "addCartNum" : addCartNum};
	 $.ajax({
	        url: '../addCart',              // 要傳送的頁面
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
		    		    title: '加入購物車成功',
		    		})
		    		$('#buy_count').val(1);
					xhrFunction();
					
	            } else {
	            	Swal.fire({
		    		    toast: true,
		    		    position: 'top-end',
		    		    showConfirmButton: false,
		    		    timer: 2000,
		    		    icon: 'error',
		    		    title: '加入購物車失敗',
		    		    //text: "庫存數量不足!",
		    		    html: "<p style='text-align:center;font-size:18px;font-weight:bold;'>庫存數量不足!</p>",
		    		})
	            	
	            }

	        },
	        error: function(response) {
	            alert("error");
	        }
	    });

	});
}

$('.adder').click(function() {  //增加商品
	var count = $('#buy_count').val();
	if (count < product.product_stock) {
		count = parseInt(count)+1;
		$('#buy_count').val(count);
		} else {
			Swal.fire({
    		    toast: true,
    		    position: 'top-end',
    		    showConfirmButton: false,
    		    timer: 2000,
    		    icon: 'error',
    		    title: '超過庫存數量!',
    		})
    		return false; 
		}
	});
	
$('.minuser').click(function() {  //減少商品
	var count = $('#buy_count').val();
	if (count>1){
		count=parseInt(count)-1;
		$('#buy_count').val(count);
		} else return false; 
	});
	
	
</script>
<!-- <script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script> -->

</body>
</html>