<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
.product {
	height: 400px;
	width: 250px;
	background-color: white; 
	margin: 70px;
	padding:10px;
	float: left;
    border: 2px #f0f0ef solid;
}

.product:hover{
  color:#003C9D;
/*   background-color:#fff; */
  background-color: #f0feff;
  border: 2px navy solid;
}


.All {
	width: 1280px;
	margin: 0 auto;
}

.pname{
  height: 50px;
  font-size:18px;
  font-weight:bold;
  color:#2a2e32;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow:hidden;
  white-space: normal;
}

.pnamehref{
  color:#2a2e32;
  text-decoration:none;
}

.pnamehref:hover{
  color:#5a636c;
}

.price{
  font-size:18px;
  color:navy;
}

.pprice{
  font-size:22px;
  font-weight:bold;
  color:navy;

}

.addCart{
font-size:16px;
float: right;
width:100px;
height:40px;
border:0;
background-color:#003C9D;
color:#fff;
border-radius:10px;
cursor:pointer;
margin-top:5px;
margin-right:5px;

}

.addCart:hover{
/*   color:#003C9D; */
  background-color:#3072d9;
  border:4px #003C9D solid;
}

.stock{
  font-size:14px;
  color:grey;
  position: relative;
  top: 9px; 

}


.noStock{
font-size:16px;
float: right;
width:100px;
height:40px;
border:4px #de2621 solid;
background-color:red;
color:#fff;
border-radius:10px;
margin-top:5px;
margin-right:5px;

}

.cart{
float:right;


}

.home{


}


</style>

<script type='text/javascript'
	src="<c:url value='/' />/scripts/jquery-1.9.1.min.js"></script>

<title>運動中心商城</title>
<!--引用css-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<!--引用jQuery-->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"
	type="text/javascript"></script>
<!--引用SweetAlert2.js-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js"
	type="text/javascript"></script>

</head>
<body>


	<div class="All">
	
	   

        <div id="head"></div>
<!--  		<h2 style="text-align: center">運動中心商城</h2>  -->
<%-- 		<a href="<c:url value='/'/> " ><button>回到管理首頁</button></a><br> --%>


		<div id= "cart"></div>

		<hr>

		<div id="allProduct">
		</div>
		
<!-- 		<div id="allProducts" style="display:none" > -->
		<div id="allProducts" >
<!-- 			<div class="product"> -->
<!-- 				<a href='showAllProducts'><img width='250' height='250' src='picture/1'/></a> -->
<!-- 			<p class="pname" title='title123'><a class="pnamehref" href='showAllProducts'>勝利牌鳳凰級羽毛球- 12入</a></p> -->
<!-- 			<p class="price" >NT$ <span class='pprice'>100</span> -->
<!-- 			<button type="submit" class="addCart">加入購物車</button></p> -->
<!-- 			</div>	 -->
		</div>
	</div>

	<script type='text/javascript'>
	
	var allProducts = document.getElementById("allProducts");
	
		$(document).ready(xhrFunction);

		function xhrFunction(){
			//var tid = parseInt(typeSelect.value);
			var xhr = new XMLHttpRequest();
			xhr.open("GET","<c:url value='getProductsJson'/>",true);
			xhr.send();
			if(xhr!=null){
				xhr.onreadystatechange=function(){
					if(xhr.readyState==4&&xhr.status==200){
						testProducts(xhr.responseText);
						//displayProducts(xhr.responseText);					
					}					
				}
			}
		}

function testProducts(responseText){
	var mapData = JSON.parse(responseText);		
	var productList = mapData.productList;
	var content = "<br>";
	
	var cartNum = mapData.cartNum;
	var cartcontent = "";
	cartcontent += "<a href='<c:url value='/'/>'><button class='home'>回到管理首頁</button></a>"
				 + "<a href='<c:url value='myShoppingCart'/>'><button class='cart'>購物車("+cartNum+")</button>";
	
	head.innerHTML = "<h1 style='text-align: center'>運動中心商城</h1>";

	
	if(productList.length > 0){			

		for(var i=0; i < 6; i++){
			if (productList[i].product_stock >0) {
				content += "<form id='add' action='addCart' method='post'>"
						+"<div class='product'><a href='showAllProducts'>"
						+"<img width='250' height='250' src='picture/"+productList[i].product_id+"'/></a>"
						+"<p class='pname' title='"+productList[i].product_name+"'><a class='pnamehref' href='showAllProducts'>"+productList[i].product_name+"</a></p>"
						+"<p class='price'>NT$ <span class='pprice'>"+productList[i].product_price+"</span>"
						+"<input type='button' class='addCart' value='加入購物車' addCartId='"+productList[i].product_id
						+"' addCartName='"+productList[i].product_name+"' ></input>"
						+"<br><span class='stock'>庫存數量 : "+productList[i].product_stock+"</span></p>" 
						+"</div></form>";			
			}
			else {
				content += "<div class='product'><a href='showAllProducts'>"
						+"<img width='250' height='250' src='picture/"+productList[i].product_id+"'/></a>"
						+"<p class='pname' title='"+productList[i].product_name+"'><a class='pnamehref' href='showAllProducts'>"+productList[i].product_name+"</a></p>"
						+"<p class='price'>NT$ <span class='pprice'>"+productList[i].product_price+"</span>"
						+"<button class='noStock' disabled='disabled'>售完缺貨</button>"
						+"<br><span class='stock'>庫存數量 : "+productList[i].product_stock+"</span></p>" 
						+"</div>";	
				
			}
			
		}
		

	}else if(productList.length == 0){
		content = "<h3>沒有商品資料</h3>"; 
	}
	
	allProduct.innerHTML = content;
	cart.innerHTML = cartcontent;
	

	
	
	
	$('.addCart').click(function() {
		var id = $(this).attr('addCartId');
		var name = $(this).attr('addCartName');
		var json = {"addCartId" : id, "addCartName" : name};
		
		 $.ajax({
		        url: 'addCart',              // 要傳送的頁面
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
	
	
	
	
	

}
		
	
		

		
		
		
	</script>

</body>
</html>