<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<c:import url="../../headerScript.jsp" />
<meta charset="UTF-8">

<style>

.title{
/* text-shadow: 2px 4px 3px rgba(0,0,0,0.2); */
margin-top:20px;
font-size : 34px;
font-weight:bolder;
text-align: center;
}


#remark{
        width:180px;
        height:auto;

        display: -webkit-box;
        -webkit-line-clamp:3;
        -webkit-box-orient:vertical;
        overflow:hidden;
        white-space:pre-wrap;
        text-overflow:ellipsis;
}
form{
margin:0px; display:inline
}

.productlist{
width:1280px;
mar
}

.pnum{
width:60px;
text-align: center;
}

.pname{
width:250px;
text-align: center;
}

.pcat{
width:60px;
text-align: center;
}
.pprice{
width:60px;
text-align: center;
}
.pstock{
width:60px;
text-align: center;
}
.premark{
width:180px;
text-align: center;
}
.pstatus{
width:80px;
text-align: center;
}
.pcreatetime{
width:110px;
text-align: center;
}
.pupdatetime{
width:110px;
text-align: center;
}
.pimg{
width:90px;
text-align: center;
}
.pcrud{
width:150px;
text-align: center;

}



.table-hover tbody tr:hover td, .table-hover tbody tr:hover{
background-color: #d7e5f4;
}

.pagging{
margin-top:60px;
margin-bottom:30px;
}


.productNone{
min-height: 180px;
}

.noneContent{
font-size: 20px;
font-weight: bold;
}



</style>


<title>商品一覽</title>

    

  
</head>
<body>

	<div id="head" style="display:none;"><c:import url="../../newheaderM.jsp" /></div>

<div id="All" align='center' style="display:none;">
 <p class="title">商品資料後台管理</p>
<%-- <a class='create' href='pro/${currentPage}?status=${status}&category=${category}'><button>新增商品</button></a> --%>
<%-- <a href="<c:url value='/shopHome'/> " ><button>回到管理首頁</button></a><br> --%>


	<c:if test="${category!=null&&category>0}" ><p>【${productCategoryList[category-1].name}】的分類中</p></c:if>
<c:choose>
	<c:when test="${status == '0'}">
		<p>目前總共有 ${prodNum} 筆商品為下架狀態</p>
	</c:when>
	<c:when test="${status == '1'}">
		<div id="prodOff"><p>目前總共有 ${prodNum} 筆商品為上架狀態</p></div>
	</c:when>
	<c:when test="${status == '' || status==null}">
		<div><p>目前總共有 ${prodNum} 筆商品</p></div>
	</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>


<%-- <form method="post" id='form4' action="<c:url value='/' />shop/showAllProducts" > --%>
<!-- <select name="category" onChange="this.form.submit()"> -->
<!-- 	<option value="">所有分類</option> -->
<%-- 	<c:forEach var='categoryItem' items='${productCategoryList}'> --%>
<%-- 	<option value="${categoryItem.id}"  <c:if test="${categoryItem.id==category}"> selected </c:if> >${categoryItem.name}</option> --%>

<%-- 	</c:forEach> --%>
<!-- </select> -->
<!-- </form> -->

<%-- productCategoryList: ${productCategoryList[0].id} --%>
<nav class="navbar navbar-light" style="width:880px;background-color: #e3f2fd; border-radius: 25px; ">
<a class='create' href='pro/${currentPage}?status=${status}&category=${category}'><button class="btn btn-primary">新增商品</button></a>
<form class="form-inline" method="post" id='form2' action="<c:url value='/' />shop/showSearchProducts" style="width:auto;">
　<span style="color: #123456; font-weight:bold;" >請輸入商品名稱：</span><input class="form-control mr-sm-2" aria-label="Search" placeholder="Search" type="text" name="keyword" required="required" >
　<input class="btn btn-outline-success my-2 my-sm-0" type="submit" value="搜尋">
	<input type='hidden' name='status' value='${status}'>
	<input type='hidden' name='category' value='${category}'>
</form>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<form method="post" id='form3' action="<c:url value='/' />shop/showAllProducts" >

<%-- 請輸入商品名稱：<input type="text" name="keyword" required="required" value="${keyword}" > --%>
<!-- 　<input type="button" value="搜尋" onClick="this.form.submit()"> -->

