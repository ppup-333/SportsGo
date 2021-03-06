<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../../headerScript.jsp" />
<meta charset="UTF-8">

<style>

.title{
/* color:#2482e0; */
/* text-shadow: 2px 4px 3px rgba(0,0,0,0.2); */
margin-top:20px;
font-size : 34px;
font-weight:bolder;
text-align: center;
}

.All {
	width: 1280px;
/* 	min-height:680px; */
	margin-left: 120px;
	display:none;
}

.All2 {

/* 	min-height:680px; */

}


table,th,td{
/* border: 1px black solid; */
font-size:16px;
}

.time{
text-align:center;
width:180px;
}

.product{
text-align:center;
width:180px;
}
.price{
text-align:center;
width: 90px;
}
.shipway{
text-align:center;
width: 90px;
}
.status{
text-align:center;
width: 90px;
}
.detail{
text-align:center;
width: 90px;
}

.cancel{
text-align:center;
width: 90px;
}


#orderlist{
/*    width: 830px; */
      width: 1000px;
/*    border: 1px black solid; */
   margin-top:30px;  
    margin-left:80px; 

   padding:10px 0px;
}
.order{
  margin-left:40px;
}

.listnum{
margin-top:20px;
text-align:center;
font-size:22px;
font-weight:bold;

}

.listnone{
font-size:24px;
font-weight:bold;

text-align:center;
}

#orderFooter{
   width: 600px;
/*    height:100px; */
   margin-top:30px;  
   margin-left:345px;
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

tr:hover {
background-color: #f5f5f5;
}


.detailBtn:hover{
border:1px #13db00 solid;
background-color: white;
border-radius:3px;
color: #05cc24;
}

.detailBtn{
border:1px green solid;
background-color: #05cc24  ;
border-radius:3px;
color:white;
}

.cancelBtn:hover{
border:1px red solid;
background-color: white;
border-radius:3px;
color:red;
}

.cancelBtn{
border:1px red solid;
background-color: red;
border-radius:3px;
color:white;
}

.cancelBtnDis{
border:1px #D4D4D4 solid;
background-color: #EDEDED;
border-radius:3px;
color:grey;
}



.table-hover tbody tr:hover td, .table-hover tbody tr:hover{
background-color: #d7e5f4;
}


</style>

<title>????????????</title>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>

</head>
<body>

<div id="head" style="display:none;"><c:import url="../../newheader.jsp" /></div>

<div class="All2">
<div class="All">

    <p id="title" class="title">????????????</p>
	
	<div id="orderlist">
	
	</div>


	<div id="orderNum"> </div>
	<div id="allOrder">
		
	</div>

	
	<div id="orderFooter">

	</div><br>
	
</div>
</div>
<script type='text/javascript'>

$(document).ready(xhrFunction);

function xhrFunction(){
	var xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='getOrderListJson'/>",true);
	xhr.send();
	if(xhr!=null){
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
				orderLists(xhr.responseText);		
			}					
		}
	}
}

function orderLists(responseText){
	var mapData = JSON.parse(responseText);	
	var content ='';
	var orderList = mapData.orderList;
	var orderDetail = mapData.orderDetail;
	var orderNumber = mapData.orderNumber;
	var account = mapData.account;
	var sumPrice=0;
	var fee = 0;
	
	
	if (account == "") {
		
// 		content= "<p class='listnone'>????????????????????????????????????</p>";
		orderNum.innerHTML = "<p class='listnone'>????????????????????????????????????</p>";
		
	}
	
	else if (orderList.length==0){
		
// 		content= "<p class='listnone'>????????????????????????????????????</p>";
		orderNum.innerHTML = "<p class='listnone'>????????????????????????????????????</p>";
		
	}
	
	else {
	content = "<table class='order table table-hover table-striped '><tr  class='table-primary' style='color:black;'>"
			+ "<th class='time'>????????????</th>"
			+ "<th class='product'>????????????</th>"
			+ "<th class='price'>????????????</th>"
			+ "<th class='shipway'>????????????</th>"
			+ "<th class='status'>????????????</th>"
			+ "<th class='detail'>????????????</th>"
			+ "<th class='cancel'>????????????</th></tr>";
				
	for(var i=0; i < orderList.length; i++){	
		content += "<tr><td class='time'>"+orderList[i].order_create_date+"</td>"
				 + "<td class='product'>"+orderList[i].name+" (??? "+orderNumber[i]+" ?????????)</td>"
				 + "<td class='price'>$"+orderList[i].order_price+"</td>"
				 + "<td class='shipway'>"+orderList[i].shipway+"</td>";
				 
				 if (orderList[i].order_status == "?????????"){
					 content += "<td class='status nopay'><span class='badge badge-warning' >"+orderList[i].order_status+"</span></td>";
				 }	 
				 else if (orderList[i].order_status == "?????????"){
					 content += "<td class='status paid'><span class='badge badge-primary' >"+orderList[i].order_status+"</span></td>";
				 }
				 else if (orderList[i].order_status == "?????????"){
					 content += "<td class='status canceled'><span class='badge badge-danger' >"+orderList[i].order_status+"</span></td>";
				 }
				 
				 
				 
				 content += "<td class='detail'><a href='orderDetail/"+orderList[i].order_id+"'><input class='detailBtn' type='button' value='??????'></td>"
				 
				 if (orderList[i].order_status == "?????????"){
					 content += "<td class='cancel'><input class='cancelBtnDis' cancelId='"+orderList[i].order_id+"' type='button' value='??????' disabled='disabled'></td></tr>"; 
				 } else {
					 content += "<td class='cancel'><input class='cancelBtn' cancelId='"+orderList[i].order_id+"' type='button' value='??????'></td></tr>";
				 }
	}
	content+="</table>";
	
	orderNum.innerHTML = "<p class='listnum'>??? "+orderList.length+" ?????????</p>";
	
	title.innerHTML = account+"???????????????";
	
	}
	
	contentfoot ="<a href='<c:url value='/'/>'><input class='home' type='button' value='????????????'/></a>&nbsp;&nbsp;&nbsp;&nbsp;"
				+"<a href='<c:url value='../storeProductsAll'/>'><input class='home' type='button' value='????????????'/></a>&nbsp;&nbsp;&nbsp;&nbsp;";

	orderlist.innerHTML = content;
	orderFooter.innerHTML = contentfoot;
	$(".All").show();
	$("#head").show();
	$("#foot").show();
		

	$('.cancelBtn').click(function() {
		Swal.fire({ 
	      	  title: '????????????', 
	      	  text: '?????????????????????????', 
	      	  icon: 'question',
	      	  showCancelButton: true, 
	      	  confirmButtonColor: '#3085d6',
	      	  cancelButtonColor: '#d33',
	      	  confirmButtonText: '??????',
	      	  cancelButtonText: 'NO',
	      	  backdrop: false,
	      	  }).then(result => {
	      		  if (result.value) {
	      			var id = $(this).attr('cancelId');
	      			var json = {"cancelId" : id};      			
	      			 $.ajax({
	      			        url: 'cancelOrder',              // ??????????????????
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
	      				    		    title: '??????????????????',
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
	      				    		    title: '????????????',
	      				    		    text: "ERROR!",
	      				    		})
	      			            	
	      			            }
	      			            
	      			        },
	      			        error: function(response) {
	      			            alert("error");
	      			        }
	      			    });
	      			 }
	      		  });
		});
		
	


}
</script>
<div id="foot" style="display:none;"><c:import url="../../footer.jsp"/>	</div>
</body>
</html>