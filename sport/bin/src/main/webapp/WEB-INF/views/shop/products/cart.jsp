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
  margin:16px 8px 16px 6px;
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
width:30px; 
height:30px; 
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
  font-size:20px;
  font-weight:bold;
  color:#15058f;



  position: relative;
   top: -3px;
   margin-left:25px;
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

height:25px;
border:2px grey solid;
background-color:grey;
color:#fff;
border-radius:10px;
cursor:pointer;
float:right;
margin-right:8px;
margin-top:-3px;

}

.clearCart:hover{
  background-color:black;
  border:2px #003C9D solid;
}

#cartFooter{
   width: 600px;
   height:100px;
   margin-top:30px;  
   margin-left:340px;
/*    border: 1px black solid;  */
   padding:10px 0px;
   text-align:center; 

}

.prodAll{
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
  margin-top:0;
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

<title>?????????</title>

<script type='text/javascript' src="<c:url value='/' />/scripts/jquery-1.9.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>

</head>
<body>

<div class="All">
	<h2 style="text-align: center">?????????</h2>

	<div id="allProductInCart">
	
<!-- 		<div class="productInCart"> -->
<!-- 			<label>&nbsp;<input type="moox" name="selectProduct" value="check"> </label> -->
<!-- 			<a><img width='60' height='60' src='picture/2'/></a> -->
<!-- 			<div class="pnamebox"><p class="pname"> -->
<%-- 				<a class="pnamehref" href="<c:url value='/'/>">??????5???-????????????A????????????????????? (1???12???)aaaawdwdwdaaa</a><br> --%>
<!-- 				<span class="price">&nbsp;NT$&nbsp;</span><span class="pprice">500</span></p> -->
<!-- 			</div>&nbsp;&nbsp; -->
<!-- 			<div class="buttons"> -->
<!-- 				<ul class="counter"> -->
<!-- 					<li id="minus"><input type="button" class="minuser" value="-"/></li> -->
<!-- 					<li id="countnum">0</li> -->
<!-- 					<li id="plus"><input type="button" class="adder"  value="+"/></li> -->
<!-- 				</ul><br><br><span class="stock">&nbsp;???????????????30</span> -->
<!-- 			</div> -->
<!-- 			<span class="sumprice">??????$ 500</span> -->
<!-- 			<input class="delete" type="button" value="??????"/> -->
<!-- 		</div> -->
		
	</div>
	
	<div id="cartFooter">
<!-- 		<span id="sumPriceZone"></span> -->
<!-- 		<input class="continue" type="button" value="????????????"/> -->
<!-- 		<input class="home" type="button" value="????????????"/> -->
<!--  		<input class="checkBill" type="button" value="?????????"/>  -->
	
	
	
	
	
	</div><br><br><br><br>

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
	var content = "<div>&nbsp;<input name='clickAll'  id='clickAll' type='checkbox' class='selecter' /><span class='selectAll' >??????</span>"
				+"<input class='deleteSelectProd' type='button' value='??????????????????' />"
				+"<input class='clearCart' type='button' value='???????????????' /></div>"
				
	
	if(productList.length > 0){			

		for(var i=0; i < productList.length; i++){		
						
				content += "<hr><div class='productInCart'><label>&nbsp;"
						+"<input type='checkbox' name='selectProduct' check="+checks[i]+"  value='"+productList[i].product_price*productNums[i]+"' selectName='"+productList[i].product_name+"' selectNum='"+productNums[i]+"' ></label>"
						+"<a><img class='prodPic' width='60' height='60' src='picture/"+productList[i].product_id+"'/></a>"
						+"<div class='pnamebox'><p class='pname'><a class='pnamehref' href='<c:url value='/'/>'>"+productList[i].product_name+"</a><br>"
						+"<span class='price'>&nbsp;NT$&nbsp;</span><span class='pprice'>"+productList[i].product_price+"</span></p></div>&nbsp;&nbsp;"
						+"<div class='buttons'>"
						+"<ul class='counter'>"
						+"<li id='minus'><input type='button' class='minuser' value='-' minusCartId='"+productList[i].product_id
						+"'minusCartName='"+productList[i].product_name+"'/></li>"
						+"<li id='countnum'>"+productNums[i]+"</li>"
						+"<li id='plus'><input type='button' class='adder' value='+' addCartId='"+productList[i].product_id
						+"'addCartName='"+productList[i].product_name+"'/></li>"
						+"</ul><br><br><span class='stock'>&nbsp;???????????????"+productList[i].product_stock+"</span></div>"
						+"<span class='sumprice'>??????$ "+ productList[i].product_price * productNums[i] +"</span>"
						+"<input class='delete' type='button' value='??????' delCartId='"+productList[i].product_id
						+"'delCartName='"+productList[i].product_name+"'/></div>"
			
		}
		content+="<hr><h3 class='prodAll'>?????????????????? "+productList.length+" ?????????</h3>";
		contentfoot = "<span id='sumPriceZone'></span>"
					+"<a href='/sport/shop/storeProductsAll'><input class='continue' type='button' value='????????????'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
					+"<a href='<c:url value='/shopHome'/>'><input class='home' type='button' value='????????????'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
					+"<input class='checkBill' type='button' value='??????'/>";
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
				+ "<h2 style='text-align:center'>???????????????????????????????????????????????????</h2><div>"; 
		contentfoot = "<span id='sumPriceZone'></span><hr><br>"
					+"<a href='/sport/shop/storeProductsAll'><input class='continue' type='button' value='????????????'/></a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;"
					+"<a href='<c:url value='/shopHome'/>'><input class='home' type='button' value='????????????'/></a>";
		allProductInCart.innerHTML = content;
		cartFooter.innerHTML = contentfoot;
	}
				
				

	




	
    function priceSum(){
    	var sumPrice=0;
        $("[name=selectProduct]:checkbox:checked").each(function(){
          sumPrice += parseInt($(this).val());
          });
        var contentPrice="??????????????? : <span class='sumPrices'>"+sumPrice+"</span> ???<hr><br>";
        sumPriceZone.innerHTML = contentPrice;
    }

	
	function check(){
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
	        url: 'CheckRecord',              // ??????????????????
	        contentType : "application/json",
	        method: 'POST',               // ?????? POST ??????????????????
	        dataType: 'text',             // ?????????????????? json ??????
	        data: JSON.stringify(selectCheck),  // ???????????????????????????????????????
	        success: function(response){ // ?????????????????????????????????   
	        	xhrFunction();
	        },
	        error: function(response) {
	        	console.log("response = "+response)
	            alert("error");
	        }
	    });
		
	}



	
	
	
	
	$('.adder').click(function() {
		var id = $(this).attr('addCartId');
		var name = $(this).attr('addCartName');
		var count=$(this).parent().prev().text();
		count=parseInt(count)+1;
		
// 		var selectProd = new Array(); 
// 		var selectNum = new Array(); 
// 		var selectedProd ={};
// 		$('input[name="selectProduct"]').each(function(i) {
// 			selectProd[i] =  $(this).attr('selectName');
// 			selectNum[i] =  $(this).attr('selectNum');
// 			selectedProd[''+selectProd[i]] = selectNum[i];	
// 		});
		
		//console.log("selectCheck = "+selectCheck);
		
		var json = {"addCartId" : id, "addCartName" : name, "proCount" : count};

		 $.ajax({
		        url: 'CartAdder',              // ??????????????????
		        contentType : "application/json",
		        method: 'POST',               // ?????? POST ??????????????????
		        dataType: 'text',             // ?????????????????? json ??????
		        data: JSON.stringify(json),  // ???????????????????????????????????????
		        success: function(response){
		            console.log("response = "+response);// ?????????????????????????????????
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
			    		    title: '?????????????????????',
			    		    text: "??????????????????!",
			    		})
		            }
		        },
		        error: function(response) {
		            alert("error");
		        }
		    });

		});
	
	
	
	$('.minuser').click(function() {
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
			        url: 'CartMinus',              // ??????????????????
			        contentType : "application/json",
			        method: 'POST',               // ?????? POST ??????????????????
			        dataType: 'text',             // ?????????????????? json ??????
			        data: JSON.stringify(json),  // ???????????????????????????????????????
			        success: function(response){ // ?????????????????????????????????
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
				    		    title: '??????',
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
	
	
	
	$('.delete').click(function() {
		var id = $(this).attr('delCartId');
		var name = $(this).attr('delCartName');
		//var json = {"delCartId" : id, "delCartName" : name};
		var json = {"delCartName" : name};
	    console.log("JSONS = "+JSON.stringify(json)) 
		cartDelete(json);
	});
		
	$('.deleteSelectProd').click(function() {
		if ($('input[name="selectProduct"]:checkbox:checked').length == 0){
			Swal.fire({
    		    toast: true,
    		    position: 'top',
    		    showConfirmButton: false,
    		    timer: 2000,
    		    icon: 'error',
    		    title: '?????????????????????!',
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

	
	
	$('.checkBill').click(function() {
		if ($('input[name="selectProduct"]:checkbox:checked').length == 0){
			Swal.fire({
    		    toast: true,
    		    position: 'top',
    		    showConfirmButton: false,
    		    timer: 2000,
    		    icon: 'error',
    		    title: '?????????????????????!',
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
	      	  title: '????????????', 
	      	  text: '?????????????????????????????????????', 
	      	  icon: 'question',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '??????Go!',
	      	  backdrop: false,

	      	  }).then(result => {
	      		  if (result.value) {	  
	      			$.ajax({
	    		        url: 'order/OrderTemp',              // ??????????????????
	    		        contentType : "application/json",
	    		        method: 'POST',               // ?????? POST ??????????????????
	    		        dataType: 'text',             // ?????????????????? json ??????
	    		        data: JSON.stringify(selectedProd),  // ???????????????????????????????????????
	    		        success: function(response){ // ?????????????????????????????????   
	    		        	    console.log("response = "+response)
	    		        	    self.location.href='order/orderCheck1';
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
	
	
	
	function cartDelete(json) {
		Swal.fire({ 
	      	  title: '????????????', 
	      	  text: '????????????????????????????????????????', 
	      	  icon: 'question',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '?????????!',
	      	  backdrop: false,

	      	  }).then(result => {
	      		  if (result.value) {	  
	      			$.ajax({
	    		        url: 'CartDel',              // ??????????????????
	    		        contentType : "application/json",
	    		        method: 'POST',               // ?????? POST ??????????????????
	    		        dataType: 'text',             // ?????????????????? json ??????
	    		        data: JSON.stringify(json),  // ???????????????????????????????????????
	    		        success: function(response){ // ?????????????????????????????????
	    		        	console.log("response = "+response)
	    		            if (response=="success") {
	    		            	Swal.fire({
	    			    		    toast: true,
	    			    		    position: 'top-end',
	    			    		    showConfirmButton: false,
	    			    		    timer: 2000,
	    			    		    icon: 'success',
	    			    		    title: '?????????????????????',
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
	    			    		    title: '?????????????????????',
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
	
	$('.clearCart').click(function() {
		var json = {"clearCart" : "clear"};
		Swal.fire({ 
	      	  title: '???????????????', 
	      	  text: '????????????????????????????', 
	      	  icon: 'question',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '??????',
	      	  backdrop: false,

	      	  }).then(result => {
	      		  if (result.value) {	  
	      			$.ajax({
	    		        url: 'CartClear',              // ??????????????????
	    		        contentType : "application/json",
	    		        method: 'POST',               // ?????? POST ??????????????????
	    		        dataType: 'text',             // ?????????????????? json ??????
	    		        data: JSON.stringify(json),  // ???????????????????????????????????????
	    		        success: function(response){
	    		            console.log("response = "+response);// ?????????????????????????????????
	    		            if (response=="success") {
	    		            	Swal.fire({
	    			    		    toast: true,
	    			    		    position: 'top-end',
	    			    		    showConfirmButton: false,
	    			    		    timer: 2000,
	    			    		    icon: 'success',
	    			    		    title: '?????????????????????',
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
	    			    		    title: '?????????????????????',
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
	
	
	$("#clickAll").click(function() {
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

	
	$("input[name='selectProduct']").click(function() {
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
// 		var selectProd = new Array(); //?????????????????????????????????????????????code??????
// 		$('input[name="selectProduct"]:checkbox:checked').each(function(i) {
// 			selectProd[i] =  $(this).attr('selectName');
// 		});
	});

	


	



	


}
		
</script>
</body>
</html>