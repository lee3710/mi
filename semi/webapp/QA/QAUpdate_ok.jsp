<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="qdto" class="semi.QA.QaDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="qdto"/>
    <jsp:useBean id="qdao" class="semi.QA.QaDAO" scope="session"></jsp:useBean>
	    
<%
	    int count=qdao.qaUpdate(qdto);

	    String msg=count>0?"수정완료되었습니다.":"수정 불가합니다.";
	    %>
<script>
	window.alert('<%=msg%>');
	window.self.close();

</script>