<select class="custom-select" style="width:auto;"  name="status" onChange="this.form.submit()" >
<option value="">全部商品</option>
<option value="1" <c:if test="${status=='1'}"> selected </c:if>>上架中商品</option>
<option value="0" <c:if test="${status=='0'}"> selected </c:if>  >下架中商品</option>
</select>
&nbsp;&nbsp;
<select name="category" onChange="this.form.submit()" class="custom-select" style="width:auto;">
	<option value="">所有分類</option>
	<c:forEach var='categoryItem' items='${productCategoryList}'>
	<option value="${categoryItem.id}"  <c:if test="${categoryItem.id==category}"> selected </c:if> >${categoryItem.name}</option>

	</c:forEach>
</select>
</form>



</nav>
<hr>

<form method='POST' id='form1'>
	<input type='hidden' name='_method' value='DELETE'>
	<input type='hidden' name='prodNum' value='${prodNum}'>
	<input type='hidden' name='status' value='${status}'>
	<input type='hidden' name='category' value='${category}'>
</form>

<c:choose>
	<c:when test="${empty products}">
	    <div class="productNone"><span class="noneContent"><br><br>沒有任何商品資料</span></div> 
	</c:when>
	<c:otherwise>
<!-- 		<table border='1' cellpadding="3" cellspacing="1" width='1280' > -->
<div class='productlist'>
		<table class='table table-striped table-hover' >
<!-- 		 table-hover -->
			<tr class="bg-info" style="color:white;">
			   <th class='pnum'>編號</th>
			   <th class='pname'>商品名稱</th>
			   <th class='pcat'>分類</th>
			   <th class='pprice'>價錢</th>
			   <th class='pstock'>庫存</th>
			   <th class='premark'>商品描述</th>
			   <th class='pstatus'>狀態</th>
			   <th class='pcreatetime'>新增時間</th>
			   <th class='pupdatetime'>修改時間</th>
			   <th class='pimg'>商品圖片</th>
			   <th class='pcrud' colspan='2'  >資料維護</th> 
			</tr>
			
			<c:forEach var='product' begin='${startRow}' end='${pageSize}' items='${products}'>
				<tr >
					<td style="text-align:center">${product.product_id}</td>
					<td style="text-align:left">${product.product_name}</td>
					<td style="text-align:center">${product.productCategory.name}</td>
					<td style="text-align:center">${product.product_price}</td>
					<td style="text-align:center">${product.product_stock}</td>
					<td id='${product.product_id}' ><div id="remark">${product.product_remark}</div>

					<div><input class="button btn btn-info btn-sm" type="button" value="商品描述詳細" myvalue="${product.product_remark}" style="float:left;"/></div>
		
					</td>
					<td style="text-align:center">
					<c:choose>
					<c:when test="${product.product_status == 1}"><span class="badge badge-primary">上架中</span></c:when>
					<c:otherwise><span class="badge badge-secondary">下架中</span></c:otherwise>
					</c:choose>

					</td>
					<td style="text-align:center">${product.product_create_date}</td>
					<td style="text-align:center">${product.product_update_date}</td>
					<td style="text-align:center" ><img width='100' height='100' src='picture/${product.product_id}' /></td>
					<td style="text-align:center" ><a href="<c:url value='/' />shop/pro/${currentPage}/${product.product_id}?status=${status}&category=${category}"><button class="btn btn-outline-info btn-sm">修改</button></a><br><br>
					     <a class='proUp'  myhref="<c:url value='/' />shop/prodUp/${currentPage}/${product.product_id}" > <button class="btn btn-outline-primary btn-sm" <c:if test="${product.product_status == 1}"> disabled="disabled" style="cursor:not-allowed;" </c:if>  >上架</button></a>
					</td>
                      <td style="text-align:center" > <a class='deletelink' myhref="<c:url value='/' />shop/prod/${currentPage}/${product.product_id}"><button class="btn btn-outline-danger btn-sm">刪除</button></a><br><br>
  
                         <a class='proDown'  myhref="<c:url value='/' />shop/prodDown/${currentPage}/${product.product_id}" > <button class="btn btn-outline-secondary btn-sm" <c:if test="${product.product_status == 0}"> disabled="disabled" style="cursor:not-allowed;" </c:if> >下架</button></a>
                    
                    </td>
				</tr>
			</c:forEach>
		</table>
