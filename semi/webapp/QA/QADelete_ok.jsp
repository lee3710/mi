<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:useBean id="qdao" class="semi.QA.QaDAO" scope="session"></jsp:useBean>
<%
String idx=request.getParameter("qa_idx");
int qa_idx=Integer.parseInt(idx);
int count=qdao.qaDelete(qa_idx);

String msg=count>0?"삭제 완료되었습니다.":"삭제 불가합니다.";
%>
<script>
	window.alert('<%=msg%>');
	opener.location.reload();	
	window.self.close();

	
</script>