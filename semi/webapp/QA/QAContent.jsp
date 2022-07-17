<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="semi.QA.*" %>    
<jsp:useBean id="qdao" class="semi.QA.QaDAO" scope="session"></jsp:useBean>    
 
<%
     String q_idx=request.getParameter("idx");
          if(q_idx==null||q_idx.equals("")){
          	q_idx="0";
          }

          int qa_idx=Integer.parseInt(q_idx);
          QaDTO dto=qdao.qaContent(qa_idx);
     %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/myweb/css/qareview.css">

<script>
function QAopen(){	location.href='Q&A.jsp'}


</script>
</head>


<body>
<%@ include file="//header2.jsp" %>
<h2>Q&A 글 확인</h2>
<section>
<article>
<form name="QAC">
<table class="table">
	<tr>
		<th>작성자</th>
		<td><%=dto.getid() %></td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td><%=dto.getQ_subject() %></td>
	</tr>

	<tr>
		<th>내용</th>
		<td><%=dto.getQ_content().replaceAll("\n", "<br>") %></td>
	</tr>
</table>



<div align="right"><input type="button" value="목록가기" class="button" onclick='QAopen();'></div>



</form>
</article>
</section>

<%@ include file="//footer.jsp" %>
</body>
</html>