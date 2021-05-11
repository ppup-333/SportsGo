<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- header -->
    <nav id="bar1" class="navbar navbar-light bg-info">
        <a class="navbar-brand" href="/sport/managerHome">Sports Go!</a>
        <form action="/sport/user/Logout" method="post" id="logoutForm">
        	<span class="btn btn-info">管理員：${sessionScope.account}</span>&nbsp;&nbsp;
        	<button id="logoutBtn" type="button" class="btn btn-light text-info">登出</button>
        </form>
    </nav>
    <ul id="ulHeaderM" class="nav justify-content-center">
        <li class="nav-item">
<!--             <a class="nav-link" href="#">帳號管理</a> -->
            <div class="btn-group">
                <span class="nav-link dropdown-toggle" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    帳號管理
                </span>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="/sport/admin/resultAllUsers">會員資料查詢／異動</a>
                    <a class="dropdown-item" href="/sport/admin/resultAllAdmins">管理員查詢／異動</a>
                </div>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/sport/Bulletin/showAllBulletin">公告管理</a>
            <!-- <div class="btn-group">
                <span class="nav-link dropdown-toggle" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    公告管理
                </span>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="#"></a>
                    <a class="dropdown-item" href="#"></a>
                </div>
            </div> -->
        </li>
        <li class="nav-item">
            <!-- <a class="nav-link" href="#">課程活動</a> -->
            <div class="btn-group">
                <span class="nav-link dropdown-toggle" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    課程活動
                </span>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="/sport/NewManageCourseMain">管理課程</a>
                    <a class="dropdown-item" href="/sport/NewManageActivityMain">管理活動</a>
                    <a class="dropdown-item" href="/sport/teacherHome">管理老師</a>
                </div>
            </div>
        </li>
        <li class="nav-item">
            <!-- <a class="nav-link" href="#">場地預約</a> -->
            <div class="btn-group">
                <span class="nav-link dropdown-toggle" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    場地預約
                </span>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="/sport/field_GetAllFields">場地管理</a>
                    <a class="dropdown-item" href="/sport/fieldOrder/searchPage">訂單管理</a>
                </div>
            </div>
        </li>
        <li class="nav-item">
            <!-- <a class="nav-link" href="#">購物商城</a> -->
            <div class="btn-group">
                <span class="nav-link dropdown-toggle" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    購物商城
                </span>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="/sport/shop/showAllProducts">商品管理</a>
                    <a class="dropdown-item" href="/sport/shop/order/orderListManage">訂單管理</a>
                </div>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/sport/bbsM">討論區管理</a>        
            <!-- <div class="btn-group">
                <span class="nav-link dropdown-toggle" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    討論區
                </span>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="#"></a>
                    <a class="dropdown-item" href="#"></a>
                    <a class="dropdown-item" href="#"></a>
                </div>
            </div> -->
        </li>
    </ul>
<!--end of header-->

<script>
// 	$("#logoutBtn").click(function(){
// 		if(!confirm("確定登出？")){
// 			return false;
// 		}
// 	});
	
	$("#logoutBtn").click(function(){
		Swal.fire({
			icon: "question",
			showCancelButton: true,
			confirmButtonText: "確定",
			cancelButtonText: "取消",
			title: "登出確認"
		}).then((result) => {
			if (result.isConfirmed) {
				Swal.fire({
					icon: "success",
					title: "成功登出！",
				}).then((result) => {
					$("#logoutForm").submit();
				});
			}
		});
	});
	
</script>
