<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--<script src="/hobbycampus/js/myLesson.js"></script>  -->
<!-- Title Icon -->
<link href="img/main.ico" rel="shortcut icon" type="image/x-icon">
<!--BootStarp-->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
   crossorigin="anonymous">
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
   crossorigin="anonymous"></script>
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<!--  
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
-->
<!--CSS-->
<link rel="stylesheet" href="/hobbycampus/css/main.css">
<link rel="stylesheet" href="/hobbycampus/css/pointShop.css">
<script src="/hobbycampus/js/lib/ajax.js"></script>
</head>
<body>
<!-- HEADER -->
   <jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
   <!-- SIDEBar -->
   <main class="mainArea">
      <div class="row">
         <div class="col-md-2">
            <jsp:include page="/WEB-INF/views/myPageSide.jsp"></jsp:include>
         </div>
         <!-- main -->
         <div class="col-md-10">
            <!-- body -->
   <div class="container">
      <div id="wrap">
         <h2>
            <span class="hb_yellow" id="param-data" data-param="${lessonRecordState}">내 수강 내역 <i class="bi bi-bank2"></i></span>
         </h2>
         <br>
         <div>
            <input type="button" name="list_bt" value="전체 목록" id="btn-1" class="btn btn-outline-warning ${lessonRecordState=='전체 목록'? 'active' : ''}${empty lessonRecordState? 'active' : ''}" 
               onclick="$myLesson.goWithFilter(this)"> <input
               type="button" name="lesson_bt" value="수업" id="btn-2"
               class="btn btn-outline-warning ${lessonRecordState=='수업'? 'active' : ''}"
               onclick="$myLesson.goWithFilter(this)"> <input
               type="button" name="reser_bt" value="예약" id="btn-3"
               class="btn btn-outline-warning ${lessonRecordState=='예약'? 'active' : ''}"
               onclick="$myLesson.goWithFilter(this)"> <input
               type="button" name="end_bt" value="완료" id="btn-4"
               class="btn btn-outline-warning ${lessonRecordState=='완료'? 'active' : ''}"
               onclick="$myLesson.goWithFilter(this)"> <input
               type="button" name="cencel_bt" value="취소" id="btn-5"
               class="btn btn-outline-warning ${lessonRecordState=='취소'? 'active' : ''}"
               onclick="$myLesson.goWithFilter(this)">
         </div>
         <br>
         <!--lesson_record_state of user  -->      
         <c:choose>
            <c:when test="${empty lessonRecordList}">
         <hr class="text-warning"><p align="center" class="text-warning">해당 수강 내역이 없습니다.</p>
            </c:when>
         <c:otherwise>
      <div>
      <div class="row row-cols-1 row-cols-md-2 g-4 ">
      <c:forEach items="${lessonRecordList}" var="lessonRecord">

         <div class="card mb-3 border border-warning" style="max-width: 540px;">
  <div class="row g-0">
       <div class="col-md-4 ">
         <img src="/hobbycampus/hobbyImg/lesson/${lessonRecord.lesson_thumbnail }/thumbnail.jpg" class="img-fluid rounded-start" alt="...">

       </div>
    <div class="col-md-8 ">
    <div class="card-body ">
          <span class="lesson_record_state "><i class="bi bi-list-stars"></i> ${lessonRecord.lessonRecordState}</span>
        <h5 class="card-title fw-bolder" id="lessonSubj" >${lessonRecord.lessonSubj}</h5>
      <div class="lesson_record_state">${lessonRecord.lesson_type}
      <c:if test="${lessonRecord.lesson_type=='온라인'}"><i class="bi bi-camera-reels"></i></i>
          <button type="button" class="btn btn-warning fs-6" data-bs-toggle="modal" data-bs-target="#onlineVideo" id="videoClick">
            <div>강의보기
             <span id="videoPath" style="visibility: hidden; font-size: 0px" data-thum="${lessonRecord.lesson_thumbnail}" > ${lessonRecord.lesson_thumbnail}</span> 
            </div>
         </button>
      </c:if>
      </div>
      <hr>
        <p class="card-text fw-bolder text-black-50 fs-6">강사명 <i class="bi bi-mortarboard-fill"></i></p>
        <p class="card-text fw-bolder fs-5">${lessonRecord.tName}</p>      
        <c:if test="${lessonRecord.lesson_type!='온라인'}">
           <p class="card-text fw-bolder text-black-50 fs-6">스케쥴 <i class="bi bi-calendar-check"></i></i></p>
         <p class="card-text fw-bolder fs-5">${lessonRecord.lessonStart} : ${lessonRecord.lessonTime}</p>
      </c:if>
        <a href="lessonCont.do?lesson_idx=${lessonRecord.lessonIdx}" class="btn btn-warning">상세 보기</a>
      
     
        <p class="card-text"><small class="text-muted">강의 구매날짜: ${lessonRecord.lessonBuyDate}</small></p>
   </div>
    </div>
   </div>
   </div>
   </c:forEach>
   </div>
 </div>
</c:otherwise>
</c:choose>
</div>
</div>
</div>
</div>

   <!-- MODAL -->
   <div class="modal fade" id="onlineVideo" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg"">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">online video</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body ">
        <div id="playVideo">
        </div>
      </div>
    </div>
  </div>
</div>

</body>
<!-- FOOTER -->
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>


   <script>
   $('#videoClick').click(function(){
      var $thumb = $('#videoPath').attr('data-thum');
      var setVideo = '<video controls ><source controlsList="nodownload" type="video/mp4" src="/hobbycampus/hobbyImg/lesson/'+$thumb+'/video/online.mp4"></video>';
      $('#playVideo').empty();
      $('#playVideo').append(setVideo);
   });

$myLesson = {
      goWithFilter: function(e){
         
         var url = "/hobbycampus/mylessonList.do"
         if(e.value != '전체 목록'){
            url += "?lessonRecordState=" +encodeURIComponent(e.value); 
         }
         location.href = url;
      }
   }
</script>
</html>