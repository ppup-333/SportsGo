<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<c:import url="../headerScript.jsp"/>

<style>
#div_DateType {
	text-align: center;
}

#div2 {
	width: 700px;
}

#queryByType { 
	margin-top: 20px;
/* 	width: 700px; */
/* 	position: absolute; */
/* 	top: 3%; */
/* 	left: 30%; */
} 

/* #queryTable { */
/* 	background-color: rgb(230,230,230); */
/* } */

.orderedTime {
	font-weight:550;
	color: red;
}

#queryTable th, #queryTable td {
	width: 80px;
	height: 10px;
	text-align: center;
}

.th {
	text-align: center;
}

#thPeriod { 
 	width: 100px; 
} 

#queryTable {
	float: right;
}

#chooseDiv p {
	text-align: center;
	margin-bottom: 6px;
}

.chooseTd {
	background-color: blue;
}

/* #chooseDiv input, #chooseDiv select { */
/* 	margin-bottom: 5px; */
/* } */

</style>

</head>
<body>
	<c:import url="../newheader.jsp"/>
	<h2>一般會員預約</h2>
	<form id="createOrderForm" action="createMemberOrder" method="post">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div id="div_DateType">
						日期：
						<input id="date" name="date" type="date" value="${day1}" min="${day1}" max="${day2}">&nbsp;&nbsp;
						類型：	
						<select id="typeSelect" name="typeSelect">
							<option value="0">- 請選擇 -</option>
							<c:forEach var="fieldType" items="${fieldTypeList}">
								<option value="${fieldType.id}">${fieldType.name}</option>
							</c:forEach>
						</select><br>
					</div>
					
					<div id="div2" class="container">
						<div class="row">
							<div class="col-12">
								<div id=queryByType>
						
									<!-- 回傳查詢的資料放入 -->
							
								</div>
							</div>
							<div id="chooseDiv" class="col-12" style="display:none">
								<p>場　地　：
									<select id="fieldSelect" name="fieldId">
										<option value="0">- 請選擇 -</option>
										<c:forEach var="field" items="${fieldList}">			
											<option class="${field.fieldType.id}" value="${field.id}" style="display:none">${field.name}</option>
										</c:forEach>
									</select>
								</p>								
								<p>起始時間：
									<select id="period" name="periodId">
										<option value="0">- 請選擇 -</option>
										<c:forEach var="periods" items="${periodList}">			
											<option value="${periods.id}" style="display:none">${periods.id} 點</option>
										</c:forEach>
									</select>
								</p>
								<p>時　數　：
									<select id="hoursSelect" name="hours">
										<option value="0">- 請選擇 -</option>
										<option value="1" style="display:none">1</option>
										<option value="2" style="display:none">2</option>
										<option value="3" style="display:none">3</option>
									</select>
								</p>
								<hr>
								<p>
									<button id="createSubmit" class="btn btn-primary" type="button">送出</button>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button class="btn btn-secondary" type="reset">清除</button>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</form>				
	
<script>
// <c:if test="${memberOrderCount >= 2}">
// 	var div_DateType = document.getElementById("div_DateType");
// 	div_DateType.innerHTML = "<h4>您的預約已達上限</h4>";
// </c:if>
$("#createSubmit").click(function(){
	Swal.fire({
		icon: "question",
		showCancelButton: true,
		confirmButtonText: "確定",
		cancelButtonText: "取消",
		title: "確定要預約？"
	}).then((result) => {
		if (result.isConfirmed) {
			$("#createOrderForm").submit();			
		}
	});
});


<c:if test="${attendanceStatus == false}">
	var div_DateType = document.getElementById("div_DateType");
	div_DateType.innerHTML = "<h4>預約未到太多次，您的預約功能已被封鎖</h4>";
</c:if>

var typeSelect = document.getElementById("typeSelect");
var hoursSelect = document.getElementById("period");
	
var date = document.getElementById("date");
var queryByType = document.getElementById("queryByType");
var mapData;

$("#typeSelect").change(xhrFunction);
$("#date").change(xhrFunction);
$("#fieldSelect").change(periodFunction);
$("#period").change(hoursFunction);
$("#hoursSelect").change(chooseFunction);

