<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>

<c:import url="../headerScript.jsp"/>
<meta charset="UTF-8">
<title>更新會員資料</title>
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
	
 	.f1{ 
 	font-size:15px; 
/*  	width:550px;  */
 	margin-left:620px; 
 	margin-top:50px;
 	} 

 	.d1{ 
 	margin:20px 620px; 
 	} 
</style>

</head>
<body>
<c:import url="../newheader.jsp"/>
	<fieldset class='f1'>
		<legend >修改會員資料</legend>
		<form:form method="POST" modelAttribute="users" enctype='multipart/form-data' id="form1">
			<div>
				<table>
					<tr>
	      				<td>帳號：<br>&nbsp;</td>
		  				<td width='360'><form:input path='account' name='account' id='account' readonly="true"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		     			<td>
		     				<div id='result0c'></div><br>
		     			</td>
		     		</tr>
   					<tr>
	      				<td>姓名：<br>&nbsp;</td>
		  				<td width='360'><form:input path='name' /><br>&nbsp;	
		     				<form:errors path='name' cssClass="error"/></td>
		     		</tr>
		     		<tr>
	      				<td>身分證字號：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;</td>
		  				<td width='360'><form:input path='id' readonly="true"/><br>&nbsp;
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
	   	  					<form:errors path="address"  cssClass="error"/></td>
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
	<div class='d1'>
		<input type='button' value='送出' onclick='dataSubmit()'>&nbsp;&nbsp;
		<input type='button' value='回上一頁' onclick='location.href="userResult"'>
	</div>
	
	
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

window.onload = function() {
	
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

function dataSubmit(){
	if(confirm("確定修改資料？")){
		$('#form1').submit();
	}
}


</script>
	
	
	
	
</body>
</html>