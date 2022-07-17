<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="semi.QA.*" %>
   <jsp:useBean id="qdao" class="semi.QA.QaDAO" scope="session"></jsp:useBean>
    
<%
    

        String q_idx=request.getParameter("qa_idx");
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
function QADel(){ window.open('QADelete.jsp?qa_idx=<%=qa_idx%>','qadelete',)}

</script>
</head>


<body>

<h2>Q&A 글 수정</h2>
<section>
<article>
<form name="QAUp" action="QAUpdate_ok.jsp">
<table class="table">
	<tr>
		<th>작성자</th>
		<td><%=dto.getid() %>
		<input type="hidden" name="qa_idx" value="<%=qa_idx%>">
		
		</td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td><input type="text" name="q_subject" size="80" class="text" value="<%=dto.getQ_subject() %>" required></td>
	</tr>

	<tr>
		<th>내용</th>
		<td><textarea name="q_content" rows="20" cols="80" required><%=dto.getQ_content()%></textarea></td>
	</tr>
</table>


	<div align="right"><input type="submit" value="수정하기" class="button"></div>


</form>
</article>
</section>

</body>
</html>