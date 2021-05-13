<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../../headerScript.jsp" />
<meta charset="UTF-8">

<style type="text/css">

.title{
  margin-top:20px;
  font-size : 34px;
  font-weight:bolder;
  text-align: center;
}

.All {
  width: 1280px;
/*   min-height:680px; */
  margin-left: 120px;
  display:none;
}

.All2 {
/*   min-height:800px; */
}

.pname{
  margin-left: 15px;
}
.pname2{
  font-weight: bold; 
  font-size:16px;
  overflow:hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}

.pprice{
  text-align:center;
}
.pnumber{
  text-align:center;
}
.psum{
  text-align:center;
  font-weight: bolder;
}

#orderDetailList{
  width: 980px;
  margin:auto;
  padding:10px 0px;
}

.order{
}

#orderPriceZone{
  width: 980px;
  margin-top:-30px;
  margin-left: 280px;
}
.listNum{
  margin-top:10px;
  margin-left:568px; 
  font-size: 16px;
  font-weight: bold;
}

.ship{
  margin-top:-10px;
  margin-left:692px;
  font-size: 16px;
  font-weight: bold;
  color: #96989c;
}

.sumPrice{
  margin-top:-10px;
  margin-left:660px;
  font-size: 16px;
  font-weight: bold;
}

.sumPricec{
  display: inline-block;
  font-size: 20px;
  font-weight: bold;
  color: red;
}

#orderFooter{
   width: 600px;
/*    height:100px; */
   margin-top:30px;  
   margin-left:340px;
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

hr.s2 {
  border: 0;
  height: 3px;
  background-image: linear-gradient(to right, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.75), rgba(0, 0, 0, 0));
}

#orderBuyer{
  width: 500px;
  min-height:100px;
  margin-top:0px;  
  margin-left:380px;
  padding:10px 0px;
  text-align: center;
}

.buyerData{
  width:500px;
  margin-top:30px; 
  padding:10px;
  background-color: #fffff5;
  box-shadow:0px 0px 5px grey  ;
}

 .buyer{
 font-size:22px;
 font-weight:bold;
 }

#Box1{
float:left;
font-weight: bold;
}

.nameI{
  font-size: 18px;
  font-weight: bold;
  color: black;
  display: inline-block; 
  margin-top:10px; 
  margin-left:45px;
  margin-bottom:10px;
  height:18px;
}

.nameII{
  font-size: 18px;
  font-weight: bold;
  color: #1c548d;
}



</style>


<title>訂單明細</title>


</head>

<body>

<div id="head" style="display:none;"><c:import url="../../newheader.jsp" /></div>

<div class="All2">
<div class="All">

<input type='hidden' id='order_Id' value='${order_Id}'>



	    <p class="title">訂單明細內容</p>


	<div id="orderDetailList">

	</div>
	
	<div id="orderPriceZone">
	
	</div>
	
	<div id="orderBuyer">
		<div class="buyerData">
		<p class="buyer">訂購資料</p><hr class="s2">
		
				<table class="buy0">
					
					<tr><td><div id="Box1"><span class="nameI">					
						姓名 :&nbsp;</span><span  class="nameII" id="bName"></span></div></td></tr>

					<tr><td><div id="Box1"><span class="nameI" >
						電話 :&nbsp;</span><span class="nameII" id="bTel"></span></div></td></tr>
					
					<tr><td><div id="Box1"><span class="nameI" >
						運送方式 :&nbsp;</span><span class="nameII" id="bShipway"></span></div></td></tr>
    
					<tr class="address"><td><div id="Box1"><span class="nameI" >
						地址 :&nbsp;</span><span class="nameII" id="bAddress"></span></div></td></tr>
					
					<tr><td><div id="Box1"><span class="nameI" >
						運費 :&nbsp;</span><span class="nameII" id="bShip"></span></div></td></tr>
					
					<tr><td><div id="Box1"><span class="nameI" >
						訂單總金額 :&nbsp;</span><span class="nameII" id="bPrice"></span></div></td></tr>
						
					<tr><td width="500px"><hr class="s2"></td></tr>
					
				</table>

		</div>
	</div>




	<div id="orderFooter">

	</div><br>
	
</div>
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


	content = "<table class='order table  table-striped'><tr class='table-primary' style='color:black;'>"
			+ "<th class='pname'>&nbsp;商品名稱</th>"
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
	content+="</table><hr>";

	var contentPrice = "<p class='listNum'>共 "+listnum+" 件商品&emsp;金額小計 : $ "+sumprice+""
	         		 + "<p class='ship'>+ 運費 : $ "+orderList.ship+"</p>"
	         		 + "<p class='sumPrice'>結帳總金額 : <span class='sumPricec'> $ "+orderList.order_price+"</span></p><hr class='s2' width='300px' style='margin-left:580px; margin-top:-10px;'>";
	
	contentmain="";
	
	contentfoot ="<a href='../orderList'><input class='continue' type='button' value='回訂單列表'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
				+"<a href='<c:url value='/'/>'><input class='home' type='button' value='回到首頁'/></a>&nbsp;&nbsp;&nbsp;&nbsp;";
				
	if (orderList.order_status =="未付款"){
		contentfoot += "<input class='payBill' type='button' value='付款'/><br><br>";
	}

	orderDetailList.innerHTML = content;
	orderPriceZone.innerHTML = contentPrice;
	
	bName.innerHTML = ""+orderList.name+"";
	bTel.innerHTML = ""+orderList.tel+"";
	bAddress.innerHTML = ""+orderList.address+"";
	bShipway.innerHTML = ""+orderList.shipway+"";
	bShip.innerHTML = "$ "+orderList.ship+" 元";
	bPrice.innerHTML = "$ "+orderList.order_price+" 元";
	
	orderFooter.innerHTML = contentfoot;
	$(".All").show();
	$("#foot").show();
	$("#head").show();
	
	$('.payBill').click(function() {
		Swal.fire({ 
	      	  title: '訂單付款', 
	      	  text: '是否進行付款?', 
	      	  icon: 'question',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '付款GO!',
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
<div id="foot" style="display:none;"><c:import url="../../footer.jsp"/></div>
</body>
</html>
