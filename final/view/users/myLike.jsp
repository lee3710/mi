<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
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
	.form-like {
	
		width: 100%;
		max-width:800px;
		padding: 50px;
		margin: 20px auto;
		align-items: center;
		text-align: center;
		
	}
  a{text-decoration:none; color:black;}  
  
</style>             
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<div class="row">
	<!--  mypage Side -->
	<div class="col-2">
		<jsp:include page="/WEB-INF/views/myPageSide.jsp"></jsp:include>
	</div>

	<!--  like  -->
	<div class="col-10">
		<main class="form-like">
			<h1 class="h2 text-warning" text-align="center"> 내 찜 목록 보기<i class="bi bi-arrow-through-heart-fill"></i> </h1>
				<!-- like empty -->
				 <c:if test="${empty likeVo }">
					 <img src="img/users/bee.gif" alter="꿀벌" height="300" width="300"><br>
					 	<label> 찜한 강의가 없네요!! 강의를 둘러보시는 건 어때요? ^^</label>
				</c:if>
				
			<!--  like Ok -->	 
		<c:forEach var="vo" items="${likeVo}">
					
			<!-- For Each Area -->
			<div class="card border border-warning p-2" style="width: 40rem;" >
			
			<!--  review card header -->
				<div class="card-body">
					<div class="row">
						<div class="col-4">	
							<img src="/hobbycampus/hobbyImg/lesson/${vo.lesson_thumbnail}/thumbnail.jpg" class="card-img-top"  alt="강의섬네일" height="100" width="100"
						   				  onclick="javascript:location.href='lessonCont.do?lesson_idx=${vo.lesson_idx}'">
						 </div>
							
					
						<div class="col-6">
						         <h5 class="card-title" align="left">${vo.lesson_subj}</h5>     
								<p class="card-text" align="left">${vo.t_name}</p>
								
						</div>  
						
						<div class="col-2">
					   	 	<a href="javascript:likeDel('${vo.lesson_idx}')"><i class="bi bi-balloon-heart-fill text-warning fs-2"></i></a>
				   		</div>
					</div>
				</div>
			</div>
			<div> &nbsp;</div>
			</c:forEach>
		</main>
	<c:if test="${!empty likeVo }">${pageStr }</c:if></div>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script>
function likeDel(idx){
	
		var result=window.confirm('삭제하시겠습니까?');
		
		if(result){
			location.href='myLike.do?lesson_idx='+idx;
		}else{
			window.alert('취소되었습니다.');
		}	
}
</script>
</body>
</html>