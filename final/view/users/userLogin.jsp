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
  
    <!-- httpRequest Module  -->
    <script type="text/javascript" src="/hobbycampus/js/httpRequest.js"></script>
  <style>
		body {
			height: 100%;
			display: flex;
			align-items: center;
			text-align: center;
		}
		.form-signin {
			width: 100%;
			max-width: 400px;
			padding: 15px;
			margin: auto;
		}
		
  a{text-decoration:none; color:black;}  
  </style>
<script>

function inuserLogin(){
	var flag;
	var $useremail=document.userLogin.u_email.value;
	var $userpwd=document.userLogin.u_pwd.value;
	
	$.ajax({
		type: "POST",
		url: "userLogin.do",
		data:{'u_email':$useremail,'u_pwd':$userpwd},
		async:false,
		dataType: 'json',
		success: function(data){ //msg From controller (addObject)
			console.log(data.count);
			if(data.count!=3){
				console.log(data.count);
				document.all.msg.innerHTML=data.msg;

				flag=false;
			} else if(data.count==3){

				flag=true;
				console.log(data.count);
			}

		},
	});
	return flag;
}
</script>
</head>


<body>
<main class="form-signin">   
 <form name="userLogin" action="userLogin.do" method="POST" onsubmit="return inuserLogin(this);" >
	 <img class="mb-4" src="img/user.png" alt="유저" width="300" height="300">
    <h1 class="h3 mb-3 fw-normal">로그인</h1>
	
	 <div class="form-floating">
		<input type="email" name="u_email" value="${cookie.savemail.value}" class="form-control" id="floatingEmail" placeholder="name@example.com" >
 		<label for="floatingEmail">Email</label>
 	</div>
 	
 	
	<div class="form-floating">
	  <input type="password" name="u_pwd" class="form-control" 
	  	placeholder="password"  maxlength="12" pattern="[a-zA-Z0-9]{6,12}"   
	  	id="floatingPassword" placeholder="Password">
	  <label for="floatingPassword">Password</label>
	   <div class="invalid-feedback">
	 	   아이디 또는 비밀번호가 잘못되었습니다.
	    </div>
	</div>

	   
	<div class="checkbox mb-3">
		 <label>
		   <input type="checkbox" name="savemail" value="on" 
	 			${empty cookie.savemail.value?'':'checked'}> ID 기억하기
	 	  </label>
	</div>

   <div>
   	<input type="submit" class="w-100 btn btn-lg btn-warning" value="로그인"> 
  	</div>
    	<div id="msg" class="mt-5 mb-3 text-danger"> &nbsp;</div>
     <div>
  
   			<a href="userJoin.do">회원가입</a> |
			<a href="userEmailFindForm.do"> 아이디 찾기</a> |
			<a href="userPwdFind.do">비밀번호 찾기 </a>
		</div>
</form> 
</main>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>