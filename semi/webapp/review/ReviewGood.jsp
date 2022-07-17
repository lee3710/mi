<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="rdao" class="semi.review.ReDAO" scope="session"></jsp:useBean>
    <%
    String idx= request.getParameter("re_idx");
     if(idx==null||idx.equals("")){
    	 idx="0";
     }
     int re_idx=Integer.parseInt(idx);
     
     int count=rdao.ReviewGood(re_idx);
     
     String msg=count>0?"추천하였습니다.":"추천에 실패하였습니다.";
    %>    
<script>
	window.alert('<%=msg%>');
	location.href="Review.jsp";

</script>
    