<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
		.form-userPwd {
			width: 100%;
			max-width: 400px;
			padding: 15px;
			margin: auto;
		}
  a{text-decoration:none; color:black;}

  </style>
<script type="text/javascript" src="js/httpRequest.js"></script>

</head>
<script>
var timer;


function emailCheck(){
	var userName = document.userPwdUpdate.u_email.value;
	
	if(userName==null||userName==""){
			window.alert('이메일 인증을 처음부터 진행해 주세요');
			window.self.close();
	}
}


function checkPwd(){
	clearTimeout(timer);
	timer=setTimeout(function validate(){

	var pwd1=document.userPwdUpdate.u_pwd.value;
	var pwd2=document.userPwdUpdate.u_pwdCheck.value;
	$('#validationPwd').removeClass('is-valid');
	$('#validationPwd2').removeClass('is-valid');
	$('#validationPwd').removeClass('is-invalid');
	$('#validationPwd2').removeClass('is-invalid');
	
	if(pwd1.length>=6) {		
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

function allCheck(){
	var pwd1=$('#validationPwd').attr('class');
	var pwd2=$('#validationPwd2').attr('class');

	
	if(pwd1!='form-control is-valid' || pwd2!= 'form-control is-valid' ){		
		return false;
	}
}


</script>
</head>
<body onload="emailCheck();">
<main class="form-userPwd">
 <h1 class="h3 mb-3 fw-normal"> 비밀번호 변경 </h1>
<form name="userPwdUpdate" action="userPwdUpdate.do" onsubmit="return allCheck()">

	<div>이메일 <input type="email" class="form-control" name="u_email" 
			value="${u_email}" readonly>
	</div>	
	
	
<div class="col-12">
	    <label for="validationPwd" class="form-label">비밀번호</label>
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
  </div>
  <div id="msg"> &nbsp;</div>
  <div>
  	<input type="submit" class="w-100 btn btn-warning btn-lg" value="비밀번호 변경" >
  </div>

</form>
</main>
</body>
</html>