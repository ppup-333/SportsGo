<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>teacherInsert</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<style type="text/css">
table {
	border-collapse: collapse;
	border: 2px solid #D0D0D0;
	border-right: 1px solid #D0D0D0;
	margin-left: auto;
	margin-right: auto;
}

tr td:first-child {
   	padding: 20px;
	background-color: #D2E9FF;
	border-right: 1px solid #D0D0D0;
}


tr td:last-child {
	padding: 20px;
	background-color: #66B3FF;
	border-right: 1px solid #D0D0D0;
}
.main_body{

text-align:center;
}
</style>
<script type="text/javascript">

	var spImageIncorrect="<img src='images/incorrect.png'  width='10'/>";
$(document).ready(function(){

	$(".main_Title").empty();
	$(".main_Title").append("新增老師");
	$("#goTeacherInsert").click(function(){	
		$("span").empty();
		if(checkName()&checkPhone()&checkSalary()){
			if(confirm("確認資料無誤即將送出")){
				$("#insert").submit();
		}
		}else{
			alert("請確認資料是否有誤");
		}
		
	});
	
});

function checkName(){
	if($("#TN").val()==""){
			$("#tName").append(spImageIncorrect);
			return false;
		}
	return true;
}
function checkPhone(){
	 let re=new RegExp("^(0|[1-9][0-9]*)$");
	if($("#TP").val()==""){
		$("#tPhone").append(spImageIncorrect);
		return false;	
		}else{
			   return true;
			/*if(re.test($("#TP").val())){
                return true;
            }else{
            	$("#tPhone").append(spImageIncorrect);
        		return false;	
            }*/
		}
	
}
function checkSalary(){
	let re=new RegExp("^(0|[1-9][0-9]*)$");
	if($("#TS").val()==""){
			$("#tSalary").append(spImageIncorrect);
			return false;
		}else{
			if(re.test($("#TS").val())){
                return true;
            }else{
            	$("#tSalary").append(spImageIncorrect);
        		return false;	
            }
			
		}
}
</script>
</head>
<body>
<c:import url="../headerM.jsp" />
<div  class="main_body">
<form id="insert" method="post" action="/springsport/teacherInsertImpl"  enctype="multipart/form-data">
<table border="1" style="text-align: center;">
		
		<tr><td>老師姓名:<td><input type="text" name="teacherName" id="TN" maxlength="10"/><span id="tName"></span>
		<tr><td>性別<td>男:<input type="radio" id="boy" name="gender" value="1" checked>
  				女:<input type="radio" id="girl" name="gender" value="0">
  		<tr><td>電話<td><input type="text" name="phone" id="TP" maxlength="10"/><span id="tPhone"></span>
  		<tr><td>薪水<td><input type="text" name="salary" id="TS" value="30000"><span id="tSalary"></span>
  		<tr><td>活動預覽圖: <td><input type="file" name="teacherPicture"/>
</table>
</form>
  <button type="button" onclick="window.location.href='/sport/teacherHome'">上一步</button>
<button id="goTeacherInsert">送出</button>
</div>

</body>
</html>