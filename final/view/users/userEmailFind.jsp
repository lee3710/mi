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
		.form-EmailFind {
			width: 100%;
			max-width: 400px;
			padding: 15px;
			margin: auto;
		}
  a{text-decoration:none; color:black;}  
  </style>
  <script>
  function userEmailCheck(){
	var $usertel=document.userEmailFind.u_tel.value;
	var $usergender = $('input[name=u_gender]:checked').val();
	console.log($usergender);
	console.log($usertel);
	
	$.ajax({
		type: "get",
		url: "userEmailFind.do",
		data:{'u_tel':$usertel,'u_gender':$usergender},
		dataType: 'json',
		success: function(data){ //msg From controller (addObject)
			console.log(data.msg);
			document.getElementById('msg').innerHTML=data.msg;

		},
	});
}

	</script>
</head>
<body>
<main class="form-EmailFind"> 
<form name="userEmailFind">
<img src="img/users/bee.gif" class="mb-4" alt="꿀벌 이미지" width="300" height="300">
<h1 class="h3 mb-3 fw-normal">아이디 찾기</h1>

	<div class="form-floating">
	  <input type="tel" name="u_tel" placeholder="01012345678" class="form-control" id="floatingTel">
	  <label for="floatingTel">핸드폰 01012345678</label>
	</div>
	<div>

	<label>성별</label>
	 <input type="radio" name="u_gender" value="남자" checked> 남자
		<input type="radio" name="u_gender" value="여자"> 여자
	</div>

   <div>
    	<input type="button" class="w-100 btn btn-lg btn-warning" value="메일 찾기"
    		onclick="userEmailCheck();">
 	</div>
    	<div id="msg" class="mt-5 mb-3 text-danger">   &nbsp;</div>
 
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