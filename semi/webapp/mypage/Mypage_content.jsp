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

function QAUpopen(){location.href='QAUpdate.jsp?qa_idx=<%=qa_idx%>'}
function QADel(){ location.href='QADelete.jsp?qa_idx=<%=qa_idx%>'}


</script>
</head>


<body>
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



<div align="right">
<%
if(!(dto.getQ_lev()==1)){ %>
<input type="button" value="수정" class="button" onclick="QAUpopen();">
<input type="button" value="삭제" class="button" onclick="QADel();"></div>

<% }%>
</form>
</article>
</section>

</body>
</html>