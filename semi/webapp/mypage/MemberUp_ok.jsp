<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdto" class="semi.manager.ManagerDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="semi.manager.ManagerDAO"></jsp:useBean>

<%
int count = mdao.managerUpdate(mdto);
String msg = count > 0 ?"수정완료!":"수정실패!";
%>
<script>
	window.alert('<%=msg %>');
	window.close();
	location.href='managerMember.jsp';
</script>