var field;
var period;
var chooseId = [];
var hours;

//重製chooseTd
function resetChooseTd(){
	var chooseTd = [];
	if(chooseId != null){
		for(var i = 0; i < hours; i++){
			chooseId[i] = "td" + (field - 1) + (period + i) ;
			chooseTd[i] = document.getElementById(chooseId[i]);
			chooseTd[i].className = "p-2";
		}
	}
}


function chooseFunction(){
	//重製chooseTd
	resetChooseTd()
	
	field = parseInt(document.getElementById("fieldSelect").value.substr(2));
	period = parseInt(document.getElementById("period").value);
	hours = document.getElementById("hoursSelect").value;
	
	var chooseTd = [];
	
	for(var i = 0; i < hours; i++){
		chooseId[i] = "td" + (field - 1) + (period + i) ;
		chooseTd[i] = document.getElementById(chooseId[i]);
		chooseTd[i].className = "chooseTd p-2";
	}
	
// 	chooseId = "td" + (field - 1) + period ;
// 	var chooseTd = document.getElementById(chooseId);
	
// 	chooseTd.className = "chooseTd p-2";
	
	
}

function xhrFunction(){
	var tid = parseInt(typeSelect.value);
	
	var xhr = new XMLHttpRequest();
	var queryStr = "date=" + date.value + "&typeId=" + typeSelect.value;
	
	console.log(queryStr);
	
	xhr.open("GET","<c:url value='getFieldsOrderJsonByTypeId/"+queryStr+"'/>",true);
	xhr.send();
	
	xhr.onreadystatechange=function(){
		if(xhr.readyState==4&&xhr.status==200){
			displayFields(xhr.responseText);			
		}					
	}
}


function displayFields(responseText){	
	//重製fieldSelect
	var fieldSelect = document.getElementById("fieldSelect");
	fieldSelect.value = "0";
	//重製periodSelect
	periodSelectReset();
	//重製hoursSelect
	hoursSelectReset();
	//重製chooseTd
	resetChooseTd()

	//依據選擇的類型改變feildSelect內容
	var fieldSelectOptions = fieldSelect.getElementsByTagName("option");
	for(var i = 1; i < fieldSelectOptions.length; i++){
		fieldSelectOptions[i].style.display="none";
	}
	var fieldSelectedList = document.getElementsByClassName(typeSelect.value);
	for(var i = 0; i < fieldSelectedList.length; i++){
		fieldSelectedList[i].style.display="inline";
	}
	
	//輸出預約查詢表
	var content;	
	if(typeSelect.value != 0){
		$("#chooseDiv").show();
		mapData = JSON.parse(responseText);	
		
		var fieldList = mapData.fieldList;
		var fieldPeriodList = mapData.fieldPeriodList;
		var orderDetailList = mapData.orderDetailList;
		
		var fieldNameListStr = "";
		for(var i = 0; i < fieldList.length; i++){
			fieldNameListStr += "<th class='th'>" + fieldList[i].name + "</th>";
		}	
		
		var periodOrderListStr = "";
		for(var i = 0; i < fieldPeriodList.length; i++){
			periodOrderListStr += "<tr><td class='p-2' style='background-color:	#FFE66F'>" + fieldPeriodList[i].period + "</td>";
			for(var j = 0; j < fieldList.length; j++){
				periodOrderListStr += "<td class='p-2' style='background-color:	#FFF4C1' id='td" + j + (i+9) + "'></td>"; 
			}		
		}
		
		var orderedList = [];
		
		for(var i = 0; i < fieldList.length; i++){
			if(orderDetailList[i].length > 0){
				for(var j = 0; j < orderDetailList[i].length; j++){			
					orderedList.push("td" + i + orderDetailList[i][j].fieldPeriod.id);				
				}
			}		
		}
		console.log(orderedList);		
		
		content = "<table id='queryTable' class='table table-bordered'>"
				+		"<thead><tr class='bg-warning'><th id='thPeriod' class='th'>時段" + fieldNameListStr + "</thead>" + periodOrderListStr 
				+ "</table>"
		
		queryByType.innerHTML = content;
		
		for(var i = 0; i < orderedList.length; i++){
			var ordered = document.getElementById(orderedList[i]);
			ordered.className = "orderedTime p-2"
			ordered.innerHTML = "(已預定)";
		}
	}else{
		$("#chooseDiv").hide();
		queryByType.innerHTML = "";
	}
	
	
	
// 	$(".deleteButton").click(function() {
// 		if(!confirm("確定要刪除？")){
// 			return false;
// 		}
// 	});
}

