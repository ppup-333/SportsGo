<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="/sport/css/header.css">
<link rel="stylesheet" href="/sport/css/HomeMain.css">
<link rel="stylesheet" href="/sport/css/footer.css">

</head>
<body>
<!-- header -->
    <div id="headerDiv" class="container-fluid border-bottom">
        <div class="row">
            <div id="logoDiv" class="col-3">                
                <div id="logo">
                    <a href="/sport/">Sports Go!</a>
                </div>
            </div>
            <div id="middleDiv" class="col-8">
                <div class="container-fluid">
                    <div class="row" style="height: 90px;">
                        <div class="col-3"></div>
                        <div id="optionDiv" class="col-9">
                            <div class="btn-group">
<!--                             	<span id="aboutUs"> -->
<!--                                     <a href="/sport/bbs">討論區</a> -->
<!--                                 </span> -->
                                <span id="aboutUs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    討論區
                                </span>
                                <div class="dropdown-menu" aria-labelledby="aboutUs">
                                    <a class="dropdown-item" href="/sport/bbs">發文總覽</a>
                                    <a class="dropdown-item" href="/sport/bbsdiscussion.c">我要發文</a>
                                    <a class="dropdown-item" href="/sport/bbsMemberPrivate">我的發文與留言</a>
                                </div>
                            </div>
                            <div class="btn-group">
                                <span id="shop" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    購物商城
                                </span>
                                <div class="dropdown-menu" aria-labelledby="shop">
                                    <a class="dropdown-item" href="/sport/shop/storeProductsAll">前往商城</a>
                                    <a class="dropdown-item" href="/sport/shop/myShoppingCart">我的購物車</a>
                                    <a class="dropdown-item" href="/sport/shop/order/orderList">我的訂單</a>
                                </div>
                            </div>
                            <div class="btn-group">
                                <span data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    場地預約
                                </span>
                                <div id="fieldOrder" class="dropdown-menu" aria-labelledby="fieldOrder">
                                    <a class="dropdown-item" href="/sport/fieldOrder/createPage">我要預約</a>
                                    <a class="dropdown-item" href="/sport/fieldOrder/searchForMemberPage">訂單查詢</a>
                                    <a class="dropdown-item" href="/sport/fieldOrder/cancelForMemberPage">訂單取消</a>
                                </div>
                            </div>
                            <div class="btn-group">
                                <span id="course_act" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    活動與課程
                                </span>
                                 <div class="dropdown-menu" aria-labelledby="course_act">
                                    <a class="dropdown-item" href="/sport/activityMain">活動總覽</a>
                                    <a class="dropdown-item" href="/sport/NewCourseMain">課程總覽</a>
                                    
                                </div>
                            </div>
                            <div class="btn-group">
                                <span id="news" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    最新消息
                                </span>
                                <div class="dropdown-menu dropdown-menu-md-left" aria-labelledby="news">
                                    <a class="dropdown-item" href="/sport/Bulletin/viewBulletin">系統公告</a>
                                    <a class="dropdown-item" href="/sport/Bulletin/viewBulletinCourse">課程異動</a>
                                </div>
                            </div>
                            <div class="btn-group">
                            	<span id="aboutUs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    								關於我們
				  				</span>
				  				<div class="dropdown-menu dropdown-menu-md-left" aria-labelledby="aboutUs">
				    				<a class="dropdown-item" href="#">場館介紹</a>
				    				<a class="dropdown-item" href="#">位置資訊</a>
				    				<a class="dropdown-item" href="#">聯絡我們</a>
				  				</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="loginDiv" class="btn-group">
  				<button id="memberListBtn" type="button" class="btn btn-info" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    				登入
  				</button>
  				<div class="dropdown-menu dropdown-menu-md-left loginDropdown">
<!--     				<a class="dropdown-item" href="/sport/user/Login">登入</a> -->
					<a class="dropdown-item" href="/sport/user/Login">登入</a>
					<a class="dropdown-item" href="" id="loginBtn" data-toggle="modal" data-target="#exampleModal">
					  測試登入
					</a>
					<a class="dropdown-item" href="/sport/user/ForgetPwd">忘記密碼</a>
    				<a class="dropdown-item" href="/sport/user/RegisterEdit">註冊</a>
    				<a class="dropdown-item" href="/sport/admin/AdminLogin">管理員登入</a>
  				</div>  				
			</div>
			<div id="logoutDiv" style="display:none">
				<button id="memberBtn" type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    				<i class="fas fa-user"></i>&nbsp;${sessionScope.username}
  				</button>
  				<form action="/sport/user/Logout" method="post" id="formLogout">
	  				<div class="dropdown-menu dropdown-menu-md-left loginDropdown">
	    				<a class="dropdown-item" href="#">會員中心</a>
	    				<a class="dropdown-item" id="logoutBtn" href="#">登出</a>
	  				</div>
  				</form>
			</div>
        </div>
    </div>
<!--end of header-->

<!-- Login Modal -->
<form:form method="POST" action="/sport/user/Login" modelAttribute="loginPage" enctype='multipart/form-data' id="formLogin">
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">會員登入</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
				<div>
					<table>
						<tr>
							<td>帳號：<br>&nbsp;</td>
							<td><form:input path="account" id="userAct" /><br>&nbsp;
								<span class="spLogin">8~16位英文字母和數字的組合(不區分大小寫)</span><br/>
		<%-- 						<form:errors path='account' cssClass="error"/> --%>
								</td>
						</tr>
						<tr>
							<td>密碼：<br>&nbsp;</td>
				  			<td width='360'><form:input path='password' type='password' id="userPwd"/><br>&nbsp;	
				     						<span class="spLogin">8~16位英文字母和數字的組合(區分大小寫)</span><br/></td>
						</tr>
						<tr>
							<td></td>
							<td><form:errors path='password' cssClass="error" id='loginError'/></td>
						</tr>
					</table>
				</div>
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-primary">送出</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="" id="clickInput">一鍵輸入</button>
	      </div>
	    </div>
	  </div>
	</div>
</form:form>
<!-- end of Login Modal -->

<script>

	<c:if test="${sessionScope.loginErrorCode !=null && sessionScope.loginErrorCode == 1}">
		
		alert("帳號或密碼不正確");

		${sessionScope.remove("loginErrorCode")}
	</c:if>
		
	// 檢查是否有登入
	<c:if test="${sessionScope.account!=null && sessionScope.account!=''}">
		var memberListBtn = document.getElementById("memberListBtn");
		var logoutDiv = document.getElementById("logoutDiv");
		memberListBtn.style.display='none';
		logoutDiv.style.display='block';
	</c:if>
	
	$("#logoutBtn").click(function() {
		if(!confirm("確定要登出？")){
			$("#memberBtn").click();
			return false;
		}else{			
			$("#formLogout").submit();
		}
	});
	
	$("#clickInput").click(function(){
		$("input[id='userAct']").val("test1001")
		$("input[id='userPwd']").val("test1001")
	});
	
	
</script>
	

<script src="http://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="http://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
</body>
</html>