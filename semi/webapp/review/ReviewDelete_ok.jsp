<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:useBean id="rdao" class="semi.review.ReDAO" scope="session"></jsp:useBean>
<%
String idx=request.getParameter("re_idx");
int re_idx=Integer.parseInt(idx);
int count=rdao.reDelete(re_idx);

String msg=count>0?"삭제 완료되었습니다.":"삭제 불가합니다.";
%>
<script>
	window.alert('<%=msg%>');
	window.self.close();
	opener.location.reload();

</script>