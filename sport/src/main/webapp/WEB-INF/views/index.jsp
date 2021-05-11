<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:import url="headerScript.jsp"/>

<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<script src="/sport/scripts/bulletin/date.format.js"></script>
<meta charset="UTF-8">
<title>home</title>
</head>

<style>
	.newsPic {
		max-width:600px;
		myimg:expression(onload=function(){
		this.style.width=(this.offsetWidth > 600)?"600px":"auto"});
	}
</style>

<script>
	$(document).ready(function(){
		var xhr = new XMLHttpRequest();
		var dataUrl = "/sport/Bulletin/bulletinPaging/" + 1;
		xhr.open('GET', dataUrl, true)
		xhr.send()
		xhr.onreadystatechange = function(){
			if (this.readyState === 4 && this.status === 200){
				var data = JSON.parse(this.responseText);
				$.each(data, function(index, bulletin) {
					var updateTime = new Date(bulletin.update_time).format("Y-m-d");
					$('#newsBot' + index).html('<div>' + updateTime + '</div>' + '<h3 class="newsBotTile" >'+ bulletin.title +'</h3>')
// 					$('#newsBot' + index).html('<h3 class="newsBotTile" >'+ bulletin.title +'</h3>')
					$('#newsTop' + index).html('<a id="newsLink'+ index +'" href="#" title="了解更多' +  bulletin.title +'的內容">'
							+ '<img class="newsPic" src="<c:url value="/Bulletin/picture/'+ bulletin.id + '"/>" width="100%" height="100%"></img>' + '</a>')
				
					$('#newsLink' + index).attr('href',"/sport/Bulletin/showBulletinContent/" + bulletin.id);
				
				});
			}
		}
	});
</script>

<body>
<c:import url="newheader.jsp"/>

<!-- main img-->
    <div id="mainDiv" class="container-fluid">
        <div class="row">
<!--         	<div class="col-1"></div> -->
            <div id="imgDiv" class="col-12">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                      <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                      <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                      <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                      <div class="carousel-item active">
                        <img src="/sport/images/gym3.jpg" class="d-block w-100">
                      </div>
                      <div class="carousel-item">
                        <img src="/sport/images/swimmingpool3.jpg" class="d-block w-100">
                      </div>
                      <div class="carousel-item">
                        <img src="/sport/images/tabletennis3.jpg" class="d-block w-100">
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
<!--             <div class="col-1"></div> -->
        </div>
    </div> <!--end of main img-->

    <!-- news -->
    <div id="newsDiv" class="container">
        <div class="row">
            <div class="col-12">
                <h2>最新消息</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-4 newsDiv2">
                <div class="newsDiv3">
                    <div id="newsTop0" class="newsTop">
                        
                    </div>
                    <div id="newsBot0" class="newsBot">
                        
                    </div>
                </div>
            </div>
            <div class="col-4 newsDiv2">
                <div class="newsDiv3">
                    <div id="newsTop1" class="newsTop">
                        
                    </div>
                    <div id="newsBot1" class="newsBot">
                        
                    </div>
                </div>
            </div>
            <div class="col-4 newsDiv2">
                <div class="newsDiv3">
                    <div id="newsTop2" class="newsTop">
                        
                    </div>
                    <div id="newsBot2" class="newsBot">
                        
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- end of news -->

    <!-- fields -->
    <div id="fieldsDiv" class="container">
        <div class="row">
            <div class="col-12">
                <h2>場館介紹</h2>
            </div>
        </div>
        <div class="row">
            <div id="fieldsDiv2" class="col-12">
                <nav id="fieldNav">
                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                      <a class="nav-link active" id="nav-b1-tab" data-toggle="tab" href="#nav-b1" role="tab" aria-controls="nav-b1" aria-selected="true">游泳</a>
                      <a class="nav-link" id="nav-1f-tab" data-toggle="tab" href="#nav-1f" role="tab" aria-controls="nav-1f" aria-selected="false">羽球</a>
                      <a class="nav-link" id="nav-2f-tab" data-toggle="tab" href="#nav-2f" role="tab" aria-controls="nav-2f" aria-selected="false">籃球</a>
                      <a class="nav-link" id="nav-3f1-tab" data-toggle="tab" href="#nav-3f1" role="tab" aria-controls="nav-3f1" aria-selected="false">桌球</a>
                      <a class="nav-link" id="nav-3f2-tab" data-toggle="tab" href="#nav-3f2" role="tab" aria-controls="nav-3f2" aria-selected="false">壁球</a>
                      <a class="nav-link" id="nav-4f-tab" data-toggle="tab" href="#nav-4f" role="tab" aria-controls="nav-4f" aria-selected="false">排球</a>
                      <a class="nav-link" id="nav-5f-tab" data-toggle="tab" href="#nav-5f" role="tab" aria-controls="nav-5f" aria-selected="false">健身房</a>

                    </div>
                </nav>
                <div class="tab-content" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="nav-b1" role="tabpanel" aria-labelledby="nav-b1-tab">...</div>
                    <div class="tab-pane fade" id="nav-1f" role="tabpanel" aria-labelledby="nav-1f-tab">...</div>
                    <div class="tab-pane fade" id="nav-2f" role="tabpanel" aria-labelledby="nav-2f-tab">...</div>
                    <div class="tab-pane fade" id="nav-3f1" role="tabpanel" aria-labelledby="nav-3f1-tab">...</div>
                    <div class="tab-pane fade" id="nav-3f2" role="tabpanel" aria-labelledby="nav-3f2-tab">...</div>
                    <div class="tab-pane fade" id="nav-4f" role="tabpanel" aria-labelledby="nav-4f-tab">...</div>
                    <div class="tab-pane fade" id="nav-5f" role="tabpanel" aria-labelledby="nav-5f-tab">...</div>
                </div>
            </div>
        </div>        
    </div> <!-- end of fields -->


<a href="/sport/user_Login">會員登入系統</a><br>
<a href="/sport/bulletin">公告管理</a><br>
<a href="/sport/field_HomePage">場地預約管理</a><br>
<a href="/sport/bbsM">bbsM</a><br>
<a href="/sport/shopHome">購物商城</a><br>
<a href="/sport/courseHome">課程</a>
</body>
</html>