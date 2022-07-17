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
   
    <link rel="stylesheet" href="/hobbycampus/css/main.css">
    
<style>  		
	#myreview fieldset{
		    display: inline-block;
		    direction: rtl;
		    border:0;
		}
		#myreview fieldset legend{
		    text-align: right;
		}
	
		#myreview input[type=radio]{
		    display: none;
		}
		#myreview label{
		    font-size: 2em;
		    color: transparent;
		    text-shadow: 0 0 0 #f0f0f0;
		}
		#myreview label:hover{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
		}
		#myreview label:hover ~ label{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
		}
		#myreview input[type=radio]:checked ~ label{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
		}


		.form-review {
			width: 100%;
			max-width: 800px;
			padding: 30px;
			margin: auto;
			align-items: center;
			text-align: center;
		}
		
		 .form-review a{text-decoration:none; color:black;}  
 .form-review a:hover{text-decoration:none; color:black;}
</style>

</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
<div class="row">
	<!-- mypage sied -->
	<div class="col-2">
		<jsp:include page="/WEB-INF/views/myPageSide.jsp"></jsp:include>
	</div>
	
	<!-- review  -->
	<div class="col-10">
		<main class="form-review">
			<a href="review.do">작성한 리뷰</a> | 
			<a href="unreview.do"><label class="text-warning fw-semibold">작성 가능한 리뷰</label></a>
				<div> &nbsp;</div>
				 <h1 class="h2 text-warning" text-align="center"> 작성가능한 리뷰<i class="bi bi-brush"></i> </h1>
				 
				 <!--  review empty -->
				 <c:if test="${empty reviewVo}">
					<img src="img/users/bee.gif" alter="꿀벌" height="300" width="300"><br>
					<label> 작성 가능한 리뷰가 없습니다 </label>
				</c:if>
				
				
				
		<c:forEach var="vo"  items="${reviewVo}">
				<div class="card border border-warning p-2" style="width: 40rem; ">
				  <div class="card-body">
						<div class="row">
								<div class="col-4">	
									<img src="/hobbycampus/hobbyImg/lesson/${vo.lesson_thumbnail}/thumbnail.jpg" class="card-img-top" alter="강의섬네일" weight="100" height="100" >
								</div>
							
								<div class="col-8">
								    <h5 class="card-title fw-semibold" align="left"  >${vo.lesson_subj}</h5>
								    <p class="card-text" align="left">${vo.t_name}</p>
								</div>
						</div>
					</div>	
					
				   <div class="card-footer" style="background-color:#FFFFFF">
					   <form name="myreview" action="insertReview.do" id="myreview">
					   <div class="star" align="left">
					  	 	<fieldset>
					   	   		<input type="radio" name="star_point" value="5" id="${vo.lesson_record_idx}1" required><label for="${vo.lesson_record_idx}1">★</label>
					   	   		<input type="radio" name="star_point" value="4" id="${vo.lesson_record_idx}2"><label for="${vo.lesson_record_idx}2">★</label>
					   	   		<input type="radio" name="star_point" value="3" id="${vo.lesson_record_idx}3"><label for="${vo.lesson_record_idx}3">★</label>
					   	   		<input type="radio" name="star_point" value="2" id="${vo.lesson_record_idx}4"><label for="${vo.lesson_record_idx}4">★</label>
					   			<input type="radio" name="star_point" value="1" id="${vo.lesson_record_idx}5"><label for="${vo.lesson_record_idx}5" >★</label>
							</fieldset>
								<div class="mb-3">
								    <textarea class="form-control" name="review_cont" 
								    		placeholder="리뷰를 남겨주세요"  required></textarea>
									<input type="hidden" name="lesson_record_idx" value="${vo.lesson_record_idx}">
									<div class="mb-3">
						    			<button class="w-100 btn btn-warning" type="submit">리뷰 작성하기</button>
									 </div>
								 </div>
						</div>
					</form>
				   </div>
				  </div>
				 <div>&nbsp;</div>
			</c:forEach>
				<div>
				<c:if test="${!empty reviewVo}">
			${pageStr }
			
			</c:if></div>
		</main>
	</div>
	</div>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script>
function LikeDel(idx){
	
	var result=window.confirm('삭제하시겠습니까?');
	
	if(result){
		location.href='deleteReview.do?reviewidx='+idx;
	}else{
		window.alert('취소되었습니다.');
	}	
}

</script>
</body>

</html>