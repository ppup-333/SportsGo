<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../../headerScript.jsp" />
<meta charset="UTF-8">

<style>


a {
    text-decoration:none;
}

.All2 {
  position: relative;
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
 	min-height: 300px;
 	overflow:auto;
 } 

#pages{
/* 	margin: 0 auto; */
/* margin-left:300px; */
/* position:absolute; */
/* margin-bottom:0px; */
height: 50px;
width: 850px;
/* border: 2px blue solid; */
/* margin-top:500px; */
font-size: 24px;
text-align: center;
/* letter-spacing:10px; */
}

.pagging{
/* position:absolute; */
/*  width:1280px;  */
margin-left:433px;
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

#pageN:hover{


 background-color: #6671e5   ;
   box-shadow:1px 1px 2px grey  ;
 color: #fff;

}

#pageNC{

position: relative;
margin:5px;

 -webkit-border-radius: 4px;
 -moz-border-radius: 4px;
 border-radius: 20px;
 background-color: #4218aa   ;
 box-shadow:1px 1px 1px grey  ;

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
/* text-shadow: 2px 4px 3px rgba(0,0,0,0.2); */
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
/*     overflow:hidden;  */
    
}

.product:hover{
  color:#003C9D;
/*   background-color:#fff; */
  background-color: #f0feff;
  border: 2px navy solid;
}

