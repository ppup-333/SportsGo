<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>

/* #allproduct{ */

/* margin-top:-100px; */

/* } */


.title{
/* color:#2482e0; */
text-shadow: 2px 4px 3px rgba(0,0,0,0.2);
margin-top:20px;
font-size : 34px;
font-weight:bolder;
text-align: center;
}


.product {
	height: 424px;
	width: 274px;
	background-color: white; 
	margin: 70px;
	padding:10px;
	float: left;
    border: 2px #f0f0ef solid;
     margin-top:0px; 
    
}

.product:hover{
  color:#003C9D;
/*   background-color:#fff; */
  background-color: #f0feff;
  border: 2px navy solid;
}


.All2 {
		display:none;
}

.All {
	width: 1280px;
	margin: 0 auto;
	display:none;
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
  margin-top:15px;
}

.pnamehref{
  color:#2a2e32;
  text-decoration:none;
}

.pnamehref:hover{
  color:#5a636c;
  text-decoration:none;
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
/* float:right; */
/* min-height:80px; */
border: none;
  text-decoration: none;
  background-color: white;
  margin-left:1150px;
/*   margin-right:50px; */
/* margin-top:-10px; */
color:red;
font-weight: bolder;

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

/* display: inline-block;  */
/* margin-left:-25px; */
/* position: relative; */
/* top:-20px; */


.home{


}

</style>

<title>運動中心商城</title>
<!--引用css-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<!--引用SweetAlert2.js-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>

</head>
<body>

    <div class="All2">
	
	<c:import url="../../header.jsp" />
	
	<div class="All">

<p class="title">運動中心商城</p>

<!-- container-fluid -->
	<div id="mainDiv" class="container"> 
        <div class="row">
            <div id="imgDiv" class="col-12">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                      <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                      <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                      <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                      <div class="carousel-item active">
                        <img height='384' src="../images/store001.jpg" class="d-block w-100">
                      </div>
                      <div class="carousel-item">
                        <img width='576' height='384' src="../images/store002.jpg" class="d-block w-100">
                      </div>
                      <div class="carousel-item">
                        <img width='576' height='384' src="../images/store003.jpg" class="d-block w-100">
                      </div>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                      <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                      <span class="carousel-control-next-icon" aria-hidden="true"></span>
                      <span class="sr-only">Next</span>
                    </a>
                  </div>
            </div>
        </div>
    </div> <!--end of main--><br>


        
        

		<div id= "cart">

<!-- 			<p>&nbsp;</p> -->
			<a href="<c:url value='myShoppingCart' />" ><button class='cart'><img class="cartpic" src='../images/carticon.jpg' width='60' height='40'  /><div id="cartnn" style="display: inline-block; "><p class='cartNum' style="opacity:0.0;"></p></div></button></a>
			
				<br>
		
		</div>
		
		<hr>
        <div id="category">

        <a href="<c:url value='storeProductsAll?category=1'/> " ><button>健身用品</button></a>
        <a href="<c:url value='storeProductsAll?category=2'/> " ><button>服裝</button></a>
        <a href="<c:url value='storeProductsAll?category=3'/> " ><button>鞋類</button></a>
        <a href="<c:url value='storeProductsAll?category=4'/> " ><button>護具</button></a>
        <a href="<c:url value='storeProductsAll?category=5'/> " ><button>配件</button></a>
        <a href="<c:url value='storeProductsAll?category=6'/> " ><button>羽球</button></a>
        <a href="<c:url value='storeProductsAll?category=7'/> " ><button>籃球</button></a>
        <a href="<c:url value='storeProductsAll?category=8'/> " ><button>壁球</button></a>
        <a href="<c:url value='storeProductsAll?category=9'/> " ><button>桌球</button></a>
        <a href="<c:url value='storeProductsAll?category=10'/> " ><button>排球</button></a>
        <a href="<c:url value='storeProductsAll'/> " ><button>All</button></a><br>
        
        category = ${category}
        <input id="categoryI" type="hidden" value="${category}">

        </div>

<hr>
		<div id="allProduct"></div>
		
	</div>
	</div>

	<script type='text/javascript'>
	var category = document.getElementById("categoryI").value;
	console.log(category);
	
	if (category >= 1){
		//var category = ${category};
		//var category = document.getElementById("category");
		
		$(document).ready(xhrFunction);

		function xhrFunction(){
			var xhr = new XMLHttpRequest();
			xhr.open("POST","<c:url value='getProductsJson'/>",true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhr.send("category="+category);
			if(xhr!=null){
				xhr.onreadystatechange=function(){
					if(xhr.readyState==4&&xhr.status==200){
						testProducts(xhr.responseText);
						//displayProducts(xhr.responseText);					
					}					
				}
			}
		}
		
	}
	else{
		$(document).ready(xhrFunction0);
		function xhrFunction0(){
			var xhr = new XMLHttpRequest();
			xhr.open("POST","<c:url value='getProductsJson'/>",true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhr.send("category=0");
			if(xhr!=null){
				xhr.onreadystatechange=function(){
					if(xhr.readyState==4&&xhr.status==200){
						testProducts(xhr.responseText);
						//displayProducts(xhr.responseText);					
					}					
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

// 				 + "<a href='<c:url value='/'/>'><button class='home' >回到管理首頁</button></a>"
// 				 + "<a href='<c:url value='myShoppingCart'/>'><button class='cart'><img src='../images/carticon.jpg' width='60' height='40'  /><p id="cartNum" class='cartNum'>("+cartNum+")</p></button>";
	
	
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
// 	cart.innerHTML = cartcontent;
	if (cartNum != 0){
		cartcontent +="<p class='cartNum'>"+cartNum+"</p>" //""+cartNum+"";
		cartnn.innerHTML = cartcontent;
	}

	
	$(".All").show();
	$(".All2").show();
	

	
	
	
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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"
	type="text/javascript"></script>
</body>


</html>