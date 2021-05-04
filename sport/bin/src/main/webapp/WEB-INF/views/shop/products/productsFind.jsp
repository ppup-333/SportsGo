<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">

<style>
#remark{
        width:300px;
        display: -webkit-box;
        -webkit-line-clamp:3;
        -webkit-box-orient:vertical;
        overflow:hidden;
        white-space:pre-wrap;
        text-overflow:ellipsis;
		}

form{
	margin:0px; 
	display:inline
	}

</style>
<script type='text/javascript' src="<c:url value='/' />/scripts/jquery-1.9.1.min.js"></script>

<title>商品一覽</title>

    <!--引用css-->
    <link rel="stylesheet" href="    https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" />
    <!--引用jQuery-->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>
    <!--引用SweetAlert2.js-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script>
    
</head>
<body>
<div align='center'>
<h3>商品資料後台管理</h3>
<a class='create' href='pro/${currentPage}?keyword=${keyword}&status=${status}&category=${category}'><button>新增商品</button></a> &nbsp;&nbsp;&nbsp;
<a href="<c:url value='/shopHome'/> " ><button>回到管理首頁</button></a> &nbsp;&nbsp;&nbsp;
<a href="<c:url value='/shop/showAllProducts'/> " ><button>重置搜尋結果</button></a><br><br>


	<c:if test="${status != '0' && status != '1' && (category==null||category==0)}">
		<div><p>搜尋結果：總共有 ${prodNum} 筆商品資料符合 關鍵字 「${keyword}」</p></div>
	</c:if>
<c:choose>
	<c:when test="${status == '0'}">
		<div id="prodOn"><p>關鍵字 「${keyword}」 搜尋結果：<c:if test="${category!=null&&category>0}" ><br>【${productCategoryList[category-1].name}】的分類中 </c:if>共有 ${prodNum} 筆商品為下架狀態</p></div>
	</c:when>
	<c:when test="${status == '1'}">
		<div id="prodOff"><p>關鍵字 「${keyword}」 搜尋結果：<c:if test="${category!=null&&category>0}" ><br>【${productCategoryList[category-1].name}】的分類中 </c:if>共有 ${prodNum} 筆商品為上架狀態</p></div>
	</c:when>
<c:otherwise>
<c:if test="${category!=null&&category>0}" ><p>關鍵字 「${keyword}」 搜尋結果：<br>【${productCategoryList[category-1].name}】的分類中 共有 ${prodNum} 筆商品</p></c:if>
</c:otherwise>
</c:choose>
<br>

<%-- <form action="<c:url value='/' />shop/showSearchProducts" method="post"> --%>
<!-- 　請輸入商品名稱：<input type="text" name="keyword" required="required"> -->
<!-- 　<input type="submit" value="搜尋"> -->
<!-- </form>&nbsp;&nbsp;&nbsp; -->


<form method="post" id='form3' action="<c:url value='/' />shop/showSearchProducts" >

請輸入商品名稱：<input type="text" name="keyword" required="required" value="${keyword}" >
　<input type="button" value="搜尋" onClick="this.form.submit()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<select name="status" onChange="this.form.submit()">
<option value="">全部商品</option>
<option value="1" <c:if test="${status=='1'}"> selected </c:if>>上架中商品</option>
<option value="0" <c:if test="${status=='0'}"> selected </c:if>  >下架中商品</option>
</select>
&nbsp;&nbsp;&nbsp;
<select name="category" onChange="this.form.submit()">
	<option value="">所有分類</option>
	<c:forEach var='categoryItem' items='${productCategoryList}'>
		<option value="${categoryItem.id}"  <c:if test="${categoryItem.id==category}"> selected </c:if> >${categoryItem.name}</option>
	</c:forEach>
</select>
<input type='hidden' name='keyword2' value='${keyword2}'>
</form>




<hr>
<form method='POST' id='form1'>
	<input type='hidden' name='keyword' value='${keyword}'>
	<input type='hidden' name='prodNum' value='${prodNum}'>
	<input type='hidden' name='status' value='${status}'>
	<input type='hidden' name='category' value='${category}'>
</form>

<!-- <form method='POST' id='form1'> -->
<%-- 	<input type='hidden' name='${keyword}' value='DELETE'> --%>
<!-- </form> -->

