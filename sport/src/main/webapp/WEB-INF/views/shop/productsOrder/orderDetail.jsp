<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">

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
	display:none;
}

table,th,td{
 border: 1px grey solid; 
font-size:20px;

}

.order tr:hover {
background-color: #f5f5f5;
}

.pname{
  min-width:550px;

  text-align:center;
  
}
.pname2{
   max-width:550px;
   font-weight: bold; 
   font-size:16px;

   
  overflow:hidden;
  white-space: nowrap;
  text-overflow: ellipsis;

}
.pprice{
text-align:center;
width: 90px;
}
.pnumber{
text-align:center;
width: 60px;
}
.psum{
text-align:center;
width: 90px;
font-weight: bolder;
}

#orderDetailList{
   width: 880px;
   border: 2px black solid;
   border-radius:10px;
   margin-top:30px;  
   margin-left:190px;
   padding:10px 0px;
}

.order{
  margin-left:42px;
}

.listNum{
margin-top:10px;
margin-left:544px; 
font-size: 20px;
font-weight: bold;
}

.ship{
margin-top:-10px;
margin-left:687px;
font-size: 20px;
font-weight: bold;
color: grey;
}


.sumPrice{
margin-top:-10px;
margin-left:648px;
font-size: 20px;
font-weight: bold;
 text-decoration: underline; 

}

.sumPricec{
display: inline-block;

font-size: 25px;
font-weight: bold;
color: red;
/* border-bottom: 3px solid red; */
/* margin-bottom: -22px; */

 text-decoration: underline; 

}



#orderBuyer{
   width: 600px;
   min-height:100px;
   margin-top:0px;  
   margin-left:320px;
/*    border: 1px black solid;  */
   padding:5px 0px;
/*    text-align:center;  */
 font-size: 20px;

}

.buyerData{
width:520px;
margin-left:50px;
margin-top:30px;
padding:10px;
border:4px black solid;
border-radius:30px;
background-color: #f0feff;
}

.buyertable{
 width: 450px;
 font-size: 20px;
 margin-left:22px;
 border: 0px red solid;
 
}

.buyertable th, .buyertable td{
border: 0px ;


}


.buyer{
text-align: center;
font-size: 20px;
font-weight: bolder;

}

#Box1{

font-weight: bold;
 font-size: 18px;
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


</style>


<title>訂單明細</title>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>

</head>

<body>

<c:import url="../../header.jsp" />

<input type='hidden' id='order_Id' value='${order_Id}'>



<div class="All">
	    <p class="title">訂單明細內容</p>


	<div id="orderDetailList">

	</div>
	
	<div id="orderBuyer">
		<div class="buyerData">
		<p class="buyer">購買人資料</p>
		
				<table class="buyertable">
					
				    <tr><td><div id="Box1"><p style="display: inline-block; height:18px; ">姓名 :&nbsp;</p><span id="bName"></span></div></td></tr>

					<tr><td><div id="Box1"><p style="display: inline-block; height:18px;">電話 :&nbsp;</p><span id="bTel"></span></div></td></tr>
					
					<tr><td><div id="Box1"><p style="display: inline-block; height:18px;">運送方式 :&nbsp;</p><span id="bShipway"></span></div></td></tr>
    
					<tr class="address"><td><div id="Box1"><p style="display: inline-block; height:18px;">地址 :&nbsp;</p><span id="bAddress"></span></div></td></tr>
					
					<tr><td><div id="Box1"><p style="display: inline-block; height:18px;">運費 :&nbsp;</p><span id="bShip"></span></div></td></tr>
					
					<tr><td><div id="Box1"><p style="display: inline-block; height:18px;">訂單總金額 :&nbsp;</p><span id="bPrice"></span></div></td></tr>
					

					
				</table>

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

var order_Id = document.getElementById("order_Id").value;

$(document).ready(xhrFunction);
function xhrFunction(){
	var xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='getOrderDetailJson/"+order_Id+"'/>",true);
	xhr.send();
	if(xhr!=null){
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				orderDetails(xhr.responseText);		
			}					
		}
	}
}

function orderDetails(responseText){
	var mapData = JSON.parse(responseText);	
	var content ='';
	var orderDetail = mapData.orderDetail;
	var productList = mapData.productList;
	var orderList = mapData.orderList;
	var listnum=0;
	var sumprice=0;
	
	if (orderList.address== ""){
		$(".address").css("display", "none");
	}

	
	
	content = "<table class='order'><tr>"
			+ "<th class='pname'>商品名稱</th>"
			+ "<th class='pprice'>商品售價</th>"
			+ "<th class='pnumber'>數量</th>"
			+ "<th class='psum'>商品總價</th></tr>";
	
	for(var i=0; i < orderDetail.length; i++){	
		content += "<tr><td class='pname2' title='"+productList[i].product_name+"'>&nbsp;"+productList[i].product_name+"</td>"
				 + "<td class='pprice'> $ "+productList[i].product_price+"</td>"
				 + "<td class='pnumber'>"+orderDetail[i].product_number+"</td>"
				 + "<td class='psum'> $ "+productList[i].product_price*orderDetail[i].product_number+"</td></tr>";
				 
				 listnum += orderDetail[i].product_number;
				 sumprice += productList[i].product_price*orderDetail[i].product_number;
	}
	content+="</table>";

	content += "<p class='listNum'>共 "+listnum+" 件商品&emsp;金額小計 : $ "+sumprice+""
	         + "<p class='ship'>+ 運費 : $ "+orderList.ship+"</p>"
	         + "<p class='sumPrice'>結帳總金額 : <span class='sumPricec'> $ "+orderList.order_price+"</span></p>"
	
	contentmain="";
	
	contentfoot ="<a href='../orderList'><input class='continue' type='button' value='回訂單列表'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
				+"<a href='<c:url value='/'/>'><input class='home' type='button' value='回到首頁'/></a>&nbsp;&nbsp;&nbsp;&nbsp;";
				
	if (orderList.order_status =="未付款"){
		contentfoot += "<input class='payBill' type='button' value='付款'/><br><br>";
	}

	orderDetailList.innerHTML = content;
	
	bName.innerHTML = ""+orderList.name+"";
	bTel.innerHTML = ""+orderList.tel+"";
	bAddress.innerHTML = ""+orderList.address+"";
	bShipway.innerHTML = ""+orderList.shipway+"";
	bShip.innerHTML = "$ "+orderList.ship+" 元";
	bPrice.innerHTML = "$ "+orderList.order_price+" 元";
	
	
	orderFooter.innerHTML = contentfoot;
	$(".All").show();
	
	
	$('.payBill').click(function() {
		Swal.fire({ 
	      	  title: '訂單付款', 
	      	  text: '是否進行付款?', 
	      	  icon: 'question',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '付款去!',
	      	  backdrop: false,
	      	  }).then(result => {
	      		  if (result.value) {	  
	      		var form = document.createElement('form');
        		form.action = '../productEcpay/'+orderList.order_id;
        		form.target = '_blank';
        		form.method = 'POST';
        		document.body.appendChild(form);
        		form.submit();
        	
        		Swal.fire({
    				  title: '訂單付款',
    				  text: '付款頁面已開啟，請盡快付款。',
    				  icon: 'success',
    				  backdrop: false,
    			  }).then(function(){
    				  window.location.href = "../orderList";  	 
    	  		     });
	      		  
	  		     };
		});
	});
		



	


}
</script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>


</body>
</html>












