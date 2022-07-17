<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="rdto" class="semi.review.ReDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="rdto"/>
    <jsp:useBean id="rdao" class="semi.review.ReDAO" scope="session"></jsp:useBean>
	    
<% 

int count=rdao.reUpdate(rdto);

String msg=count>0?"수정완료되었습니다.":"수정 불가합니다.";

%>
<script>
	window.alert('<%=msg%>');
	opener.location.reload();
	window.self.close();


</script>