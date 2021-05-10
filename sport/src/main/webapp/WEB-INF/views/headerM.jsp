<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

<link rel="stylesheet" href="/sport/css/headerM.css">

</head>
<body>
<!-- header -->
    <nav id="bar1" class="navbar navbar-light bg-info">
        <a class="navbar-brand" href="/sport/managerHome">Sports Go!</a>
        <form action="/sport/user/Logout" method="post">
        	<button type="submit" class="btn btn-light text-info">登出</button>
        </form>
    </nav>
    <ul id="ul1" class="nav justify-content-center">
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
            <a class="nav-link" href="#">公告管理</a>
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
                    <a class="dropdown-item" href="#">商品管理</a>
                    <a class="dropdown-item" href="#">訂單管理</a>
                </div>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">討論區管理</a>        
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

	
	
	
<!-- bootstrap -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

</body>
</html>