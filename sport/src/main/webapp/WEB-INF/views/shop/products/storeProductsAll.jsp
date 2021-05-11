<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../../headerScript.jsp" />
<meta charset="UTF-8">

<style>




.All2 {
 	display:none; 
 	
}

.All {
	width: 1280px;
	margin: 0 auto;
 	display:none; 
}



#allProduct{ 
	margin: 0 auto;
	margin-left:20px;
/*  min-height:900px;  */
/* text-align: center; */
 } 

#pages{
	margin: 0 auto;
/* margin-left:300px; */
height: 50px;
width: 600px;
/* border: 2px blue solid; */
margin-top:500px;
font-size: 24px;
/* letter-spacing:10px; */
}

.pagging{
text-align: center;

}


#pageN{

position: relative;
margin:5px;

 -webkit-border-radius: 4px;
 -moz-border-radius: 4px;
 border-radius: 20px;
 background-color: #8da7fc;

 color: #fff;
/*  display: block; */
/*  float: left; */
 height: 25px;
 width:25px;
 padding: 3px 13px 3px 13px;
 text-align: center;
 vertical-align: top;
}

#pageNC{

position: relative;
margin:5px;

 -webkit-border-radius: 4px;
 -moz-border-radius: 4px;
 border-radius: 20px;
 background-color: #ff5142;

 color: #fff;
/*  display: block; */
/*  float: left; */
 height: 25px;
 width:25px;
 padding: 3px 13px 3px 13px;
 text-align: center;
 vertical-align: top;
}


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
    overflow:hidden; 
    
}

.product:hover{
  color:#003C9D;
/*   background-color:#fff; */
  background-color: #f0feff;
  border: 2px navy solid;
}


.product img{
transform:scale(1,1);transition: all 0.3s ease-out;
}