function periodFunction(){
	//重製periodSelect
	periodSelectReset();
	//重製hoursSelect
	hoursSelectReset();
	//重製chooseTd
	resetChooseTd()
	
	var fieldSelect = document.getElementById("fieldSelect");	
	if(parseInt(fieldSelect.value) != 0){
		
		//取得所選日期場地的預約清單
		var orderPeriodIdList = getOrderPeriodIdList();
	
		//已預約時段不給人選擇
		var periodSelect = document.getElementById("period");
		var periodOptions = periodSelect.getElementsByTagName("option");
		for(var i = 1; i < periodOptions.length; i++){
			periodOptions[i].style.display="inline";
			for(var j = 0; j < orderDetails.length; j++){
				if(parseInt(periodOptions[i].value) == orderPeriodIdList[j]){
					periodOptions[i].style.display="none";
					break;
				}
			}
		}
	}
	
}

function hoursFunction(){
	//重製hoursSelect
	hoursSelectReset();
	//重製chooseTd
	resetChooseTd()
	
	var hoursSelect = document.getElementById("hoursSelect");
	var periodSelect = document.getElementById("period");
	if(parseInt(periodSelect.value) != 0){		
		//取得所選日期場地的預約清單
		var orderPeriodIdList = getOrderPeriodIdList();
		
		var hoursList = hoursSelect.getElementsByTagName("option");
		hoursList[1].style.display = "inline";
		
		var periodId = parseInt(periodSelect.value);
		if(orderPeriodIdList.length > 0){
			for(var i = 0; i < orderPeriodIdList.length; i++){
				if(periodId + 1 == orderPeriodIdList[i] || periodId == 20){
					hoursList[2].style.display = "none";
					hoursList[3].style.display = "none";			
					break;
				}else if(periodId + 2 == orderPeriodIdList[i] || periodId == 19){
					hoursList[2].style.display = "inline";
					hoursList[3].style.display = "none";
					break;			
				}
				hoursList[2].style.display = "inline";
				hoursList[3].style.display = "inline";		
			}
		}else{
			if(periodId < 19){
				hoursList[2].style.display = "inline";
				hoursList[3].style.display = "inline";
			}else if(periodId == 19){
				hoursList[2].style.display = "inline";
			}			
		}
	}
}

//取得所選日期場地的預約清單
function getOrderPeriodIdList(){
	//將類型相符的場地預約時段丟入orderDetails
	var fieldId = parseInt(document.getElementById("fieldSelect").value.substr(2));
	orderDetails = mapData.orderDetailList[fieldId - 1];
	
	//取出orderDetails內的periodId放入orderPeriodIdList
	var orderPeriodIdList = [];
	for(var i = 0; i < orderDetails.length; i++){
		orderPeriodIdList[i] = orderDetails[i].fieldPeriod.id;
	}
	
	return orderPeriodIdList;
}

//重製periodSelect
function periodSelectReset(){
	//歸零
	var periodSelect = document.getElementById("period");
	periodSelect.value = "0";
	//隱藏選單
	var periodOptions = periodSelect.getElementsByTagName("option");
	for(var i = 1; i < periodOptions.length; i++){
		periodOptions[i].style.display = "none";
	}	
}

//重製hoursSelect
function hoursSelectReset(){
	//歸零
	var hoursSelect = document.getElementById("hoursSelect");
	hoursSelect.value = "0";
	//隱藏選單
	var hoursList = hoursSelect.getElementsByTagName("option");
	for(var i = 1; i < hoursList.length; i++){
		hoursList[i].style.display = "none";
	}
}


</script>
</body>
</html>