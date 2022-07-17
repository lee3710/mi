<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="semi.QA.*" %>
   <jsp:useBean id="qdao" class="semi.QA.QaDAO" scope="session"></jsp:useBean>
    
<%
String qref=request.getParameter("q_ref");
if(qref==null||qref.equals("")){
	qref="0";
}

int q_ref=Integer.parseInt(qref);

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/myweb/css/managerLayout.css" >

<script>
function QAopen(){	location.href='manager_QA.jsp'}

</script>
</head>


<body>
<section class="center">
<article class="ma1">
<h2>Q&A 글 작성</h2>
</article>

<form name="QAre" action="QAReply_ok.jsp">
<article class="ma2">
<table class="table">
	<tr>
		<th>작성자</th>
		<td>관리자가 들어올 것. <input type="hidden" name="id" value="관리자">
		<input type="hidden" name="q_ref" value="<%=q_ref %>"></td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td><input type="text" name="q_subject" size="80" required></td>
	</tr>

	<tr>
		<th>내용</th>
		<td><textarea name="q_content" rows="20" cols="80" required></textarea></td>
	</tr>
</table>
</article>
<article class="ma3">
<div align="right"><input type="button" value="목록가기" class="button" onclick='QAopen();'>
<input type="submit" value="답글달기" class="button"></div>
</article>
</form>
</section>

</body>
</html>