<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>courseInsert</title>


<script type="text/javascript">


var spImageIncorrect="<img src='images/incorrect.png'  width='10'/>";

$(document).ready(function(){
	$("#sub").click(function(){	
		$("span").empty();
		if(checkName()&checkCost()&checkMaxNum()){
			$("#insert").submit();
		}else{
			alert("請確認資料是否有誤");
		}
		
	});
	
	$("#TS").change(function(){
		
		if($("#TS").val()=="09:00"|$("#TS").val()=="10:00"){
			$("#TE").empty();
			$("#TE").append("<option value='12:00'>12:00</option><option value='17:00'>17:00</option>");
		}
		
		if($("#TS").val()=="13:00"|$("#TS").val()=="14:00"){
			$("#TE").empty();
			$("#TE").append("<option value='17:00'>17:00</option>");
		}
	});
});
function checkName(){
	if($("#AN").val()==""){
			$("#aName").append(spImageIncorrect);
			return false;
		}
	return true;
}
function checkCost(){
	 let re=new RegExp("^(0|[1-9][0-9]*)$");
	if($("#AC").val()==""){
		$("#aCost").append(spImageIncorrect);
		return false;	
		}else{
			if(re.test($("#AC").val())){
                return true;
            }else{
            	$("#aCost").append(spImageIncorrect);
        		return false;	
            }
		}
	
}
function checkMaxNum(){
	let re=new RegExp("^(0|[1-9][0-9]*)$");
	if($("#AM").val()==""){
			$("#aMaxNum").append(spImageIncorrect);
			return false;
		}else{
			if(re.test($("#AM").val())){
                return true;
            }else{
            	$("#aMaxNum").append(spImageIncorrect);
        		return false;	
            }
			
		}
}
</script>
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
</style>
</head>
<body>
	<form id="insert" action="/springsport/activityInsertImpl" method="post"  enctype="multipart/form-data">
		<table border="1" style="text-align: center;">
		<tr><td>負責人: <td> <input type="text" name="account" style="display:none;" value="${account}"/>${account}
		<tr><td>活動名稱: <td><input type="text" name="actName" id="AN" maxlength="10"  required/><span id="aName"></span>
		<tr><td>活動費用: <td><input type="text" name="actCost" id="AC" maxlength="5" required /><span id="aCost"></span>
		<tr><td>活動限制人數: <td><input type="text" name="actMaxNum" id="AM" maxlength="4"  required/><span id="aMaxNum"></span>
		<tr><td>活動開始日期: <td><input type="date" name="DateStart" />
		<tr><td>活動結束日期: <td><input type="date" name="DateEnd"   />
		<tr><td>活動開始時間: <td><select name="TimeStart" id="TS">
            <option value="09:00">09:00</option>
            <option value="10:00">10:00</option>
            <option value="13:00">13:00</option>
            <option value="14:00">14:00</option>
        </select>
		<tr><td>活動結束時間: <td><select name="TimeEnd" id="TE">
            <option value="12:00">12:00</option>
            <option value="17:00">17:00</option>
        </select>
        <tr><td>活動場地: <td><select name="place" id="pl">
        	 <option value="1F">1F</option>
        	 <option value="2F">2F</option>
        	 <option value="3F">3F</option>
        	 <option value="4F">4F</option>
        </select>
		<tr><td>活動介紹: <td><textarea name="actIntroduce" rows="30" cols="40"></textarea>
		<tr><td>活動預覽圖: <td><input type="file" name="actPicture"/>
		</table>
	</form>
	<button type="button" id="sub">送出</button>
</body>
</html>