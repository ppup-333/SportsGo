<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增會員資料</title>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css" rel="stylesheet">
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
  
<style>

	td {
		height: 50px;
		width: auto;
		
	}

	.div {
		width: 100%;
		height: 800px;
		max-width: 700px;
		box-shadow: 0px 0px 3px 1px #00000078;
		padding: 10px;
		box-sizing: border-box;
		margin: 0 auto;
		border: 1px solid white;
	}

	.sp {
		color: darkgrey;
		font-size: 1px;
	}

	.sp1 {
		color: red;
		font-size: 1px;
	}
	span.error {
		color: red;
		display: inline-block;
		font-size: 5pt;
	}
	
</style>



</head>
<body>
	<fieldset>
		<legend >新增會員資料</legend>
		<form:form method="POST" modelAttribute="users" enctype='multipart/form-data' id="form1">
			<div>
				<table>
					<tr>
	      				<td>帳號：<br>&nbsp;</td>
		  				<td width='360'><form:input path='account' name='account' id='account'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  					<a href='#'><input type="button" value="檢查帳號" id='repeatAccount'></a><br>&nbsp;	
		     				<span class="sp">8~16位英文字母和數字的組合(不區分大小寫)</span><br/>
		     				<form:errors path='account' cssClass="error"/></td>
		     			<td>
		     				<div id='result0c'></div><br>
		     			</td>
		     		</tr>
		     		<tr>
	      				<td>密碼：<br>&nbsp;</td>
		  				<td width='360'><form:input path='password' type='password' /><br>&nbsp;	
		     				<span class="sp">8~16位英文字母和數字的組合(區分大小寫)</span><br/>
		     				<form:errors path='password' cssClass="error"/></td>
		     		</tr>
		     		<tr>
	      				<td>確認密碼：<br>&nbsp;</td>
		  				<td width='360'><form:input path='dbChkPwd' type='password'/><br>&nbsp;	
		     				<span class="sp">必須與密碼相同</span><br/>
		     				<form:errors path='dbChkPwd' cssClass="error"/></td>
		     		</tr>
   					<tr>
	      				<td>姓名：<br>&nbsp;</td>
		  				<td width='360'><form:input path='name' /><br>&nbsp;	
		     				<form:errors path='name' cssClass="error"/></td>
		     		</tr>
		     		<tr>
	      				<td>身分證字號：<br>&nbsp;</td>
		  				<td width='360'><form:input path='id' /><br>&nbsp;
		  					<span class="sp">第一個英文字母大寫</span><br/>	
		     				<form:errors path='id' cssClass="error"/></td>
		     		</tr>
		     		<tr>
	      				<td>性別：<br>&nbsp;</td>
	   	  				<td><form:radiobuttons path="gender" items='${genderMap}'/><br>&nbsp;
	   	  					<form:errors path="gender"  cssClass="error" /></td>
	   	  			<tr>
	      				<td>生日：<br>&nbsp;</td>
		  				<td><form:input type='text' id='datepicker' path='birthday' /><br>&nbsp;	
		     				<form:errors path='birthday' cssClass="error"/></td>
		     		</tr>
		     		<tr>
	      				<td>E-Mail：<br>&nbsp;</td>
		  				<td width='360'><form:input path='email' /><br>&nbsp;	
		  					<span class="sp">需收認證信，盡量避免使用免費信箱</span><br/>
		     				<form:errors path='email' cssClass="error"/></td>
		     		</tr>
		     		<tr>
	      				<td>地址：<br>&nbsp;</td>
	   	 				<td><form:select path="cityCode.cityCode" id="aaaa">
								<form:option label="請選擇縣市" value="00" id='cityValue'/>
								<form:options  items="${cityList}" itemLabel='city' itemValue='cityCode' />
	   	  					</form:select>&nbsp;
	   	  					<form:select path="userDistrictCode.userDistrictCode" id='cityDistrict' >
								<form:option label="鄉鎮市區" value="1000" />
	   	  					</form:select><br>&nbsp;
	   	  					<form:errors path="cityCode"  cssClass="error"/><br>
	   	  					<form:input path='address' /><br>&nbsp;
	   	  					<form:errors path="address"  cssClass="error"/>
	   	  				</td>
					</tr>
					<tr>
	      				<td>市內電話：<br>&nbsp;</td>
		  				<td width='360'><form:input path='tel'  /><br>&nbsp;	
		  					<span class="sp">市內電話與行動電話至少填寫一項</span><br/>
		     				<form:errors path='tel' cssClass="error"/></td>
		     		</tr>
		     		<tr>
	      				<td>行動電話：<br>&nbsp;</td>
		  				<td width='360'><form:input path='mobile'  /><br>&nbsp;	
		  					<span class="sp">市內電話與行動電話至少填寫一項</span><br/>
		     				<form:errors path='mobile' cssClass="error"/></td>
		     		</tr>
					
				</table>			
			</div>
		</form:form>
	</fieldset>
	<input type='button' value='送出' onclick='chkSubmit()'>
	<input type='button' value='回上一頁' onclick='location.href="<c:url value='../'/> "'>
	
<script>
$(document).ready(function(){ 
    $.datepicker.regional['zh-TW']={
      dayNames:["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
      dayNamesMin:["日","一","二","三","四","五","六"],
      monthNames:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
      monthNamesShort:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
      prevText:"上月",
      nextText:"次月",
      weekHeader:"週"
      };
    $.datepicker.setDefaults($.datepicker.regional["zh-TW"]);
  
    $("#datepicker").datepicker({changeYear: true, changeMonth: true, showMonthAfterYear: true,yearRange:"1920:2021"});
});


var pass = false;
window.onload = function() {
	
	var alink = document.getElementById("repeatAccount");
	var div = document.getElementById('result0c');
	alink.onclick = function() {
		
		var account = document.getElementById("account").value;
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "<c:url value='/user/chkAccount' />", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.send("account=" + account);
		var message = "";
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				var result = JSON.parse(xhr.responseText);
// 				console.log(result);
				if (result.result == "false") {
					message = "<font color='darkgreen' size='-2'>" + "帳號可以使用" + "</font>";
					pass = true;
				} 
				else {
					message = "<font color='red' size='-2'>" + "帳號重複，請重新輸入帳號" + "</font>";
					pass = false;
				}
				console.log(pass);
				
				div.innerHTML =  message ;
			}
		}
	};
	
	var blink = document.getElementById("aaaa");
	blink.onchange = function() {
// 	var $("#aaaa").change(function(){
		var cityDistrict = document.getElementById("cityDistrict");
		
		cityDistrict.options.length = 0;
		cityDistrict.add(new Option("鄉鎮市區", 1000));
		var cityCode = blink.value;
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "<c:url value='/user/getDistrict' />", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.send("cityCode=" + cityCode);
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				var result = JSON.parse(xhr.responseText);
				for (var i = 0; i < result.length; i++) {
					cityDistrict.add(new Option(result[i].district, result[i].userDistrictCode));
				}
			}
		}
	};
// 	 cityCode.trigger("change");
	var aaaa = $("#aaaa");
	aaaa.trigger("change");
// 	alert("bbb");

}

function chkSubmit(){
	
	if(pass == false){
		alert("請先檢查帳號是否可以使用")
	} else {
		if(confirm("確定註冊資料？")){
// 		 	window.alert("註冊成功，請至信箱收取驗證碼機活此帳號")
			$('#form1').submit();
		}
	}
}
	
	
</script>
	
</body>
</html>