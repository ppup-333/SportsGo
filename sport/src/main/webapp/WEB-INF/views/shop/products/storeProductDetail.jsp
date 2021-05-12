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

#productHead{
height:650px;

}

#productPic{
display: inline-block;
width:600px;
margin:50px;
margin-left:250px;
margin-right:0px;
position: relative;
top:-95px;
/* transform:scale(1,1);transition: all 0.3s ease-out; */
}

#productPic:hover{
/* transform:scale(1.02,1.02); */
cursor: pointer;
}

#productDetail{
display: inline-block;
position:relative;
top:100px;
height:500px;
width:450px;
/* border: 1px black solid; */
border-radius: 40px;
padding-bottom: 10px;
background-color: #ecf9f8;
}

#pName{
height:30px;
margin:30px;
font-size: 24px;
font-weight: bold;
}

.priceTitle{
font-size: 18px;
color:black;

}

#pPrice{
height:30px;
margin:30px;
margin-top:60px;
margin-bottom:25px;
font-size: 28px;
font-weight: bold;
color: #0854a1;
}


.stockTitle{
font-size: 18px;
color:black;
/* text-decoration: none; */
}

#pStock{
height:30px;
margin:30px;
font-size: 22px;
font-weight: bold;
margin-top:25px;
margin-bottom:15px;
color: #969ca2;
/* text-decoration: underline; */
}


#pay{
height:30px;
margin:30px;
font-size: 26px;
font-weight: bold;
margin-top:0px;
 color: #4a900e; 
}

.payTitle{
font-size: 18px;
color:black;
}

#delivery{
height:30px;
margin:30px;
font-size: 18px;
font-weight: bold;
margin-top:30px;
color: #0178ef;
}

.deliveryTitle{
font-size: 18px;
color:black;
}




#pNum{
height:30px;
margin:30px;
font-size: 18px;
font-weight: bold;
margin-top:-10px;
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
top:10px;
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
margin:30px;
margin-top: 20px;
height:80px;
}

.addCartButton{
font-size:20px;
width:210px;
height:60px;
border:3px #003C9D solid;
background-color:#003C9D;
color:#fff;
border-radius:10px;
cursor:pointer;
margin-top:20px;
margin-right:0px;
text-align: left;


}

.addCartButton:hover{
/*   color:#003C9D; */
  background-color:#3072d9;
  border:3px #003C9D solid;
  box-shadow:1px 1px 2px grey  ;
  text-align: left;
}


.addNum{
display: inline-block; 
position: relative;
left:5px;
bottom:2px;
 -webkit-border-radius: 4px;
 -moz-border-radius: 4px;
 border-radius: 25px;
 background-color: #f75818;
 color: #fff;
/*  display: block; */
/*  float: left; */
 height: 25px;
 width:25px;
 padding: 1px 2.5px 1px 2px;
 text-align: center;
 vertical-align: top;
}

.addNone{
display: inline-block; 
position: relative;
left:5px;
bottom:2px;
 -webkit-border-radius: 4px;
 -moz-border-radius: 4px;
 border-radius: 25px;
 height: 25px;
 width:25px;
 padding: 1px 2.5px 1px 2px;
 text-align: center;
 vertical-align: top;
}

.noStock{
font-size:20px;
font-weight:bold;
width:210px;
height:60px;
border:3px #de2621 solid;
background-color:red;
color:#fff;
border-radius:10px;
margin-top:20px;
margin-right:0px;

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
 height: 25px;
 width:25px;
 padding: 0px 2.5px 2px 2.5px;
 text-align: center;
 vertical-align: top;
}



#productCenter{
 width: 1000px;
 height:330px;
/*  border: 2px black solid; */
 margin-top:60px;  
 margin-left:270px;
 padding:10px 0px;
 border-radius: 18px;
 text-align: center;
 font-size: 18px;
 background-color: #f5fefe;
 background-image: linear-gradient(to right, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.05), rgba(0.25, 0, 0, 0));
}

.intro{
 color:#3d7fc7;
 font-size: 17px;
 font-weight:bold;
 margin:4px;
}


#productRemark{
 width: 830px;
/*  border: 2px black solid; */
 margin-top:50px;  
 margin-left:355px;
 padding:10px 0px;
 border-radius: 8px;
 background-color: #f4fafb;
  background-image: linear-gradient(to right, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.05), rgba(0.25, 0, 0, 0));
/*   text-align: center; */
}

.remark{
/*  color:#3d7fc7; */
 font-size: 19px;
 font-weight:bold;
 margin:4px;
 margin-left:60px;
}


hr.style-two {
border: 0;
height: 5px;
background-image: linear-gradient(to right, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.75), rgba(0, 0, 0, 0));
}


.remarkTitle{
margin-top:15px;
text-align: center;
font-size: 26px;
font-weight: bolder;
color: #165498;

}


