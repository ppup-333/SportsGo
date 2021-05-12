<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>manageActUpdate</title>

<style>

    .st1{
        border-bottom: 3px dashed gray;
        padding-bottom: 10px;
        width: 400px;
        margin:10px;
     
    }   
    .sub{
        margin: 20px;
        text-align: center;
        width: 450px;
    }
    .t1 {
        width: 100px;
        float: left;
        text-align: right;
    }
    .st1{
        background-color: rgb(216, 215, 215);
        border-radius: 6px;
        border: white;
   
        
    }
    fieldset{
        width: 600px;
     
    }
    legend{
        color: blue;
    }
    select{
        margin-left: 30px;
    }
    
    .fl2{
        float: left ;
    }
    </style>
    
<script type="text/javascript">

var spImageIncorrect="<img src='images/incorrect.png'  width='10'/>";

$("#goUpdate").click(function(){	
	$("span").empty();
	if(checkName()&checkCost()&checkMaxNum()){
		$("#update").submit();
	}else{
		alert("請確認資料是否有誤");
	}
	
});

$("#ds").on("change",function(){
		  let ds=$("#ds").val();
			$("#de").attr("min",ds);
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
</head>
<body>
	<form  id="update" method="post" action="../sport/actUpdateImpl" enctype="multipart/form-data">
		<fieldset>
            <legend>修改活動資料</legend>
         <input name="actId" value="${activityMap.actId}" style="display:none"/>
          <div class="st1">
            <label for="account" class="t1">負責人: </label><span>${activityMap.account}</span>
            <input type="text" name="account" value="${activityMap.account}"  style="display:none"/>
        </div>
        <div class="st1">
            <label for="account" class="t1">活動名稱: </label>
            <input type="text" name="actName" id="AN" maxlength="10" value="${activityMap.actName}" required/>
            <span id="aName"></span>
        </div>
        
         <div class="st1">
            <label for="account" class="t1">活動費用: </label>
            <input type="text" name="actCost" id="AC" maxlength="5" value="${activityMap.actCost}" required />
            <span id="aCost"></span>
        </div>
        
         <div class="st1">
            <label for="account" class="t1">最大學生數量: </label>
            <input type="text" name="actMaxNum" id="AM" maxlength="4" value="${activityMap.actMaxNum}" required/>
            <span id="aMaxNum"></span>
        </div>
          <div class="st1">
            <label for="account" class="t1">開課日期: </label>
            <input type="date" id="ds" name="DateStart" value="${activityMap.DateStart}"  min="${nowDate}">
        </div>
        <div class="st1">
            <label for="account" class="t1">結束日期: </label>
            <input type="date" id="de" name="DateEnd" value="${activityMap.DateEnd}" min="${activityMap.DateStart}">
        </div>
         <div class="st1">
            <label for="account" class="t1">活動開始時間:</label>
            <select name="TimeStart" id="TS">
            <c:if test="${activityMap.TimeStart=='09:00'}">
            	<option value="09:00">09:00</option>
            	<option value="10:00">10:00</option>
            	<option value="13:00">13:00</option>
            	<option value="14:00">14:00</option>
            </c:if>
            <c:if test="${activityMap.TimeStart=='10:00'}">
            	<option value="10:00">10:00</option>
            	<option value="13:00">13:00</option>
            	<option value="14:00">14:00</option>
            </c:if>
            <c:if test="${activityMap.TimeStart=='13:00'}">
            	<option value="13:00">13:00</option>
            	<option value="14:00">14:00</option>
            </c:if>
            <c:if test="${activityMap.TimeStart=='14:00'}">
            	<option value="14:00">14:00</option>
            </c:if>
            <!-- <option value="${activityMap.TimeStart}">${activityMap.TimeStart}</option> -->
            </select>
        </div>
        <div class="st1">
            <label for="account" class="t1">活動結束時間:</label>
            <select name="TimeEnd" id="TE">
            	<c:if test="${activityMap.TimeEnd=='12:00'}">
            		<option value="12:00">12:00</option>
            		<option value="17:00">17:00</option>
            	</c:if>
            	<c:if test="${activityMap.TimeEnd=='17:00'}">
            		<option value="12:00">12:00</option>
            		<option value="17:00">17:00</option>
            	</c:if>
            </select>
        </div>
        <div class="st1">
        <label for="account" class="t1">活動場地: </label>
         	<select name="place" id="pl">
        	<c:forEach var="item1" items="${fieldList}" varStatus="status">
					<option value="${item1.id}">${item1.name}</option>
			 </c:forEach>
       		 </select>
        </div>
       
         <div class="st1">
           <label for="account" class="t1">活動介紹: </label>
            <textarea rows="10" cols="30" name="actIntroduce">${activityMap.actIntroduce}</textarea>
        </div>
        <div class="st1">
         	<label for="account" class="t1">活動照片: </label>
         	<img src="data:image/png;base64,${base64data}" width='100px' height='100px'/>
        </div>
        <div class="st1">
         	 <label for="account" class="t1">更改照片: </label>
            <input  type="file" id="actPicture" name="actPicture"/>
        </div>
    </fieldset> 
	</form>
	<button id="goUpdate">修改</button>
</body>
</html>