.productNone {
	height: 424px;
	width: 274px;
	background-color: white; 
	margin: 70px;
	padding:10px;
	float: left;

    margin-top:0px; 
    overflow:hidden; 
    
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
  color:#828c97;
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
  background-color:#5793ef;
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
font-weight:bold;
float: right;
width:130px;
height:40px;
border:2px #de2621 solid;
background-color:red;
color:#fff;
border-radius:10px;
margin-top:20px;
margin-right:0px;

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
/* ???top:1280px; */
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
background-color: #72ec69   ;
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

.allButton:hover{
background-color: #23b418  ;
 color:white;
 border-radius: 25px; 
 box-shadow:1px 1px 2px grey  ;
 border:2px white solid; 
 
}



.noProduct{


text-align: center;
font-size: 28px;
font-weight: bold;


}



</style>

<title>??????????????????</title>
<!--??????css-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
<!--??????SweetAlert2.js-->	

<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>

</head>
<body>
<div class="All2">
<c:import url="../../newheader.jsp" />


	
<div class="All">

<p class="title">??????????????????</p>

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
		 <a href="<c:url value='storeProductsAll?keyword=${keyword}'/> " ><button class="allButton"><i class="fas fa-tags"> &nbsp; ????????????</i></button ></a>
		
		<nav class="navbar navbar-light" style="width:600px;background-color: #e3f2fd; margin-left:340px; margin-top:12px;   border-radius: 25px;  ">
		
		???<span style="color: #123456; font-weight:bold; margin-left:0px;" >????????????????????????</span><input id="keywordI" class="key form-control mr-sm-2" aria-label="Search" placeholder="Search" type="text" name="keyword" required="required" value="${keyword}" >

		  <button id="search" class="btn btn-outline-success my-2 my-sm-0" <c:if test="${empty keyword}"> style=" margin-right:82px;" </c:if> > ??????</button> <c:if test="${!empty keyword}" ><button id="unSearch" class="btn btn-outline-secondary" style=" margin-right:15px;" > ??????</button> </c:if>
		
		
		
<%-- 		<p class="searchBar">????????????????????????<input id="keywordI" type="text" name="keyword" class="key" required="required" value="${keyword}"> --%>
		
<%-- 			<button id="search" > ??????</button> <c:if test="${!empty keyword}" ><button id="unSearch" > ??????????????????</button> </c:if> --%>
			<input type='hidden' name='status' value='${status}'>
			<input type='hidden' name='category' value='${category}'>
<!-- 			</p> -->
			
		</nav>
		
		<div class="cart"><a href="<c:url value='myShoppingCart' />" ><img class="cartpic" src='../images/carticon.jpg' width='60' height='40'  /><span id="cartnn" style="display: inline-block; "><p class='cartNum' style="opacity:0.0;"></p></span></a></div>
		<br>	
	</div>
		
		<hr>
        <div id="category">

        <a href="<c:url value='storeProductsAll?category=1&keyword=${keyword}'/> " ><button id="bn1" class="categoryButton"><i class="fas fa-dumbbell" style="width:95px;">&nbsp;&nbsp;??????</i></button></a>
        <a href="<c:url value='storeProductsAll?category=2&keyword=${keyword}'/> " ><button id="bn2" class="categoryButton"><i class="fas fa-tshirt" style="width:95px;">&nbsp;&nbsp;??????</i></button></a>
        <a href="<c:url value='storeProductsAll?category=3&keyword=${keyword}'/> " ><button id="bn3" class="categoryButton"><i class="fal fa-boot" style="width:95px;font-weight:bold;">&nbsp;&nbsp;&nbsp;??????</i></button></a>
        <a href="<c:url value='storeProductsAll?category=4&keyword=${keyword}'/> " ><button id="bn4" class="categoryButton"><i class="fas fa-user-shield" style="width:95px;">&nbsp;&nbsp;??????</i></button></a>
        <a href="<c:url value='storeProductsAll?category=5&keyword=${keyword}'/> " ><button id="bn5" class="categoryButton"><i class="fas fa-toolbox" style="width:95px;">&nbsp;&nbsp;??????</i></button></a><br>
        <a href="<c:url value='storeProductsAll?category=6&keyword=${keyword}'/> " ><button id="bn6" class="categoryButton"><i class="fal fa-shuttlecock" style="font-weight:bold;">&nbsp;&nbsp;&nbsp;??????</i></button></a>
        <a href="<c:url value='storeProductsAll?category=7&keyword=${keyword}'/> " ><button id="bn7" class="categoryButton"><i class="fas fa-basketball-ball" style="width:95px;">&nbsp;&nbsp;&nbsp;??????</i></button></a>
        <a href="<c:url value='storeProductsAll?category=8&keyword=${keyword}'/> " ><button id="bn8" class="categoryButton"><i class="fas fa-circle" style="width:95px;">&nbsp;&nbsp;&nbsp;??????</i></button></a>
        <a href="<c:url value='storeProductsAll?category=9&keyword=${keyword}'/> " ><button id="bn9" class="categoryButton"><i class="fas fa-table-tennis" style="width:95px;">&nbsp;&nbsp;&nbsp;??????</i></button></a>
        <a href="<c:url value='storeProductsAll?category=10&keyword=${keyword}'/> " ><button id="bn10" class="categoryButton"><i class="fas fa-volleyball-ball" style="width:95px;">&nbsp;&nbsp;??????</i></button></a>
        <br>
        
        <input id="categoryI" type="hidden" value="${category}">
        <input id="keyword2" type="hidden" value="${keyword}">
        <input id='pageI' type='hidden' value='${page}'>

        </div>
		<hr>
		
		<c:if test="${!empty keyword}" >
			<c:if test="${!empty category}" >
				<div id="searchResult" class="searchResult">
					??? ${productCategoryList[category-1].name} ???????????????<br>
					?????????" ${keyword} "??????????????? ?????? <span id = "result"></span> ?????????
				</div>	
			</c:if>
			<c:if test="${empty category}">
				<div id="searchResult" class="searchResult">
					?????????" ${keyword} "??????????????? ?????? <span id = "result"></span> ?????????
				</div>
			</c:if>
		</c:if>
		<c:if test="${empty keyword}" >
			<c:if test="${!empty category}" >
				<div id="searchResult" class="searchResult">
					??? ${productCategoryList[category-1].name} ???????????? ?????? <span id = "result"></span> ?????????
				</div>	
			</c:if>
			<c:if test="${empty category}">
				<div id="searchResult" class="searchResult">
					????????? <span id = "result"></span> ?????????
				</div>	
			</c:if>
		</c:if>

		<div id="allProduct"></div>
		
		
		<div id="pages"></div>
		<hr>
		
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
	    		    title: '??????????????????!',
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
	var flag = 0;

	if(productList.length > 0){			
		if(currentPage == pageTimes){
			pageSize = productList.length-1;
			flag = 1;
		}
		for(var i=startRow; i <= pageSize; i++){
			
				content += "<div class='product'><a href='storeProduct/"+productList[i].product_id+"'>"
						 + "<img width='250' height='250' src='picture/"+productList[i].product_id+"'/></a>"
						 + "<p class='pname' title='"+productList[i].product_name+"'><a class='pnamehref' href='storeProduct/"+productList[i].product_id+"'>"+productList[i].product_name+"</a></p>"
						 + "<p class='price'>NT$ <span class='pprice'>"+productList[i].product_price+"</span>";
						
						if (productList[i].product_stock >0) {
							content += "<button class='addCart' addCartId='"+productList[i].product_id
									 + "' addCartName='"+productList[i].product_name+"' ><i class='fas fa-cart-plus'> ???????????????</i></button>";
						} else {
							content += "<button class='noStock' disabled='disabled' style='cursor:not-allowed;'>????????????</button>";
						}
						
						 content += "<br><span class='stock'>???????????? : "+productList[i].product_stock+"</span></p>"
						 		   + "</div>";	
			}
		if(flag ==1 && productList.length %3 == 1) {
			content += "<div class='productNone'></div>";
			
		}
		


	} else if(productList.length == 0){
		content = "<p class='noProduct'><br><br>????????????????????????</p>"; 
	}
	

	contentPage = "<div class='pagging'>";
	if(currentPage == 1) {
		contentPage += "<span class='disabled' ><i class='fas fa-arrow-circle-left' ></i></span>&nbsp;";
	}
	if(currentPage != 1) {
		contentPage += "<a href='storeProductsAll?category="+category+"&keyword="+keyword+"&page="+(currentPage-1)+"'><i class='fas fa-arrow-circle-left'></i></a>&nbsp;";
	}
	if(currentPage == 1) {
		contentPage += "<span class='current' id='pageNC'>1</span>";
	}
	if(currentPage != 1) {
		contentPage += "<a style='text-decoration:none;' href='storeProductsAll?category="+category+"&keyword="+keyword+"&page=1'><span id='pageN'>1<span></a>";
	}
	
	for (var i=1; i<pageTimes; i++) {
		page = i+1;
		
		if(currentPage == page) {
			contentPage += "<span class='current' id='pageNC'>"+page+"</span>";
		}
		if(currentPage != page) {
			contentPage += "<a style='text-decoration:none;' href='storeProductsAll?category="+category+"&keyword="+keyword+"&page="+page+"'><span id='pageN'>"+page+"</span></a>";
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
	$("#foot").show();
	$("#head").show();

	
	$('.addCart').click(function() {
		var id = $(this).attr('addCartId');
		var name = $(this).attr('addCartName');
		var json = {"addCartId" : id, "addCartName" : name};
		
		 $.ajax({
		        url: 'addCart',              // ??????????????????
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
			    		    text: "??????????????????!",
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

<div id="foot" style="display:none;"><c:import url="../../footer.jsp"/>	</div>
</body>


</html>