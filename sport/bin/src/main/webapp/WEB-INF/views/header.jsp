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
                            <div class="dropdown">
                            	<span id="aboutUs">
                                    <a href="/sport/bbs">討論區</a>
                                </span>
<!--                                 <span id="aboutUs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
<!--                                     討論區 -->
<!--                                 </span> -->
<!--                                 <div class="dropdown-menu" aria-labelledby="aboutUs"> -->
<!--                                     <a class="dropdown-item" href="#">123</a> -->
<!--                                     <a class="dropdown-item" href="#">123</a> -->
<!--                                 </div> -->
                            </div>
                            <div class="dropdown">
<!--                             	<span id="aboutUs"> -->
<!--                                     <a href="/sport/shopHome">購物商城</a> -->
<!--                                 </span> -->
                                <span id="aboutUs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    購物商城
                                </span>
                                <div class="dropdown-menu" aria-labelledby="aboutUs">
                                    <a class="dropdown-item" href="/sport/shop/storeProductsAll">前往商城</a>
                                    <a class="dropdown-item" href="/sport/shop/myShoppingCart">我的購物車</a>
                                    <a class="dropdown-item" href="/sport/shop/order/orderList">我的訂單</a>
                                </div>
                            </div>
                            <div class="dropdown">
                                <span id="aboutUs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    場地預約
                                </span>
                                <div class="dropdown-menu" aria-labelledby="aboutUs">
                                    <a class="dropdown-item" href="/sport/fieldOrder/createPage">我要預約</a>
                                    <a class="dropdown-item" href="/sport/fieldOrder/searchForMemberPage">訂單查詢</a>
                                    <a class="dropdown-item" href="/sport/fieldOrder/cancelForMemberPage">訂單取消</a>
                                </div>
                            </div>
                            <div class="dropdown">
                                <span id="aboutUs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    活動與課程
                                </span>
                                <div class="dropdown-menu" aria-labelledby="aboutUs">
                                    <a class="dropdown-item" href="#">活動總覽</a>
                                    <a class="dropdown-item" href="#">課程總覽</a>
                                    <a class="dropdown-item" href="#">我要報名</a>
                                </div>
                            </div>
                            <div class="dropdown">
                                <span id="aboutUs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    最新消息
                                </span>
                                <div class="dropdown-menu" aria-labelledby="aboutUs">
                                    <a class="dropdown-item" href="#">系統公告</a>
                                    <a class="dropdown-item" href="#">課程異動</a>
                                </div>
                            </div>
                            <div class="dropdown">
                                <span id="aboutUs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    關於我們
                                </span>
                                <div class="dropdown-menu" aria-labelledby="aboutUs">
                                    <a class="dropdown-item" href="#">場館介紹</a>
                                    <a class="dropdown-item" href="#">位置資訊</a>
                                    <a class="dropdown-item" href="#">聯絡我們</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div id="loginDiv" class="col-1">
                <button id="loginBtn" type="button" class="btn btn-info">登入</button>
            </div>
        </div>
    </div>
<!--end of header-->

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

</body>
</html>