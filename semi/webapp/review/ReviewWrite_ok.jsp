<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ page import="com.oreilly.servlet.*" %>
    <jsp:useBean id="rdto" class="semi.review.ReDTO"></jsp:useBean>
    <jsp:setProperty property="*" name="rdto"/>
  	<jsp:useBean id="rdao" class="semi.review.ReDAO" scope="session"></jsp:useBean>

<%

int count=rdao.reWrite(rdto);


String msg=count>0?"등록 완료되었습니다.":"등록에 실패하였습니다.";

%>    
<script>
	window.alert('<%=msg%>');
	location.href="Review.jsp";

</script>
    