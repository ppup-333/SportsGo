<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>activityInsert</title>


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

$("#oneclick1").on("click",function(){
		$("#AN").val("羽球比賽");
		$("#AC").val(250);
		$("#AM").val(50);
		$("#pl").val("BM01");		
		$("#dateend").val("2021-05-14");
		$("#actIntro").val("✨ DAIKIN超級達克盃✨ 火熱報名中🔥🔥				球友們站出來! 一起創造最熱血的羽球狂潮!				無論是你是球隊還是休閒玩家 #這戰一定要打!				由中華羽協共同主辦的「新指標賽事」				5/13-14決勝台北體育館~引爆你心中的羽球魂!				組別涵蓋-企業組、 社會組、羽委會組跟學生組，賽制兼具團體與個人，愛羽球的通通戰起來!				只要報名就送VICTOR賽事紀念衣!超值好康手刀報起來!");
	});
$("#oneclick2").on("click",function(){
	$("#AN").val("桌球比賽");
	$("#AC").val(300);
	$("#AM").val(50);
	$("#pl").val("TA01");		
	$("#dateend").val("2021-05-18");
	$("#TE").val("17:00");
	$("#actIntro").val("在一局比賽中，先得 11 分的一方為勝方； 10 比 10 平手後，先多得 2 分的一方為勝方。通常在國際正式比賽，單項賽（單打、雙打）採用七局四勝制，團體賽中的單打或雙打採用五局三勝制。在巡迴公開賽中的雙打雖然亦為單項賽，但採用五局三勝制。");
});
function checkName(){
	if($("#AN").val()==""){
			$("#aName").append(spImageIncorrect);
			return false;
		}
	return true;
}
function checkCost(){
	 let re=new RegExp("^([1-9][0-9]*)$");
	if($("#AC").val()==""){
		$("#aCost").append(spImageIncorrect);
		return false;	
		}else{
			if(re.test($("#AC").val())){
                return true;
            }else{
            	$("#aCost").append(spImageIncorrect+"費用必須大於0");
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
.courseInsertTable{
	border-collapse: collapse;
	border: 2px solid #D0D0D0;
	border-right: 1px solid #D0D0D0;
	margin-left: auto;
	margin-right: auto;
}

.courseInsertTable tr td:first-child {
   	padding: 20px;
	background-color: #D2E9FF;
	border-right: 1px solid #D0D0D0;
}


.courseInsertTable tr td:last-child {
	padding: 20px;
	background-color: #66B3FF;
	border-right: 1px solid #D0D0D0;
}
#oneclick1,#oneclick2{
margin:10px;
}
</style>
</head>
<body>
	<button id="oneclick1">一鍵輸入1</button><button id="oneclick2">一鍵輸入2</button>
	<form id="insert" action="/sport/activityInsertImpl" method="post"  enctype="multipart/form-data">
		<table class="courseInsertTable" border="1" style="text-align: center;">
		<tr><td>負責人: <td> <input type="text" name="account" style="display:none;" value="${account}"/>${account}
		<tr><td>活動名稱: <td><input type="text" name="actName" id="AN" maxlength="10"  required/><span id="aName"></span>
		<tr><td>活動費用: <td><input type="text" name="actCost" id="AC" maxlength="5" required /><span id="aCost"></span>
		<tr><td>活動限制人數: <td><input type="text" name="actMaxNum" id="AM" maxlength="4"  required/><span id="aMaxNum"></span>
		<tr><td>活動開始日期: <td><input type="text" name="DateStart" style="color:gray" value="${ymd}"  readOnly/>
		<tr><td>活動結束日期: <td><input type="date" name="DateEnd"  id="dateend" value="${ymd}"  min="${ymd}"  />
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
        	<c:forEach var="item1" items="${fieldList}" varStatus="status">
						<option value="${item1.id}">${item1.name}</option>
						</c:forEach>
        </select>
		<tr><td>活動介紹: <td><textarea id="actIntro" name="actIntroduce" rows="10" cols="40"></textarea>
		<tr><td>活動預覽圖: <td><input type="file" name="actPicture"/>
		</table>
	</form>
	<button type="button" id="sub">送出</button>
</body>
</html>