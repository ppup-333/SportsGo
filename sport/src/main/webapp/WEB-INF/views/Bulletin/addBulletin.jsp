<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<meta charset="UTF-8">
<%-- <link rel='stylesheet' href="<c:url value='/css/style.css' />" type="text/css" /> --%>
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
</style>
<script>
	function checkForm(){
		let flag1 = false, flag2 = false;
		var frm = document.forms["insertForm"];
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
			document.forms['insertForm'].contents.value = contents;
			frm.submit();
		}
	}
	$(document).ready(function(){
		$("#imgInput").change(function(){
			readURL(this);
		});
	});
	
	function readURL(input){
		console.log("11111");
		  if(input.files && input.files[0]){
		    var reader = new FileReader();
		    reader.onload = function (e) {
		       $("#previewImg").attr('src', e.target.result);
		    }
		    reader.readAsDataURL(input.files[0]);
		  }
	}
	
	function resetImg(){
		console.log('resetImg');
		$('#imgInput').val('');
		$('#previewImg').attr('src','');
	}

</script>


<body>
	<fieldset>
		<legend>新增公告</legend>
		<form:form id="insertForm" name="insertForm" method="POST" modelAttribute="bulletin" enctype='multipart/form-data'>
			<Table style="align-self: center;">
				<tr>
					<td>公告標題：<br>&nbsp;</td>
					<td width='360'><form:input name="title" path='title' /><br>&nbsp; 
					<form:errors
							path='title' cssClass="error" /></td>
					<td>公告內容：<br>&nbsp;</td>
					<td width='360'><form:textarea name="contents" path="contents" /><br>&nbsp;
						<form:errors path='contents' cssClass="error" /></td>
				</tr>
				<tr>
					<td>公告分類:<br>&nbsp;</td>
					<td><form:select id="className" path="class_id.id">
							<form:option label="請挑選" value="-1" />
							<form:options items="${classList}" itemLabel='name'
								itemValue='id' />
						</form:select><br>&nbsp; <form:errors path="class" cssClass="error" /></td>
					<td>
						<form:input id="imgInput"  path="productImage" type='file' value="新增圖片" /><br>
						<form:errors path="productImage" cssClass="error" />
						圖片預覽:<img width='120'height='144' id="previewImg" />
						<input type='button' onclick="resetImg();" value='清空圖片' />
					</td>
				</tr>
				<tr>
					<td colspan='4' align='center'><br>
					<input type='button' value="發布公告" onclick='checkForm();' />
				</tr>
			</Table>
		</form:form>
	</fieldset>
	<br>
	<div align="center">
		<a href="<c:url value='/'/> ">回前頁</a>
	</div>
</body>
</html>