.product img:hover{
transform:scale(1.1,1.1);
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

.addCart:hover{
/*   color:#003C9D; */
  background-color:#3072d9;
  border:3px #003C9D solid;
   box-shadow:1px 1px 2px grey  ;
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

#cart{
height:120px;

}


.cart{
border: none;
text-decoration: none;
background-color: white;
color:red;
font-weight: bolder; 
/* margin-left:1150px; */
/* margin-top:-25px; */

  position:fixed;
/* 　top:1280px; */
  right: 45px;
  top:115px;

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

.searchBar{
position: relative;
top:30px;
 width:650px;
 margin-left:400px;
}

.key{
 width:250px;
}

#searchResult{
 text-align: center;
 font-size: 22px;
 font-weight: bold;
}
.category{

}

.categoryButton{
background-color: #8da7fc   ;
margin:7px;
width:180px;
height:50px;
font-size:22px;
color:white;
margin-left:55px;
 border-radius: 25px;
 border:2px white solid; 
 
}

.categoryButton:hover{
background-color: #3869f0   ;
box-shadow:1px 1px 2px grey  ;
width:180px;
height:50px;
font-size:22px;
color:white;
/*  border:2px #4400f5 solid; */
}


.allButton{
background-color: #4f674c  ;
margin:7px;
width:180px;
height:50px;
font-size:22px;
 color:white; 
position:relative;
top:70px;
margin-left:55px;
  border-radius: 25px; 
/*  border:2px #211c4f solid; */
 box-shadow:1px 1px 2px grey  ;
  border:2px white solid; 
 
}





</style>

<title>運動中心商城</title>
<!--引用css-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<!--引用SweetAlert2.js-->	

<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>

<!-- <script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script> -->

</head>
<body>

    
	<c:import url="../../newheader.jsp" />
<div class="All2">
	
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
    </div> <!--end of main-->


        
        

		<div id= "cart">
		 <a href="<c:url value='storeProductsAll?keyword=${keyword}'/> " ><button class="allButton"><i class="fas fa-tags"> &nbsp; 所有商品</i></button ></a>
		
		<p class="searchBar">請輸入商品名稱：<input id="keywordI" type="text" name="keyword" class="key" required="required" value="${keyword}">
	<button id="search" > 搜尋</button> <c:if test="${!empty keyword}" ><button id="unSearch" > 清除搜尋結果</button> </c:if>
	<input type='hidden' name='status' value='${status}'>
	<input type='hidden' name='category' value='${category}'></p>

				<div class="cart"><a href="<c:url value='myShoppingCart' />" ><img class="cartpic" src='../images/carticon.jpg' width='60' height='40'  /><span id="cartnn" style="display: inline-block; "><p class='cartNum' style="opacity:0.0;"></p></span></a></div>

<%-- 			<a href="<c:url value='myShoppingCart' />" ><button class='cart'><img class="cartpic" src='../images/carticon.jpg' width='60' height='40'  /><div id="cartnn" style="display: inline-block; "><p class='cartNum' style="opacity:0.0;"></p></div></button></a> --%>
			
				<br>
		
		</div>
		
		<hr>
        <div id="category">

        <a href="<c:url value='storeProductsAll?category=1&keyword=${keyword}'/> " ><button id="bn1" class="categoryButton"><i class="fas fa-dumbbell"> &nbsp; 健身</i></button></a>
        <a href="<c:url value='storeProductsAll?category=2&keyword=${keyword}'/> " ><button id="bn2" class="categoryButton"><i class="fas fa-tshirt"> &nbsp; 服裝</i></button></a>
        <a href="<c:url value='storeProductsAll?category=3&keyword=${keyword}'/> " ><button id="bn3" class="categoryButton"><i class="fas fa-shoe-prints"> &nbsp; 鞋類</i></button></a>
        <a href="<c:url value='storeProductsAll?category=4&keyword=${keyword}'/> " ><button id="bn4" class="categoryButton"><i class="fas fa-user-shield"> &nbsp; 護具</i></button></a>
        <a href="<c:url value='storeProductsAll?category=5&keyword=${keyword}'/> " ><button id="bn5" class="categoryButton"><i class="fas fa-toolbox"> &nbsp; 配件</i></button></a><br>
        <a href="<c:url value='storeProductsAll?category=6&keyword=${keyword}'/> " ><button id="bn6" class="categoryButton"><i class="fas fa-feather"> &nbsp; 羽球</i></button></a>
        <a href="<c:url value='storeProductsAll?category=7&keyword=${keyword}'/> " ><button id="bn7" class="categoryButton"><i class="fas fa-basketball-ball"> &nbsp; 籃球</i></button></a>
        <a href="<c:url value='storeProductsAll?category=8&keyword=${keyword}'/> " ><button id="bn8" class="categoryButton"><i class="fas fa-circle"> &nbsp; 壁球</i></button></a>
        <a href="<c:url value='storeProductsAll?category=9&keyword=${keyword}'/> " ><button id="bn9" class="categoryButton"><i class="fas fa-table-tennis"> &nbsp; 桌球</i></button></a>
        <a href="<c:url value='storeProductsAll?category=10&keyword=${keyword}'/> " ><button id="bn10" class="categoryButton"><i class="fas fa-volleyball-ball"> &nbsp; 排球</i></button></a>
       <br>
        
<%--         category = ${category} --%>
<%--         keyword = ${keyword} --%>
<%--         category_list = ${productCategoryList[category].name} --%>

        <input id="categoryI" type="hidden" value="${category}">
        <input id="keyword2" type="hidden" value="${keyword}">
        <input id='pageI' type='hidden' value='${page}'>

        </div>

<hr>
		<c:if test="${!empty keyword}" >
			<c:if test="${!empty category}" >
				<div id="searchResult" class="searchResult">
					【 ${productCategoryList[category-1].name} 】的分類下<br>
					關鍵字" ${keyword} "的相關商品 共有 <span id = "result"></span> 個結果
				</div>	
			</c:if>
			<c:if test="${empty category}">
				<div id="searchResult" class="searchResult">
					關鍵字" ${keyword} "的相關商品 共有 <span id = "result"></span> 個結果
				</div>
			</c:if>
		</c:if>
		<c:if test="${empty keyword}" >
			<c:if test="${!empty category}" >
				<div id="searchResult" class="searchResult">
					【 ${productCategoryList[category-1].name} 】分類下 共有 <span id = "result"></span> 個商品
				</div>	
			</c:if>
			<c:if test="${empty category}">
				<div id="searchResult" class="searchResult">
					總共有 <span id = "result"></span> 個商品
				</div>	
			</c:if>
		</c:if>

		<div id="allProduct"></div>
		
		
		<div id="pages"></div>
		
	</div>
	</div>

	<script type='text/javascript'>
	var category = document.getElementById("categoryI").value;
	var keywordI = document.getElementById("keywordI");
	var keyword="";
	var keyword2 = document.getElementById("keyword2");
	var page = document.getElementById("pageI").value;
	
		$(document).ready(xhrFunction);
	
		$("#search").click(function() {
			keyword = keywordI.value;
			if (keyword ==""){
				Swal.fire({
	    		    toast: true,
	    		    position: 'top',
	    		    showConfirmButton: false,
	    		    timer: 2000,
	    		    icon: 'error',
	    		    title: '請輸入關鍵字!',
	    		})
			} else {
				self.location.href='storeProductsAll?category='+category+'&keyword='+keyword;
				//xhrFunction();
			}
		});
		
		$("#unSearch").click(function() {
			keyword = '';
			self.location.href='storeProductsAll?category='+category+'&keyword='+keyword;
		});
		

		function xhrFunction(){
			keyword = keyword2.value;
			page = document.getElementById("pageI").value;
			var xhr = new XMLHttpRequest();
			xhr.open("POST","<c:url value='getProductsJson'/>",true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			console.log("keyword = "+keyword);
			console.log("category = "+category);
			console.log("page = "+page);
			if (category >= 1){
					xhr.send("category="+category+"&keyword="+keyword+"&page="+page); //+"&keyword="+keyword
			}
			else {
					xhr.send("category=0&keyword="+keyword+"&page="+page);
			}
			
			if(xhr!=null){
				xhr.onreadystatechange=function(){
					if(xhr.readyState==4&&xhr.status==200){
						testProducts(xhr.responseText);				
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
	
	var proNum = mapData.proNum;
	var pageTimes = mapData.pageTimes;
	var startRow = mapData.startRow;
	var pageSize = mapData.pageSize;
	var currentPage = mapData.currentPage;
	var contentPage = "";

	if(productList.length > 0){			
		if(currentPage == pageTimes){
			pageSize = productList.length-1;
		}
		for(var i=startRow; i <= pageSize; i++){
			if (productList[i].product_stock >0) {
				content += ""
						+"<div class='product'><a href='storeProduct/"+productList[i].product_id+"'>"
						+"<img width='250' height='250' src='picture/"+productList[i].product_id+"'/></a>"
						+"<p class='pname' title='"+productList[i].product_name+"'><a class='pnamehref' href='storeProduct/"+productList[i].product_id+"'>"+productList[i].product_name+"</a></p>"
						+"<p class='price'>NT$ <span class='pprice'>"+productList[i].product_price+"</span>"		
						+"<button class='addCart' addCartId='"+productList[i].product_id
						+"' addCartName='"+productList[i].product_name+"' ><i class='fas fa-cart-plus'> 加入購物車</i></button>"  //
						
						+"<br><span class='stock'>庫存數量 : "+productList[i].product_stock+"</span></p>" 
						+"</div>";	

			}
			else {
				content += "<div class='product'><a href='storeProduct/"+productList[i].product_id+"'>"
						+"<img width='250' height='250' src='picture/"+productList[i].product_id+"'/></a>"
						+"<p class='pname' title='"+productList[i].product_name+"'><a class='pnamehref' href='storeProduct/"+productList[i].product_id+"'>"+productList[i].product_name+"</a></p>"
						+"<p class='price'>NT$ <span class='pprice'>"+productList[i].product_price+"</span>"
						+"<button class='noStock' disabled='disabled'>售完缺貨</button>"
						+"<br><span class='stock'>庫存數量 : "+productList[i].product_stock+"</span></p>" 
						+"</div>";	
			}	
		}
	}else if(productList.length == 0){
		content = "<br><br><h3>沒有商品資料</h3>"; 
	}
	

	contentPage = "<br><br><div class='pagging'>";
	if(currentPage == 1) {
		contentPage += "<span class='disabled' ><i class='fas fa-arrow-circle-left'></i></span>&nbsp;";
	}
	if(currentPage != 1) {
		contentPage += "<a href='storeProductsAll?category="+category+"&keyword="+keyword+"&page="+(currentPage-1)+"'><i class='fas fa-arrow-circle-left'></i></a>&nbsp;";
	}
	if(currentPage == 1) {
		contentPage += "<span class='current' id='pageNC'>1</span>";
	}
	if(currentPage != 1) {
		contentPage += "<a href='storeProductsAll?category="+category+"&keyword="+keyword+"&page=1'><span id='pageN'>1<span></a>";
	}
	
	for (var i=1; i<pageTimes; i++) {
		page = i+1;
		
		if(currentPage == page) {
			contentPage += "<span class='current' id='pageNC'>"+page+"</span>";
		}
		if(currentPage != page) {
			contentPage += "<a href='storeProductsAll?category="+category+"&keyword="+keyword+"&page="+page+"'><span id='pageN'>"+page+"</span></a>";
		}
	}
	
	if(currentPage == pageTimes) {
		contentPage += "&nbsp;<span class='disabled'><i class='fas fa-arrow-circle-right'></i></span>";
	}
	if(currentPage != pageTimes) {
		contentPage += "&nbsp;<a href='storeProductsAll?category="+category+"&keyword="+keyword+"&page="+(currentPage+1)+"'><i class='fas fa-arrow-circle-right'></i></a>";
	}
	contentPage +="</div><br><br>";

	
	allProduct.innerHTML = content;
	pages.innerHTML = contentPage;

	if (cartNum != 0){
		cartcontent +="<p class='cartNum'>"+cartNum+"</p>" //""+cartNum+"";
		cartnn.innerHTML = cartcontent;
	}
	
	$("#bn"+category).css('background-color', '#fe802f');
	$("#bn"+category).css('box-shadow', '1px 1px 2px grey '); //box-shadow:1px 1px 2px grey  ;
	result.innerHTML = productList.length;
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
<!-- <script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script> -->

<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->

<!-- <script src="http://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->

<!--  <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>  -->


</body>


</html>