#productFooter{

 width: 1000px;
 height:250px;
 border: 2px black solid;
 margin-top:30px;  
 margin-left:270px;
 padding:10px 0px;
 border-radius: 8px;

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

	<div id="productHead">
	
		<div id='productPic'>
			<img class='pic' width='500' height='500' src='../picture/${product_id}'/>
		</div>
		
		<div id='productDetail'>
			<div id="pName">  </div>
			<div id="pPrice"> </div>
			<div id="pStock"> </div>
			
			<div id="pay"><span class="payTitle">付款方式 : </span>
			<i class="fab fa-cc-visa"></i>&nbsp;<i class="fab fa-cc-mastercard"></i>&nbsp;<i class="fab fa-cc-jcb"></i>
			
			</div>
			
			<div id="delivery"><span class="deliveryTitle">運送方式 : </span>宅配 $100<br>
			&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp;自取 $0
			</div>
			
			
			
			<div id="pNum"> <p class="pNumi">數量 : &nbsp;</p> 
			
			<ul class="counter">
					<li id="minus"><input type="button" class="minuser" value="-"/></li>
						<li id="countnum"><input id="buy_count" type="number" maxlength="3" max="15"  class="inputNum" value=1 ></li>
					<li id="plus"><input type="button" class="adder"  value="+"/></li>
			</ul>
			</div>
			<div id="addCart"> <button>加入購物車</button></div>
			
		</div>
	
	</div>
	<hr class='style-two' style="width:1280px;height:2px;">
	
	<div id="productCenter">
	<p class='remarkTitle'>關於我們</p><hr class='style-two'>
	<p class="intro">Sports Go!購物商城一直致力於打造為「正版代理，輕鬆購物，誠信經營」的優質購物平台。</p>
	
	<p class="intro">我們有別於一般的網購平台，本商城的商品均經由原廠授權，</p>
	
	<p class="intro">每一件商品來源清晰明瞭，皆有原廠認證，保證是代理公司貨而非平行輸入商品。</p>
	
	<p class="intro">顧客可以選擇由我們的合作貨運公司宅配到府，或者是親自前來運動中心現場取貨。</p>
	
	<p class="intro">商品凡經購買後一年期間，若產品有非人為因素的任何問題，均可以向本商城進行退換貨的服務。</p>
	
	<p class="intro">Sport's Go!購物商城以保障消費者利益為本，將竭盡所能的為消費者提供各種協助，</p>
	
	<p class="intro">確保每一位消費的顧客皆能享受到完善的服務。</p>
	

	</div>
	
	<div id="productRemark">
	</div>

	<div id="product">
	</div>

	<div id="productFooter">
		<p class='remarkTitle'>售後服務</p><hr class='style-two'>
	</div>
	<br><br>
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
 	pPrice.innerHTML = "<span class='priceTitle'>售價 : </span>$"+product.product_price+"";
 	pStock.innerHTML = "<span class='stockTitle'>庫存數量 : </span>"+product.product_stock+"";
 	
 	if (productNum != null && productNum!= 0){
 		addCart.innerHTML = "<button class='addCartButton'>&emsp;&nbsp;<i class='fas fa-cart-plus'>&nbsp;加入購物車<span class='addNum'>"+productNum+"</span></i></button>";
 	} else {
 		addCart.innerHTML = "<button class='addCartButton'>&emsp;&nbsp;<i class='fas fa-cart-plus'>&nbsp;加入購物車<span class='addNone'></span></i></button>";
 	}
 	
 	if (product.product_stock == 0){
 		addCart.innerHTML = "<button class='noStock' disabled='disabled'>售完缺貨</button>";
 	}

	contentRemark = product.product_remark;
	productRemark.innerHTML = "<p class='remarkTitle'>商品描述</p><hr class='style-two'><br><p class='remark'>"+contentRemark+"</p><br>";
 	
//  	contentfoot ="<a href='../orderList'><input class='continue' type='button' value='回訂單列表'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
// 				+"<a href='<c:url value='/shopHome'/>'><input class='home' type='button' value='回到首頁'/></a>&nbsp;&nbsp;&nbsp;&nbsp;";
// 	productFooter.innerHTML = contentfoot;
	
	
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
	
	

$('.pic').click(function() {  //減少商品
	var count = $('#buy_count').val();
	Swal.fire({
		imageUrl: '../picture/'+product_id,
		heightAuto:false,
		width:660,

		showConfirmButton: true, 
		imageWidth: 660,
		padding:-40,
// 		imageHeight: 640,
// 		box-sizing: border-box,
		//imageAlt: 'A tall image'
		backdrop: false,
		showClass: {
            popup: '',
          },
          hideClass: {
            popup: '',
          },
		})
	

	});
		
	
	


	
	
	
	
	
	
	
	
</script>
<!-- <script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script> -->

</body>
</html>