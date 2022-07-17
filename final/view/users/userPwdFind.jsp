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
		.form-pwdSer {
			width: 100%;
			max-width: 400px;
			padding: 15px;
			margin: auto;
		}
  a{text-decoration:none; color:black;}  
  </style>
</head>
<script>
function fnuserPwdFind(){
	var $useremail=document.userPwdFind.u_email.value;

	$.ajax({
		type: "get",
		url: "userPwdSend.do",
		data:{'email':$useremail},
		dataType: 'json',
		success: function(msg){ //msg From controller (addObject)
			document.getElementById('msg').innerHTML=msg.msg;
			
			if(msg.result==="true"){
				window.alert('인증 메일을 확인해 주세요');
				window.self.close();
			}

		},
	});
}
</script>

</head>
<body>
<main class="form-pwdSer"> 
<img src="img/users/bee.gif" class="mb-4" alt="꿀벌 이미지" width="300" height="300">
<form name="userPwdFind">
<h1 class="h3 mb-3 fw-normal">비밀번호 찾기</h1>

	<div class="form-floating">
	  <input type="email" name="u_email" placeholder="email" class="form-control" id="floatingInput" placeholder="email">
	  <label for="floatingPassword">이메일 인증</label>
	</div>

   <div>
    	<input type="button" class="w-100 btn btn-lg btn-warning" value="메일 인증하기" onclick="fnuserPwdFind()">
 	</div>
    	<div id="msg" class="mt-5 mb-3 text-danger"> 비밀번호 찾기를 진행해 주세요 &nbsp;</div>
     <div>
        	<a href="userLogin.do"> 로그인 </a> |
   			<a href="userJoin.do">회원가입</a> |
			<a href="userEmailFindForm.do"> 아이디 찾기</a> |
			<a href="userPwdFind.do">비밀번호 찾기 </a>
		</div>

</form>
</main>
</body>
</html>