</div>
<%-- 		<p>總共${prodNum}筆商品資料</p> --%>
		
		<div class="pagging">
        <div class="right">
        <c:if test="${currentPage == 1}">
            <span class="disabled"><i class='fas fa-arrow-circle-left'></i> 上一頁</span>        
        </c:if>
        <c:if test="${currentPage != 1}">
            <a href="showAllProducts?page=${currentPage-1}&status=${status}&category=${category}"><i class='fas fa-arrow-circle-left'></i> 上一頁</a>
        </c:if>
        <c:if test="${currentPage == 1}">
        <span class="current">1</span>
        </c:if>
        <c:if test="${currentPage != 1}">
        <a href="showAllProducts?page=1&status=${status}&category=${category}">1</a>
        </c:if>
         
        <%
                int pageTimes = (Integer)request.getAttribute("pageTimes");
                for(int i=1;i<pageTimes;i++)
                {
                    request.setAttribute("page", i+1);
        %>
         
        <c:if test="${currentPage == page}">
            <span class="current"><%=i+1%></span>       
        </c:if>
        <c:if test="${currentPage != page}">
             <a href="showAllProducts?page=<%=i+1%>&status=${status}&category=${category}"><%=i+1%></a>
        </c:if>
        <%} %>

            
        <c:if test="${currentPage == pageTimes}">
            <span class="disabled">下一頁 <i class='fas fa-arrow-circle-right'></i></span>        
        </c:if>
        <c:if test="${currentPage != pageTimes}">
        <a href="showAllProducts?page=${currentPage+1}&status=${status}&category=${category}">下一頁 <i class='fas fa-arrow-circle-right'></i></a>
        </c:if>
        </div>
</div>
	</c:otherwise>
</c:choose>
<hr>

<%-- <c:if test="${empty products}"> --%>
<!-- 	<div style="min-height:210px;"></div> -->
<%-- </c:if> --%>
<!-- <div style="min-height:140px;"></div> -->


</div>
<script type='text/javascript'>

    $(document).ready(function() {
    	
    	$("#head").show();
    	$("#All").show();
//     	$("#foot").show();
    	
        
        $('.deletelink').click(function() {
       	 var href = $(this).attr('myhref');
       	 Swal.fire({ 
       	  title: '刪除商品', 
       	  text: '是否永久刪除此商品? (警告:無法復原)', 
       	  icon: 'warning',
       	  showCancelButton: true, 
       	  confirmButtonColor: '#3085d6',
       	  cancelButtonColor: '#d33',
       	  confirmButtonText: '刪除',
       	  cancelButtonText: '取消',

       	  }).then(result => {
       		  if (result.value) {
       			  Swal.fire({
       				  title: '刪除完成',
       				  text: '所選商品已經永久刪除。',
       				  icon: 'success',
       			  }).then(function(){
       	        			$('#form1').attr('action', href).submit();	    	 
       	  		     });
   
       			} else {			
           				return false;
       			}
       	    })
       	});
    

           $('.proUp').click(function() {
        	 var href = $(this).attr('myhref');
        	 Swal.fire({ 
        	  title: '上架商品', 
        	  text: '是否要將所選商品上架?', 
        	  icon: 'question',
        	  showCancelButton: true, 
        	  confirmButtonColor: '#3085d6',
        	  cancelButtonColor: '#d33',
        	  confirmButtonText: '上架',
        	  cancelButtonText: '取消',
        	  backdrop: false,

        	  }).then(result => {
        		  if (result.value) {
        			  Swal.fire({
        				  title: '上架完成',
        				  text: '所選商品已經上架。',
        				  icon: 'success',
        				  backdrop: false,
        			  }).then(function(){
        	        			$('#form1').attr('action', href).submit();	    	 
        	  		     });
    
        			} else {			
            				return false;
        			}
        	    })
        	});
           
           
           $('.proDown').click(function() {
          	 var href = $(this).attr('myhref');
          	 Swal.fire({ 
          	  title: '下架商品', 
          	  text: '是否要將所選商品下架?', 
          	  icon: 'question',
          	  showCancelButton: true, 
          	  confirmButtonColor: '#3085d6',
          	  cancelButtonColor: '#d33',
          	  confirmButtonText: '下架',
              cancelButtonText: '取消',
          	  backdrop: false,

          	  }).then(result => {
          		  if (result.value) {
          			  Swal.fire({
          				  title: '下架完成',
          				  text: '所選商品已經下架。',
          				  icon: 'success',
          				  backdrop: false,
          			  }).then(function(){
          	        			$('#form1').attr('action', href).submit();	    	 
          	  		     });
      
          			} else {			
              				return false;
          			}
          	    })
          	});


        
        $(".button").click(function(){
        	var remark = $(this).attr("myvalue");
        	Swal.fire({
        		//toast: true,
                title: "商品描述",
                html:  "<p align='left'>"+remark,
                text:  "",
                backdrop: false,
                showClass: {
                    popup: '',
                  },
                  hideClass: {
                    popup: '',
                  },
                confirmButtonText: "OK" 
               });
        	});
        
    })
    
    

    
    
</script>

 <c:import url="../../footer.jsp"/>	
<!--     <script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script> -->
</body>
</html>