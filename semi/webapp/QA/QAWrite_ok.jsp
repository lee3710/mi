<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="qdto" class="semi.QA.QaDTO"></jsp:useBean>
    <jsp:setProperty property="*" name="qdto"/>
    <jsp:useBean id="qdao" class="semi.QA.QaDAO"></jsp:useBean>
 <%
 int count=qdao.qaWrite(qdto);
  String msg=count>0?"등록 완료되었습니다.":"등록에 실패하였습니다.";
 %>
 
 
<script>
	window.alert('<%=msg%>');
	location.href='Q&A.jsp;'

</script>