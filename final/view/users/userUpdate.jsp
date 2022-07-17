<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hobbyCampus</title>
<link href="img/main.ico" rel="shortcut icon" type="image/x-icon">
	<!--BootStarp-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <!-- JQuery -->
   	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
   
    <link rel="stylesheet" href="/hobbycampus/css/main.css">
    
  <style>	
		.form-userUp {
			width: 100%;
			max-width: 400px;
			padding: 15px;
			margin: auto;
			align-items: center;
			text-align: center;
		}
	.form-userUp img{width:300px;
		  height:150px;
		  object-fit:fill;
	  }  
	  
 .form-userUp a{text-decoration:none; color:black;}  
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
<div class="row">
<div class="col-2">
<jsp:include page="/WEB-INF/views/myPageSide.jsp"></jsp:include>
</div>
<div class="col-10">


<main class="form-userUp">
<form name="userUp" action="userUpdate.do" method="POST" enctype="multipart/form-data" onsubmit="return allCheck();">
<h1 class="h2 text-warning">회원정보 수정</h1>

	 <div>
	 	<label>	프로필 사진 
	 		<input type="file" name="upload" class="form-control"
		 		aria-label="profile" accept=".gif, .jpg, .png" onchange="setThumbnail(event);"	style="display:none">
			 <div id="image_container" height="150" width="300">
		 		<img src="/hobbycampus/hobbyImg/userImg/${dto.u_img}" alt="이미지">
		 	 </div>
		 	</label>
		 	<input type="hidden" name="u_img" value="${dto.u_img}">
		 	<input type="hidden" name="u_email" value="${dto.u_email }">
		 	
	 	<div class="invalid-feedback">.jsp, png 파일만 가능합니다.</div>
	 </div> 
	 
		<br>
	<div class="form-floating">
		  <input type="text" name="u_name" value="${u_name}" placeholder="닉네임" class="form-control"  
		  		id="validationName"  pattern="^[a-zA-Z가-힣0-9]{1,10}$"  onkeyup="userNameCheck()">
		  <label for="validationName" >이름</label>
		<!-- <input type="button" value="사용가능 여부" class="w-100 btn btn-lg btn-warning"> -->
		<div class="invalid-feedback">
	 	 	사용할 수 없는 닉네임입니다.
	    </div>
		<div class="valid-feedback">
	 	 	사용 가능한 닉네임입니다.
	    </div>
	</div>	
		
		<div id="msg" class="mt-3 mb-3 text-danger">  &nbsp;</div>
		
	<div class="col-12">
	   <label for="validationTel" class="form-label">핸드폰번호</label>
	 	<input type="text" name="u_tel" maxlength="11" value="${dto.u_tel}" pattern="^01(0|1|6|7|8|9){1}[0-9]{7,8}" 
	    	class="form-control" id="validationTel" onkeyup="checkTel()" required> 
	    <div class="invalid-feedback">
	 	   01로 시작하는 핸드폰 번호만 입력 가능합니다.
	    </div>
	    <div class="valid-feedback">
	 	   사용 가능합니다.
	    </div>
	</div>    
	
  <div class="col-12">
	    <label for="validationPwd" class="form-label">비밀번호 변경</label>
	    <input type="password" name="u_pwd" maxlength="12"  onkeyup="checkPwd()" pattern="[a-zA-Z0-9]{6,12}" 
	    	class="form-control" id="validationPwd" required> 
	    <div class="invalid-feedback">
	 	   비밀번호는 6 ~12 글자의 숫자, 영문 가능합니다.
	    </div>
	    <div class="valid-feedback">
	 	   비밀번호 사용 가능합니다.
	    </div>
  </div>
  
		 <div>&nbsp;</div>

	<div>
		<input type="submit" value="정보 수정" class="w-100 btn btn-lg btn-warning"><br>
	</div>
</form>
<hr>


<div>
	<input type="button" value="회원탈퇴" class="w-100 btn btn-lg btn-danger" onclick="userDel();">
</div>

