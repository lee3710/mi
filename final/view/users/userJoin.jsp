<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hobbyCampus</title>
	<!-- Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<!-- JQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<!-- Title Icon -->
	<link href="img/main.ico" rel="shortcut icon" type="image/x-icon">
  <style>
		body {
			height: 100%;
			display: flex;
			align-items: center;
			text-align: center;
		}
		.form-userJoin {
			width: 100%;
			max-width: 400px;
			padding: 15px;
			margin: auto;
		}
		.form-userJoin a{text-decoration:none; color:orange;}

  img{width:300px;
	  height:150px;
	  object-fit:fill;
	  }  
  </style>
<script type="text/javascript" src="js/httpRequest.js"></script>

</head>

<body onload="emailCheck();">
<main class="form-userJoin">

	 <h1 class="h3 mb-3 fw-normal"> 회원가입 </h1>
	
	<form name="usersJoin" action="userJoin.do" method="POST" enctype="multipart/form-data" 
		onsubmit="return allCheck();">


	<div>이메일 <input type="email" class="form-control" name="u_email" 
			value="${u_email}" readonly>
	</div>	

	 <div><label>	프로필 사진(사진 눌러서 변경!)<input type="file" name="upload" class="form-control"
	 		aria-label="profile" accept=".jpg, .png" onchange="setThumbnail(event);"
	 		style="display:none">
	 		<div id="image_container" height="150" width="300">
	 			<img src="img/user.png" alter="프로필 기본 이미지">
	 		</div>
	 		<div class="invalid-feedback">.jsp, png 파일만 가능합니다.</div>
	 </div> </label>
	 

	  <div class="col-12">
	    <label for="validationName" class="form-label">닉네임 (10글자 내 한글영문숫자)</label>
	   <input type="text" name="u_name" placeholder="닉네임을 입력해 주세요" onkeyup="userNameCheck()" 
	   	class="form-control" id="validationName" pattern="^[a-zA-Z가-힣0-9]{1,10}$" maxlength="10" required>
	    <div class="invalid-feedback">
	     	사용할 수 없습니다. 
	    </div>
	    <div class="valid-feedback">
	    	사용 가능한 닉네임입니다.
	    </div>
	    <div class="msg">&nbsp;</div>
	  </div>	
		 
	 
  <div class="col-12">
	    <label for="validationPwd" class="form-label">비밀번호 (6~12글자 숫자영문)</label>
	    <input type="password" name="u_pwd"  maxlength="12"  onkeyup="checkPwd()" pattern="[a-zA-Z0-9]{6,12}" 
	    	class="form-control" id="validationPwd" required> 
	    <div class="invalid-feedback">
	 	   비밀번호는 6 ~12 글자의 숫자, 영문 가능합니다.
	    </div>
	    <div class="valid-feedback">
	 	   비밀번호 사용 가능합니다.
	    </div>
  </div>
  
    <div class="col-12">
	    <label for="validationPwd2" class="form-label">비밀번호 확인</label>
	  <input type="password" name="u_pwdCheck"  onkeyup="checkPwd()"  maxlength="12" pattern="[a-zA-Z0-9]{6,12}" 
	    	class="form-control" id="validationPwd2" required> 
	    <div class="invalid-feedback">
	 	   비밀번호는 6 ~12 글자의 숫자, 영문 가능합니다. 비밀번호는 동일해야 합니다.
	    </div>
	   <div class="valid-feedback">
	 	  비밀번호 사용 가능합니다.
	    </div>
	    <div id="pwdCheck"> </div>
  </div>
  
     <div class="col-12">
	   <label for="validationTel" class="form-label">핸드폰번호(숫자만 입력)</label>
	 	<input type="text" name="u_tel" maxlength="11" pattern="^01(0|1|6|7|8|9){1}[0-9]{7,8}" 
	    	class="form-control" id="validationTel" placeholder ="01012345678" onkeyup="checkTel()" required> 
	    <div class="invalid-feedback">
	 	   01로 시작하는 핸드폰 입력 가능합니다.
	    </div>
	    <div class="valid-feedback">
	 	   사용 가능합니다.
	    </div>
  
  </div>

  <div>	성별 <input type="radio" name="u_gender" value="남자" checked> 남자
		<input type="radio" name="u_gender" value="여자"> 여자
	</div><div>
	<a href="javascript:window.open('userJoinPolicy.do','joinpolicy','width:600;height:600;')">이용약관, 개인정보 수집 및 이용</a>
			을 확인하였고 동의합니다. 
	</div><div>	<input type="submit" class="w-100 btn btn-warning btn-lg" value="회원가입" >
	</div>
	</form>
 </main>	
 
<script>
var timer;

function emailCheck(){
	var userName = document.usersJoin.u_email.value;
	
	if(userName==null||userName==""){
			window.alert('이메일 인증을 처음부터 진행해 주세요');
			window.self.close();
	}
}


function setThumbnail(event) { 
	var reader = new FileReader(); 
	reader.onload = function(event) { 
		var img = document.createElement("img"); 
		img.setAttribute("src", event.target.result); 
		document.querySelector("div#image_container").appendChild(img); 
	};
	reader.readAsDataURL(event.target.files[0]); 
}




function userNameCheck(){
		clearTimeout(timer);
		timer=setTimeout(function validate(){
	
			var userName = document.usersJoin.u_name.value;
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
	}},500)}






function checkPwd(){
	clearTimeout(timer);
	timer=setTimeout(function validate(){

	var pwd1=document.usersJoin.u_pwd.value;
	var pwd2=document.usersJoin.u_pwdCheck.value;
	var pwdReg=/[a-zA-Z0-9]{6,12}/;
	
	$('#validationPwd').removeClass('is-valid');
	$('#validationPwd2').removeClass('is-valid');
	$('#validationPwd').removeClass('is-invalid');
	$('#validationPwd2').removeClass('is-invalid');
	
	if(pwd1.length>=6&&pwdReg.test(pwd1)) {		
			$('#validationPwd').addClass('is-valid');
		if(pwd1==pwd2){
			$('#validationPwd2').addClass('is-valid');	
		} else {
			$('#validationPwd2').addClass('is-invalid');	
		}
	} else {
		$('#validationPwd').addClass('is-invalid');
		$('#validationPwd2').addClass('is-invalid');
	
	}
},500)}



function checkTel(){
		clearTimeout(timer);
		timer=setTimeout(function validate(){
	
			var tel=document.usersJoin.u_tel.value;
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


 function fileCheck(){
		var filename=document.usersJoin.upload.value;
		filename=filename.substring(filename.length-3,filename.length);
		
		if(filename!='jpg'&&filename!='png'&&filename!='gif'){
			window.alert('jpg, png, gif 이미지만 업로드 가능합니다.');
			return false;
		}
	 
 }
 
 

function allCheck(){
	var name=$('#validationName').attr('class');
	var pwd1=$('#validationPwd').attr('class');
	var pwd2=$('#validationPwd2').attr('class');
	var tel=$('#validationTel').attr('class');
	
	if(name!='form-control is-valid' || pwd1!='form-control is-valid' || 
			pwd2!= 'form-control is-valid' || tel!='form-control is-valid' ){
			
		return false;
	}

	var filename=document.usersJoin.upload.value;
	if (filename !== ""){
		filename=filename.substring(filename.length-3,filename.length);
		
		if(filename!='jpg'&&filename!='png'){
			window.alert('jpg, png 이미지만 업로드 가능합니다.');
			return false;
		}
	}
	
}

</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>

</html>