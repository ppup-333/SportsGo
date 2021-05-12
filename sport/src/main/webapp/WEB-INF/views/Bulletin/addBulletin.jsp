<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<c:import url="../headerScript.jsp"/>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.16.3/sweetalert2.js" type="text/javascript"></script> -->


<meta charset="UTF-8">
<%-- <link rel='stylesheet' href="<c:url value='/css/style.css' />" type="text/css" /> --%>
</head>
<style type="text/css">
.box{
	font-family: 'Noto Sans TC';
	margin-top:50px;
	margin-bottom:100px;
}
img[src=""],img:not([src]){
            opacity:0;
        }

span.error {
	color: red;
	display: inline-block;
	font-size: 5pt;
}
.container{
	
}
#className{
	width:180px;
}
.title-style{
	background-color:#17A2B8;
	color:white;
}
.uploadBtn{
	margin-top:10px;
}
</style>
<script>
	function checkForm(){
		let flag1 = false, flag2 = false;
		var frm = document.forms["insertForm"];
		let title = frm.title.value;
		let contents = frm.contents.value;
		let className = document.getElementById("className").value;
		let subtitle = frm.subtitle.value;
		if(title == ""){
			Swal.fire({
				title:"請輸入公告標題",
				icon:'warning',
			})
		}else if(contents == ""){
			Swal.fire({
				title:"請輸入公告內容",
				icon:'warning',
			})
		}else if(subtitle == ""){
			Swal.fire({
				title:"請輸入副標題",
				icon:'warning',
			})
		}else if(className == "-1"){
			Swal.fire({
				title:"請選擇公告分類",
				icon:'warning',
			})
		}else{
			flag1 = true;
		}
		
		if(flag1 == true){
// 			contents = contents.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/\s/g, '&nbsp;');
			contents = contents
// 			subtitle = subtitle.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/\s/g, '&nbsp;');
			subtitle = subtitle
			document.forms['insertForm'].contents.value = contents;
			document.forms['insertForm'].subtitle.value = subtitle;
			
			Swal.fire({
				title:'確定發布公告嗎?',
				icon:'question',
		      	showCancelButton: true, 
		      	confirmButtonColor: '#3085d6',
		      	cancelButtonColor: '#d33',
		      	confirmButtonText: '確定',
		      	cancelButtonText:'取消',
			}).then(result => {
				if(result.value){
					frm.submit();
				}
			})
			
			
			
			
		}
	}
	$(document).ready(function(){
		$("#imgInput").change(function(){
			readURL(this);
		});
	});
	
	function readURL(input){
// 		console.log("11111");
		  if(input.files && input.files[0]){
		    var reader = new FileReader();
		    reader.onload = function (e) {
		       $("#previewImg").attr('src', e.target.result);
		       $("#previewImg").toggle(500);
		    }
		    reader.readAsDataURL(input.files[0]);
		  }
	}
	
	function resetImg(){
		console.log('resetImg');
		$('#imgInput').val('');
		$('#previewImg').attr('src','');
		$("#previewImg").toggle(500);
	}
	
	
	function checkEdit(){
		let flag1 = false, flag2 = false;
		var frm = document.forms["insertForm"];
		let title = frm.title.value;
		let contents = frm.contents.value;
		let className = document.getElementById("className").value;
		let subtitle = frm.subtitle.value;
		
		if(title != "" || contents != "" || className != "-1" || subtitle != ""){
			Swal.fire({
				title:"正在編輯中，確定要返回嗎?",
				text:"返回後不會保存已編輯內容!",
				icon:'warning',
				showCancelButton:true,
				confirmButtonColor: '#3085d6',
		      	cancelButtonColor: '#d33',
		      	confirmButtonText: '確定',
		      	cancelButtonText:'取消',
			}).then(result => {
				if(result.value){
					window.location.href = "/sport/Bulletin/showAllBulletin";
				}
			})
		}else{
			window.location.href = "/sport/Bulletin/showAllBulletin";
		}
	}
	
	
</script>


