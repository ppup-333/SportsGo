<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<%-- <c:import url="../headerScript.jsp"/> --%>
<!-- <!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<!-- <meta charset="UTF-8"> -->
<!-- <title>teacherUpdate</title> -->
<style>

    .st1{
        border-bottom: 3px dashed gray;
        margin: 20px;
        padding-bottom: 10px;
        width: 500px;
         
        
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
        margin-left: 30px;
         margin-right:auto;
        margin-left:auto;
    }
    fieldset{
        width: 600px;
        margin: 20px;
        border: 1px dashed green;
        margin-right:auto;
        margin-left:auto;
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
    .main_body{

text-align:center;
}

    </style>
<!-- </head> -->
<!-- <body> -->
<!-- <c:import url="../newheaderM.jsp" /> -->
<div class="main_body">


<form  id="update" method="post" action="../sport/teacherUpdateImpl" enctype="multipart/form-data">
<div>
 			<h1>修改教師資料</h1>
 		 <input name="teacherId" value="${teacher.teacherId}" style="display:none"/>
 		   <div class="st1">
            <label for="account" class="t1">老師姓名: </label><input id="teacherName" name="teacherName" value="${teacher.teacherName}"/>
       		 <span id="spname"></span>
        </div>
        
          <div class="st1">
          <c:choose>
          <c:when test="${teacher.gender=='1'}">
<c:set var="gender" value="男"></c:set>
<label for="account" class="t1">性別: </label>男:<input type="radio" id="boy" name="gender" value="1" checked>
  											女:<input type="radio" id="girl" name="gender" value="0">
</c:when>
<c:otherwise>
<c:set var="gender" value="女"></c:set>
<label for="account" class="t1">性別: </label>男:<input type="radio" id="boy" name="gender" value="1" >
  											女:<input type="radio" id="girl" name="gender" value="0" checked>
</c:otherwise>
</c:choose>          
            
        </div>
         <div class="st1">
            <label for="account" class="t1">電話: </label><input id="phone" name="phone" value="${teacher.phone}"/>
            <span id="spphone"></span>
        </div>
        <div class="st1">
            <label for="account" class="t1">薪水: </label><input id="salary" name="salary" value="${teacher.salary}"/>
        </div>
        <div class="st1">
            <label for="account" class="t1">照片: </label>
            <img  src="data:image/png;base64,${base64data}" id="picture" width='300px' height='300px'/>
          
        </div>
         <div class="st1">
           <label for="account" class="t1">更改照片: </label>
            <input  type="file" id="teacherPicture" name="teacherPicture"/>
        </div>
</div>
</form>
   <button type="button" class="back">上一步</button>
   <button id="updateValue">修改</button>
   </div>
   
   <script type="text/javascript">
   $(".back").on("click",function(){
	   let xhr=new XMLHttpRequest();
		xhr.open("GET","/sport/teacherHome",true);
		 xhr.send();
		 xhr.onreadystatechange=function(){
			if(xhr.readyState==4&&xhr.status==200){
			let response=xhr.responseText;
			 $("body").empty();
		     $("body").append(response);
			}
		 }	
	});
   var spImageIncorrect="<img src='images/incorrect.png'  width='10'/>";
   $("#updateValue").on("click",function(){
	   let isNull=true;
	   
	   
	   if($("#teacherName").val()==""){
			isNull=false;
			$("#spname").css("display", "inline");
			$("#spname").css("visibility", "visible");
			$("#spname").append(spImageIncorrect);
		}
	   
	   
	   //電話號碼正規
	   let re=new RegExp("^09[0-9]{8}$");
	   
	   
	   if(re.test($("#phone").val())){
			
		}else{
			isNull=false;
			$("#spphone").css("display", "inline");
			$("#spphone").css("visibility", "visible");
			$("#spphone").append(spImageIncorrect);
		}
	   
	   /*if($("#teacherPicture").val()==""){
		   
		   console.log($("#picture").attr('src'));
		   let input=document.createElement("input");
			let picture=$("#picture").attr('src');
			input.setAttribute("name","picture");
			input.setAttribute("value",picture);
			input.style.display="none";
			$("#teacherPicture").append(input);
		   
	   }*/
	   if(isNull){
			if(confirm("確認資料無誤即將送出")){
					$("#update").submit();
			}
		}
   });
   </script>
<!-- </body> -->
<!-- </html> -->