<c:choose>
	<c:when test="${empty products}">
	    搜尋不到任何商品<br> 
	</c:when>
	<c:otherwise>
		<table border='1' cellpadding="3" cellspacing="1" width='1280' >
			<tr>
			   <th width='40'>編號</th>
			   <th width='200'>商品名稱</th>
			   <th width='90'>分類</th>
			   <th width='50'>價錢</th>
			   <th width='50'>庫存</th>
			   <th width='300'>商品描述</th>
			   <th width='50'>狀態</th>
			   <th width='100'>新增時間</th>
			   <th width='100'>修改時間</th>
			   <th width='100'>商品圖片</th>
			   <th colspan='2' width='70'>資料維護</th>
			</tr>

			<c:forEach var='product' begin='${startRow}' end='${pageSize}' items='${products}'>
				<tr>
					<td style="text-align:center">${product.product_id}</td>
					<td style="text-align:left">${product.product_name}</td>
					<td style="text-align:center">${product.productCategory.name}</td>
					<td style="text-align:center">${product.product_price}</td>
					<td style="text-align:center">${product.product_stock}</td>
					<td id='${product.product_id}' ><div id="remark">${product.product_remark}</div>
					<input class="button" type="button" value="商品描述詳細" myvalue="${product.product_remark}" style="float:left;"/>
					</td>
					<td style="text-align:center">
					<c:choose>
					<c:when test="${product.product_status == 1}">上架中</c:when>
					<c:otherwise>下架中</c:otherwise>
					</c:choose>
					</td>
					<td style="text-align:center">${product.product_create_date}</td>
					<td style="text-align:center">${product.product_update_date}</td>
					<td style="text-align:center" ><img width='100' height='100' src='picture/${product.product_id}' /></td>
					<td style="text-align:center" ><a class='update' href="<c:url value='/' />shop/pro/${currentPage}/${product.product_id}?keyword=${keyword}&status=${status}&category=${category}"><button>修改</button></a><br><br>
					    <a class='proUp' myhref="<c:url value='/' />shop/prodUp/${currentPage}/${product.product_id}" > <button>上架</button></a>
					</td>
                    <td style="text-align:center" > <a class='deletelink' myhref="<c:url value='/' />shop/prod/${currentPage}/${product.product_id}"><button>刪除</button></a><br><br>
                        <a class='proDown' myhref="<c:url value='/' />shop/prodDown/${currentPage}/${product.product_id}" > <button>下架</button></a>
                    </td>
				</tr>
			</c:forEach>
		</table>
		<p>總共${prodNum}筆商品資料</p>
		
		<div class="pagging">
        <div class="right">
        <c:if test="${currentPage == 1}">
            <span class="disabled"><< 前一頁</span>        
        </c:if>
        <c:if test="${currentPage != 1}">
            <a href="showSearchProducts?keyword=${keyword}&page=${currentPage-1}&status=${status}&category=${category}"><< 前一頁</a>
        </c:if>
        <c:if test="${currentPage == 1}">
        <span class="current">1</span>
        </c:if>
        <c:if test="${currentPage != 1}">
        <a href="showSearchProducts?keyword=${keyword}&page=1&status=${status}&category=${category}">1</a>
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
             <a href="showSearchProducts?keyword=${keyword}&page=<%=i+1%>&status=${status}&category=${category}"><%=i+1%></a>
        </c:if>
        <%} %>

            
        <c:if test="${currentPage == pageTimes}">
            <span class="disabled">後一頁 >></span>        
        </c:if>
        <c:if test="${currentPage != pageTimes}">
        <a href="showSearchProducts?keyword=${keyword}&page=${currentPage+1}&status=${status}&category=${category}">後一頁 >></a>
        </c:if>
        </div>
</div>
	</c:otherwise>
</c:choose>
<hr>
</div>
<script type='text/javascript'>

    $(document).ready(function() {
    	
//     	$('.create').click(function() {
//           	 var href = $(this).attr('myhref');
//           	 //$('#form1').attr('action', href).submit();
//           	 console.log(href);
//           	 window.open(href,"新增商品","width=610,height=550")
   	
//           	 });
      
    	
    	
        $('.deletelink').click(function() {
       	 var href = $(this).attr('myhref');
       	 Swal.fire({ 
       	  title: '刪除商品', 
       	  text: '是否永久刪除此商品? (警告:無法復原)', 
       	  icon: 'warning',
       	  showCancelButton: true, 
       	  confirmButtonColor: '#3085d6',
       	  cancelButtonColor: '#d33',
       	  confirmButtonText: '刪了他！',

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
        
        
//         $('.update').click(function() {
//        	 var href = $(this).attr('myhref');
//        	 $('#form1').attr('action', href).submit();	    	 
//        	});   
        
    
           $('.proUp').click(function() {
        	 var href = $(this).attr('myhref');
        	 Swal.fire({ 
        	  title: '上架商品', 
        	  text: '是否要將所選商品上架?', 
        	  icon: 'question',
        	  showCancelButton: true, 
        	  confirmButtonColor: '#3085d6',
        	  cancelButtonColor: '#d33',
        	  confirmButtonText: '上架他！',
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
          	  confirmButtonText: '下架他！',
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

</body>
</html>