<body>
<c:import url="../newheaderM.jsp"/>
	<div class="box">
		<div class="container title-style">
		<h2 style="font-family: 'Noto Sans TC', sans-serif;color:white">新增公告</h2>
		</div>
		<div class="container">
			<div class="formcontainer">

			<fieldset>
			
			<form:form id="insertForm" name="insertForm" method="POST" modelAttribute="bulletin" enctype='multipart/form-data'>
					<div class="form-group">
						<label for="BulletinTitle">公告標題：</label>
						<form:input id="BulletinTitle" name="title" path='title' class="form-control" aria-describedby="titleHelp" placeholder="請輸入標題"/> 
						<form:errors path='title' cssClass="error" />
	<!-- 					<small id="titleHelp" class="form-text text-muted"></small> -->
					</div>
					<div class="form-group">
						<label for="BulletinSubTitle">副標題：</label>
						<form:textarea id="BulletinSubtitle" name="subtitle" path='subtitle' class="form-control" aria-describedby="subtitleHelp" placeholder="請輸入副標題" rows="2"></form:textarea> 
						<form:errors path='subtitle' cssClass="error" />
	<!-- 					<small id="titleHelp" class="form-text text-muted"></small> -->
					</div>
					
					<div class="form-group"> 
						<label for="className">公告分類:</label>
						<form:select id="className" path="class_id.id" class="form-control" aria-describedby="classNameHelp" >
							<form:option label="請挑選公告分類" value="-1" />
							<form:options items="${classList}" itemLabel='name' itemValue='id' />
						</form:select> <form:errors path="class" cssClass="error" />
					</div>
					<div class="form-group">
						<label for="BulletinContent">公告內容：</label>
						<form:textarea id="BulletinContent" name="contents" path="contents" class="form-control" aria-describedby="subtitleHelp" placeholder="請輸入公告內容" rows="6" ></form:textarea>
						<form:errors path='contents' cssClass="error" />
					</div>
					<div class="form-group">
					
						<c:choose>
							<c:when test='${bulletin.image != null}'>
								<img id='previewImg' width='214' height='250'
									src='<c:url value="/Bulletin/picture/${bulletin.id }"/>' />
							</c:when>
							<c:otherwise>
								<img width='214' height='250' id="previewImg" style="display:none"/>
							</c:otherwise>
						</c:choose>		
					
						<br>
					
						<div class="btn-group uploadBtn" role="group">
						<label class="btn btn-info">
							<form:input id="imgInput" class="form-control-file"  path="productImage" type='file' value="" style="display:none;"/>
							<i class="fas fa-image"></i> 上傳圖片
						</label>
						<form:errors path="productImage" cssClass="error" />
					
						<label class="btn btn-info">
							<input type='button' onclick="resetImg(${bulletin.id});" style="display:none;float:left" />
							<i class="fas fa-times-circle"></i>清空圖片
						</label>
						</div>
					</div>
					</form:form>
				</fieldset>	
			</div>
					
	
				
			<hr>
			<div style="float:right;">
			<a class="btn btn-secondary" onclick='checkForm();' >新增公告</a>
			<a class="btn btn-secondary" onclick="checkEdit();"  >返回</a>
			</div>
		</div>
		</div>
	
	
	
	
	
	
	
	
	
	
	
	
<!-- 	<fieldset> -->
<!-- 		<legend>新增公告</legend> -->
		
<%-- 		<form:form id="insertForm" name="insertForm" method="POST" modelAttribute="bulletin" enctype='multipart/form-data'> --%>
			
<!-- 			<Table style="align-self: center;"> -->
<!-- 				<tr> -->
<!-- 					<td>公告標題：<br>&nbsp;</td> -->
<%-- 					<td width='360'><form:input name="title" path='title' /><br>&nbsp;  --%>
<%-- 					<form:errors --%>
<%-- 							path='title' cssClass="error" /></td> --%>
<!-- 					<td>公告內容：<br>&nbsp;</td> -->
<%-- 					<td width='360'><form:textarea name="contents" path="contents" /><br>&nbsp; --%>
<%-- 						<form:errors path='contents' cssClass="error" /></td> --%>
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>公告分類:<br>&nbsp;</td> -->
<%-- 					<td><form:select id="className" path="class_id.id"> --%>
<%-- 							<form:option label="請挑選" value="-1" /> --%>
<%-- 							<form:options items="${classList}" itemLabel='name' --%>
<%-- 								itemValue='id' /> --%>
<%-- 						</form:select><br>&nbsp; <form:errors path="class" cssClass="error" /></td> --%>
<!-- 					<td> -->
<%-- 						<form:input id="imgInput"  path="productImage" type='file' value="新增圖片" /><br> --%>
<%-- 						<form:errors path="productImage" cssClass="error" /> --%>
<!-- 						圖片預覽:<img width='120'height='144' id="previewImg" /> -->
<!-- 						<input type='button' onclick="resetImg();" value='清空圖片' /> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td colspan='4' align='center'><br> -->
<!-- 					<input type='button' value="發布公告" onclick='checkForm();' /> -->
<!-- 				</tr> -->
<!-- 			</Table> -->
			
<%-- 		</form:form> --%>
		
<!-- 	</fieldset> -->
</body>
</html>