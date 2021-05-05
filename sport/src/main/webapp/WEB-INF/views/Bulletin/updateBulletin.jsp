<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form" %>

<html>
<head>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta charset="UTF-8">

</head>
<style type="text/css">

	img[src=""],img:not([src]){
            opacity:0;
        }

   span.error {
	color: red;
	display: inline-block;
	font-size: 5pt;
}
	textarea{
		width:300px;
		height:250px;
	}
</style>
<script>
	function checkForm(){
		let flag1 = false, flag2 = false;
		var frm = document.forms["updateForm"];
		let title = frm.title.value;
		let contents = frm.contents.value;
		let className = document.getElementById("className").value;
		if(title == ""){
			alert("請輸入公告標題");
		}else if(contents == ""){
			alert("請輸入公告內容");
		}else if(className == "-1"){
			alert("請選擇公告分類");
		}else{
			flag1 = true;
		}
		
		if(flag1 == true){
			contents = contents.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/\s/g, '&nbsp;');
			document.forms['updateForm'].contents.value = contents;
			frm.submit();
		}
	}
	
	$(document).ready(function(){
		console.log("ready")
		$("#imgInput").change(function(){
			console.log("input change");
			readURL(this);
		});
	});
	
	
	function readURL(input){
		  if(input.files && input.files[0]){
		    var reader = new FileReader();
		    reader.onload = function (e) {
		       $("#previewImg").attr('src', e.target.result);
		    }
		    reader.readAsDataURL(input.files[0]);
		  }
	}
	
	function resetImg(id){
		console.log('resetImg');
		$('#updatePreview').remove();
		$('#imgInput').val('');
		$('#previewImg').attr('src','');
		$.ajax({
			url: "/sport/Bulletin/resetPicture/" + id,
			type:'POST',
			dataType:'html',
			success:function(result){
				console.log("success delete");
			}
		});
	}
</script>


<body>
<c:import url="../header.jsp"/>
<fieldset>
	<legend >更新公告</legend>
	<form:form name="updateForm"  method="POST" modelAttribute="bulletin" enctype='multipart/form-data'>
	<Table style="align-self: center;"  >
	   <tr>
	      <td>公告標題<br>&nbsp;</td>
		  <td  width='360'><form:input name="title" path='title' /><br>&nbsp;	
		      <form:errors path='title' cssClass="error"/>
		  </td>
		  <td>公告內容：<br>&nbsp;</td>
	      <td  width='360'>
	      	<form:textarea name="contents" path="contents"/><br>&nbsp;	
		      <form:errors path='contents' cssClass="error"/>
		  </td>
	   </tr>
	   <tr>
	      <td>公告分類：<br>&nbsp;</td>
	   	  <td>
			<form:select id="className" path="class_id.id" >
				<form:option value="-1" label="請挑選" />
				<form:options  items="${classList}"
	   	  	       itemLabel='name' itemValue='id'/>
	   	  	</form:select><br>&nbsp;
	   	  <form:errors path="class"  cssClass="error"/>
	   	  </td>
	   	  
	   	  <tr>
			<td>
				<form:input id='imgInput' path="productImage" type='file' /><br>
				<form:errors path="productImage" cssClass="error" />
				<c:choose>
					<c:when test='${bulletin.image != null}'>
						<p id='updatePreview'>更新公告圖片為</p>
						<img id='previewImg' width='120' height='144' src='<c:url value="/Bulletin/picture/${bulletin.id }"/>'/>
					</c:when>
					<c:otherwise>
						<img width='120'height='144' id="previewImg" />
					</c:otherwise>
				</c:choose>
				<input type='button' onclick="resetImg(${bulletin.id});" value='清空圖片' />
			</td>
			<td colspan='4' align='center'><br>&nbsp; 
				<input type='button' value="更新公告" onclick='checkForm();' />
			</td>
		</tr>
		<h1>${bulletin.date }</h1>
	</Table>
	</form:form>
</fieldset>
<br>
<div align="center">
<a href="<c:url value='/Bulletin/showAllBulletin'/> " >回前頁</a>
</div>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</body>
</html>