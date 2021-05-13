<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>首頁(登入)</title>
<c:import url="../headerScript.jsp"/>

<style>
	#memberCenterMainDiv {
		margin: auto;
	}
	
	#memberCenterTable button{
		width: 140px;
	}	
	
</style>

</head>
<body>
<c:import url="../newheader.jsp"/>
	<h2>會員中心</h2>

	<div class="container">
		<div class="row">
			<div id="memberCenterMainDiv" class="col-5">

				<table id="memberCenterTable" class="table">
					<tr>
						<td>帳號資料</td>
						<td>
							<button type="button" class="btn btn-primary" value="管理帳號資料" onclick="location.href='userResult'">管理帳號資料</button>
							<button type="button" class="btn btn-primary" value="變更密碼" onclick="location.href='userUpdatePwd'">變更密碼</button>
						</td>
					</tr>
					<tr>
						<td>課程活動</td>
						<td>
							<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/CourseOrder'">查詢課程訂單</button>
							<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/orderAct'">查詢活動訂單</button>
						</td>
					</tr>
					<tr>
						<td>場地預約</td>
						<td>
							<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/fieldOrder/searchForMemberPage'">我的場地預約</button>
							<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/fieldOrder/cancelForMemberPage'">取消場地預約</button>
						</td>
					</tr>
					<tr>
						<td>購物商城</td>
						<td>
							<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/shop/myShoppingCart'">我的購物車</button>
							<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/shop/order/orderList'">商城訂單查詢</button>
						</td>
					</tr>
					<tr>
						<td>討論區</td>
						<td>
							<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/bbsMemberPrivate'">我的發文與留言</button>
						</td>
					</tr>
				
				</table>
<!-- 				<input type="button" class="btn btn-primary" value="管理帳號資料" onclick="location.href='userResult'"> -->
<!-- 				<input type="button" class="btn btn-primary" value="變更密碼" onclick="location.href='userUpdatePwd'"> -->
<!-- 				<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/CourseOrder'">查詢課程訂單</button> -->
<!-- 				<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/orderAct'">查詢活動訂單</button> -->
<!-- 				<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/fieldOrder/searchForMemberPage'">我的場地預約</button> -->
<!-- 				<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/fieldOrder/cancelForMemberPage'">取消場地預約</button> -->
<!-- 				<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/shop/myShoppingCart'">我的購物車</button> -->
<!-- 				<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/shop/order/orderList'">商城訂單查詢</button> -->
<!-- 				<button type="button" class="btn btn-primary" onclick="window.location.href='/sport/bbsMemberPrivate'">我的發文與留言</button> -->
			
			
			
			</div>
		</div>
	</div>
	<c:import url="../footer.jsp"/>
</body>
</html>