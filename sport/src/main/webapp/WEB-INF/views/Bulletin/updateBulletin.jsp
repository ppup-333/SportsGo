<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta charset="UTF-8">

</head>
<style type="text/css">
img[src=""], img:not([src]) {
	opacity: 0;
}

span.error {
	color: red;
	display: inline-block;
	font-size: 5pt;
}

textarea {
	width: 300px;
	height: 250px;
}
</style>
<script>
	function checkForm(){
		let flag1 = false, flag2 = false;
		var frm = document.forms["updateForm"];
		let title = frm.title.value;
		let contents = frm.contents.value;
		let className = document.getElementById("className").value;
		let subtitle = frm.subtitle.value;
		if(title == ""){
			alert("請輸入公告標題");
		}else if(contents == ""){
			alert("請輸入公告內容");
		}else if(subtitle == ""){
			alert("請輸入副標題");
		}else if(className == "-1"){
			alert("請選擇公告分類");
		}else{
			flag1 = true;
		}
		
		if(flag1 == true){
			contents = contents.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/\s/g, '&nbsp;');
			subtitle = subtitle.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/\s/g, '&nbsp;');
			document.forms['updateForm'].contents.value = contents;
			document.forms['updateForm'].subtitle.value = subtitle;
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
	<c:import url="../header.jsp" />
	<div class="container">
		<fieldset>
			<legend>更新公告</legend>
			<form:form name="updateForm" method="POST" modelAttribute="bulletin"
				enctype='multipart/form-data'>
				<div class="form-group">
					<label for="BulletinTitle">公告標題：</label>
					<form:input id="BulletinTitle" name="title" path='title'
						class="form-control" aria-describedby="titleHelp"
						placeholder="請輸入標題" />
					<form:errors path='title' cssClass="error" />
					<!-- 					<small id="titleHelp" class="form-text text-muted"></small> -->
				</div>
				<div class="form-group">
					<label for="BulletinSubTitle">副標題：</label>
					<form:textarea id="BulletinSubtitle" name="subtitle"
						path='subtitle' class="form-control"
						aria-describedby="subtitleHelp" placeholder="請輸入副標題" rows="2"></form:textarea>
					<form:errors path='subtitle' cssClass="error" />
					<!-- 					<small id="titleHelp" class="form-text text-muted"></small> -->
				</div>
				<div class="form-group">
					<label for="BulletinContent">公告內容：</label>
					<form:textarea id="BulletinContent" name="contents" path="contents"
						class="form-control" aria-describedby="subtitleHelp"
						placeholder="請輸入公告內容" rows="3"></form:textarea>
					<form:errors path='contents' cssClass="error" />
				</div>
				<div class="form-group">
					<label for="className">公告分類:</label>
					<form:select id="className" path="class_id.id" class="form-control"
						aria-describedby="classNameHelp">
						<form:option label="請挑選公告分類" value="-1" />
						<form:options items="${classList}" itemLabel='name' itemValue='id' />
					</form:select>
					<form:errors path="class" cssClass="error" />
				</div>

				<div class="form-group">
					<label for="imgInput">上傳公告圖片</label>
					<form:input id="imgInput" class="form-control-file"
						path="productImage" type='file' value="新增圖片" />
					<form:errors path="productImage" cssClass="error" />
					
					<c:choose>
					<c:when test='${bulletin.image != null}'>
						<img id='previewImg' width='180' height='216'
							src='<c:url value="/Bulletin/picture/${bulletin.id }"/>' />
					</c:when>
					<c:otherwise>
						<img width='180' height='216' id="previewImg"/>
					</c:otherwise>
				</c:choose>
				</div>
				
				<input type='button' onclick="resetImg(${bulletin.id});"
					value='清空圖片' />


				<input type='button' value="更新公告" onclick='checkForm();' />


			</form:form>
		</fieldset>
	</div>
	<br>
	<div align="center">
		<a
			href="<c:url value='/Bulletin/showBulletinContent/${bulletin.id}'/> ">回前頁</a>
	</div>
	<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
</body>
</html>