</main>
</div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script>
var timer;
function userNameCheck(){
		var userName = document.userUp.u_name.value;
		var nameReg=/^[a-zA-Z가-힣0-9]{1,10}$/;
		
		console.log(userName);
		
		$('#validationName').removeClass('is-invalid');
		$('#validationName').removeClass('is-valid');
		
		if(userName===""||!nameReg.test(userName)){
			$('#validationName').removeClass('is-valid');
			$('#validationName').addClass('is-invalid');
			return;
		} else {
			
		$.ajax({
			type: "GET",
			url: "userNameCheck.do",
			data: {'name':userName},
			dataType: 'json',
			success: function(result){ 
				$('#validationName').removeClass('is-invalid');
				$('#validationName').removeClass('is-valid');
			
				console.log($('#validationName').attr('class'));
				//msg From controller (addObject)
				if(result.result==0){
					$('#validationName').removeClass('is-invalid');
					$('#validationName').addClass('is-valid');
					console.log($('#validationName').attr('class'));
				} else {
					$('#validationName').removeClass('is-valid');
					$('#validationName').addClass('is-invalid');
					console.log($('#validationName').attr('class'));
				}
			console.log(); // msg
			}
		});
}}

function checkPwd(){
	clearTimeout(timer);
	timer=setTimeout(function validate(){

	var pwd1=document.userUp.u_pwd.value;
	var pwdReg=/[a-zA-Z0-9]{6,12}/;
	
	$('#validationPwd').removeClass('is-valid');
	$('#validationPwd').removeClass('is-invalid');

	
	if(pwd1.length>=6&&pwdReg.test(pwd1)){
		$('#validationPwd').addClass('is-valid');
	} else {
		$('#validationPwd').addClass('is-invalid');
	}

},500)}

function checkTel(){
	clearTimeout(timer);
	timer=setTimeout(function validate(){

		var tel=document.userUp.u_tel.value;
		var telReg=/^01(0|1|6|7|8|9){1}[0-9]{7,8}/;
		
		
		$('#validationTel').removeClass('is-invalid');
		$('#validationTel').removeClass('is-valid');
		
		if(tel===""||!telReg.test(tel)){
			$('#validationTel').removeClass('is-valid');
			$('#validationTel').addClass('is-invalid');
			return;
	
		} else {

			$.ajax({
				type: "GET",
				url: "userTelCheck.do",
				data: {'tel':tel},
				dataType: 'json',
				success: function(result){ 
					$('#validationTel').removeClass('is-invalid');
					$('#validationTel').removeClass('is-valid');
					console.log(result);
				
					//msg From controller (addObject)
					if(result.result==0){
						$('#validationTel').removeClass('is-invalid');
						$('#validationTel').addClass('is-valid');
						console.log($('#validationTel').attr('class'));
					} else {
						$('#validationTel').removeClass('is-valid');
						$('#validationTel').addClass('is-invalid');
						
					}
			console.log(); // msg
			}
		});
}
},500)}



function setThumbnail(event) { 
	var reader = new FileReader(); 
	reader.onload = function(event) { 
		var img = document.createElement("img"); 
		img.setAttribute("src", event.target.result);
		$('div#image_container').empty();
		document.querySelector("div#image_container").appendChild(img); 
	}; 
	reader.readAsDataURL(event.target.files[0]); }


function userDel(){
	var result=confirm("정말로 탈퇴하시겠습니까?");
	
	if(result){
		location.href="userDelete.do";
	} 
}


function allCheck(){
	var name=$('#validationName').attr('class');
	var pwd=$('#validationPwd').attr('class');
	var tel=$('#validationTel').attr('class');
	
	if(name=='form-control is-invalid' || pwd=='form-control is-invalid' || tel=='form-control is-invalid' ){
		return false;
	}

	var filename=document.userUp.upload.value;
	if (filename !== ""){
		filename=filename.substring(filename.length-3,filename.length);
		
		if(filename!='jpg'&&filename!='png'){
			window.alert('jpg, png 이미지만 업로드 가능합니다.');
			return false;
		}
	}
}


</script>
</body>
</html>